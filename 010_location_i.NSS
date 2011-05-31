#include "acr_list_i"
#include "nwn2_inc_spells"
#include "acr_1984_i"

const int LOCATION_HEARTBEATS_PER_POLL = 2;
const float HEARTBEAT_TIME = 6.0;
const float LOCATION_POLLING_TIME = LOCATION_HEARTBEATS_PER_POLL*HEARTBEAT_TIME;
const float RUN_LIMIT = 2.8;
const int TICK_LIMIT = 15;

const string CHECK_COLOUR1 = "<color=#98FFFF>";
const string CHECK_COLOUR2 = "<color=#0166FF>";
const string CHECK_COLOUR_END = "</c>";

string loc_global_name(object o, string str)
{
	return str+"_"+GetName(o);
}

string loc_format_check(object creature, string stat, int roll, int mod, int dc)
{
	string res = "success";
	
	if ((roll+mod) < dc)
		res = "failure";
		
	return 	CHECK_COLOUR1 + GetName(creature) + CHECK_COLOUR_END +
			CHECK_COLOUR2 + " : "+stat+" : *"+res+"* : "+
	 		"(" + IntToString(roll)+" + "+IntToString(mod)+
			" = "+IntToString(roll+mod)+" vs. DC: "+
			IntToString(dc)+")"+CHECK_COLOUR_END;
}

void loc_damage_player(object player, int time)
{
	int roll,dc,mod,tmp;
	string str;
	effect e;
	
	/* replace with logging for now */
	ACR_LogEvent(player, ACR_LOG_ACTIVATE, ACR_SQLEncodeSpecialChars(GetPCPlayerName(player))+" ran with PC: "+ACR_SQLEncodeSpecialChars(GetName(player)));

    SendMessageToAllDMs(GetName(player)+" is running for an extended period in "+GetName(GetArea(OBJECT_SELF)));
	
	return;
	
	dc = 10+time;
	mod = GetAbilityModifier(ABILITY_CONSTITUTION, player);
	roll = d20();
	
	SendMessageToPC(player, loc_format_check(player,"Constitution",roll,mod,dc));
	
	if ((roll+mod) < dc) {
		ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(d6()), player);
		
		SendMessageToPC(player, "The forceful pace you have taken wears on you.");
		str = loc_global_name(player,"fatigue");
		tmp = GetGlobalInt(str);
		
		switch (tmp) {
			case 0:
				e = EffectFatigue();
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, e, player);
				break;
			case 1:
				/* clear fatigue */
				e = GetFirstEffect(player);
				
				while (GetIsEffectValid(e)) {
					if ((GetEffectType(e) == 49) && (GetEffectSubType(e) == 24)) {
						RemoveEffect(player, e);
						break;
					}
					e = GetNextEffect(player);
				}
				
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectExhausted(), player);
				break;
			default:
		}
		
		SetGlobalInt(str, tmp+1);
	}
}

void loc_update_player(object player)
{
	location l;
	object area;
	float dist,vel;
	int tick;
	string str;
	
	tick = GetGlobalInt("loc_hb_tick");
	tick++;
	SetGlobalInt("loc_hb_tick",tick);
	
	if (tick < LOCATION_HEARTBEATS_PER_POLL)
		return;
		
	SetGlobalInt("loc_hb_tick",0);
	
	l = GetLocation(player);
	area = GetLocalObject(player, "loc_last_area");
	
	/* calculate velocity and set as globals to prevent abuse */
	if (area == GetArea(player)) {
	
		dist = fabs(GetDistanceBetweenLocations(l,GetLocalLocation(player, "loc_last_loc")));
		vel = dist/LOCATION_POLLING_TIME;

		str = loc_global_name(player,"loc_tick");
		tick = GetGlobalInt(str)+1;
		SetGlobalInt(str, tick);
		
		str = loc_global_name(player,"loc_speed");
		vel += GetGlobalFloat(str);
		SetGlobalFloat(str, vel);
		
		/* check velocity */
		if (tick >= TICK_LIMIT) {
		
			/* running, increase fatigue */
			if (vel/tick > RUN_LIMIT) {
				str = loc_global_name(player,"loc_fatigue");
				SetGlobalInt(str, GetGlobalInt(str)+1);
				
				loc_damage_player(player, GetGlobalInt(str));
			}
			/* stopped, reset fatigue */
			else {
				str = loc_global_name(player,"loc_fatigue");
				SetGlobalInt(str, 0);
			}
			
			str = loc_global_name(player,"loc_tick");
			SetGlobalInt(str, 0);
			
			str = loc_global_name(player,"loc_speed");
			SetGlobalFloat(str, 0.0);
		}
	}
	
	SetLocalObject(player, "loc_last_area", GetArea(player));
	SetLocalLocation(player, "loc_last_loc", l);
}

void loc_update_players()
{
	int first,i;
	string id = "players";
	object o;
	
	first = get_first_index(id);
	i = first;
	
	do {
		i = get_next_index(id, i);
		o = get_element_object(id, i);
		
		if (GetIsObjectValid(o))
			loc_update_player(o);
		
	} while (first !=i);
	
}
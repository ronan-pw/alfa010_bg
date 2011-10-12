#include "acr_list_i"
//#include "acr_effects_i"
//#include "acr_1984_i"

const int LOCATION_HEARTBEATS_PER_POLL = 1;
const float HEARTBEAT_TIME = 6.0;
float LOCATION_POLLING_TIME = LOCATION_HEARTBEATS_PER_POLL*HEARTBEAT_TIME;
const float RUN_LIMIT_FACTOR = 0.8;
const int TICK_LIMIT = 25;

const float STD_SPEED = 4.0;

const float MONK_SPEED_BONUS = 0.1;
const float BARB_SPEED_BONUS = 0.1;
const float WOOD_SPEED_BONUS = 0.1;

const int MONK_LVL_PER_BONUS = 3;

const int HASTE_SPEED_FACTOR = 2;
const int EXPED_RET_SPEED_FACTOR = 2;

const string CHECK_COLOUR1 = "<color=#98FFFF>";
const string CHECK_COLOUR2 = "<color=#0166FF>";
const string CHECK_COLOUR_END = "</c>";

/* calculates monk, barb bonus, does simple kludge for woodland stride
 * (assumption is always active)
 */
void loc_cache_speed(object player)
{
	float factor = 1.0;
	int monk_lvs=GetLevelByClass(CLASS_TYPE_MONK,player),barb_lvs=GetLevelByClass(CLASS_TYPE_BARBARIAN,player);
	
	factor *= 1.0 + (MONK_SPEED_BONUS*IntToFloat(monk_lvs/MONK_LVL_PER_BONUS));
	factor *= 1.0 + (BARB_SPEED_BONUS*IntToFloat(barb_lvs > 0));
	factor *= 1.0 + (WOOD_SPEED_BONUS*IntToFloat(GetHasFeat(FEAT_WOODLAND_STRIDE, player) > 0));
	
	SetLocalFloat(player,"speed_factor",factor);
}

string loc_global_name(object o, string str)
{
	return str+"_"+GetName(o);
}

float get_std_speed(object player)
{
	float factor = GetLocalFloat(player,"speed_factor"), tmp_factor = 1.0;
	effect e = GetFirstEffect(player);
	
	while (GetIsEffectValid(e)) {
		switch (GetEffectSpellId(e)) {
			case SPELL_HASTE:
				tmp_factor *= HASTE_SPEED_FACTOR;
				break;
			case SPELL_EXPEDITIOUS_RETREAT:
				tmp_factor *= EXPED_RET_SPEED_FACTOR;
				break;
			default:
		}
			
		e = GetNextEffect(player);
	}
	
	return STD_SPEED * factor * tmp_factor;
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

/*
void loc_damage_player(object player, int time)
{
	int roll,dc,mod,tmp;
	string str;
	effect e;
	
	dc = 10+time;
	mod = GetAbilityModifier(ABILITY_CONSTITUTION, player);
	roll = d20();
	
	SendMessageToPC(player, loc_format_check(player,"Constitution",roll,mod,dc));
		
	if ((roll+mod) < dc) {
		
		ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(d6()), player);
		
		SendMessageToPC(player, "The forceful pace you have taken wears on you.");
		str = loc_global_name(player,"fatigue");
		tmp = GetGlobalInt(str);
		
		// TODO: Change so this accepts fatigue from _any_source and changes to exhaustion
		// ALSO: Create central fatigue function that automatically handles this,
		// so exhaustion is always correctly added
		
		switch (tmp) {
			case 0:
				//ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectFatigue(), player);
				break;
			case 1:
				// clear fatigue 
				e = GetFirstEffect(player);
				
				while (GetIsEffectValid(e)) {
				
					if (is_fatigue_effect(e)) {
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
}*/

void loc_update_player(object player)
{
	location l;
	object last_area, cur_area;
	float dist,vel,vel_ratio;
	int tick, is_interior;
	string str,msg;
	
	cur_area = GetArea(player);
		
	/* for simplicity's sake, eliminate calculation of interior/invalid areas as well */
	if ((!GetIsObjectValid(cur_area)) || GetIsAreaInterior(cur_area))
		return;
	
	tick = GetGlobalInt("loc_hb_tick");
	tick++;
	SetGlobalInt("loc_hb_tick",tick);
	
	if (tick < LOCATION_HEARTBEATS_PER_POLL)
		return;
		
	SetGlobalInt("loc_hb_tick",0);
	
	l = GetLocation(player);
	last_area = GetLocalObject(player, "loc_last_area");
	
	/* calculate velocity and set as globals to prevent abuse */
	if (last_area == cur_area) {
	
		dist = fabs(GetDistanceBetweenLocations(l,GetLocalLocation(player, "loc_last_loc")));
		vel = dist/LOCATION_POLLING_TIME;
		
		/* vel_ratio = current/max */
		vel_ratio = vel/get_std_speed(player);

		str = loc_global_name(player,"loc_tick");
		tick = GetGlobalInt(str)+1;
		SetGlobalInt(str, tick);
		
		str = loc_global_name(player,"loc_speed");
		vel_ratio += GetGlobalFloat(str);
		SetGlobalFloat(str, vel_ratio);
		
		// SendMessageToPC(player," "+FloatToString(vel_ratio) + ", fatigue: "+IntToString(GetGlobalInt(str)));
		
		/* check velocity */
		if (tick >= TICK_LIMIT) {
			vel_ratio /= TICK_LIMIT;
		
			/* running, increase fatigue */
			if (vel_ratio > RUN_LIMIT_FACTOR) {
				str = loc_global_name(player,"loc_fatigue");
				SetGlobalInt(str, GetGlobalInt(str)+1);
				
				/* Do not do damage, simply log */
				//loc_damage_player(player, GetGlobalInt(str));
				
				msg = (GetName(player)+" is running for an extended period in "+GetName(GetArea(player)) + " {"+GetTag(GetArea(player)) + "} [" + FloatToString(vel_ratio) + "*" + FloatToString(get_std_speed(player)) + "]");
				
				SendMessageToAllDMs(msg);
				WriteTimestampedLogEntry(msg);
			}
			/* stopped, reset fatigue */
			else {
				str = loc_global_name(player,"loc_fatigue");
				SetGlobalInt(str, 0);
			}
			
			// SendMessageToPC(player,FloatToString(vel_ratio) + ", fatigue: "+IntToString(GetGlobalInt(str)));
			
			str = loc_global_name(player,"loc_tick");
			SetGlobalInt(str, 0);
			
			str = loc_global_name(player,"loc_speed");
			SetGlobalFloat(str, 0.0);
		}
	}
	
	SetLocalObject(player, "loc_last_area", cur_area);
	SetLocalLocation(player, "loc_last_loc", l);
}

void loc_update_players()
{
	int first,i;
	object pc;

	pc = GetFirstPC();
	
	while (GetIsObjectValid(pc)) {
		if (!GetIsDM(pc))
			loc_update_player(pc);

		pc = GetNextPC();
	}
}
#include "acr_list_i"
#include "acr_skills_i"
#include "acr_effects_i"
#include "nw_i0_spells"

const float SEC_PER_MIL = 1000.0;
const int TICK_LIMIT = 20;

// 50% faster than walk speed is fatigue barrier (pnp hustle speed, 60 ft/rd)
const float RUN_LIMIT_FACTOR = 0.75;

// Standard PC max speed, 4.0 m/sec (78.86 ft/rd)
const float STD_SPEED = 4.0;

const float LOC_EPS = 0.001;

const float MONK_SPEED_BONUS = 0.1;
const float BARB_SPEED_BONUS = 0.1;
const float WOOD_SPEED_BONUS = 0.1;
const float GORC_SPEED_BONUS = 0.1;

const int MONK_LVL_PER_BONUS = 3;

const float HASTE_SPEED_FACTOR = 2.0;
const float EXPED_RET_SPEED_FACTOR = 2.0;

const int FEAT_RACIAL_LONG_GAIT = 2248;

int time()
{
	int time;
	
	time = 12*GetCalendarYear();
	time = 28*(GetCalendarMonth()+time);
	time = 24*(GetCalendarDay()+time);
	time = 60*(GetTimeHour()+time);
	time = 60*(GetTimeMinute()+time);
	time = 1000*(GetTimeSecond()+time) + GetTimeMillisecond();

	return time;
}

/* calculates monk, barb bonus, does simple kludge for woodland stride
 * (assumption is always active)
 */
void loc_cache_speed(object player)
{
	float factor = 1.0;
	int monk_lvs=GetLevelByClass(CLASS_TYPE_MONK,player);
	
	factor *= 1.0 + (MONK_SPEED_BONUS*IntToFloat(monk_lvs/MONK_LVL_PER_BONUS));
	factor *= 1.0 + (BARB_SPEED_BONUS*IntToFloat(GetHasFeat(FEAT_BARBARIAN_ENDURANCE, player)));
	factor *= 1.0 + (WOOD_SPEED_BONUS*IntToFloat(GetHasFeat(FEAT_WOODLAND_STRIDE, player)));
	factor *= 1.0 + (GORC_SPEED_BONUS*IntToFloat(GetHasFeat(FEAT_RACIAL_LONG_GAIT, player)));
	
	SetLocalFloat(player,"loc_speed_factor",factor);
}

float loc_dist(vector a, vector b)
{
	return VectorMagnitude(Vector(a.x - b.x,a.y - b.y,0.0f));
}

float get_std_speed(object player)
{
	float factor = GetLocalFloat(player,"loc_speed_factor"), tmp_factor = 1.0;
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


void loc_damage_player(object player, int time)
{
	int tmp;
	effect e;

	// emulate Endurance via Toughness feat
	if (!ACR_StatCheck(ABILITY_CONSTITUTION, player, 10+time, TRUE, FALSE, GetHasFeat(FEAT_TOUGHNESS) * 4)) {
		ACR_ApplyNonlethalDamageToCreature(player, d6());
		
		SendMessageToPC(player, "The forceful pace you have taken wears on you.");
		ACR_AddFatigueToCreature(player);
	}
}

void loc_update_player(object player)
{
	location l,old_loc;
	object last_area, cur_area;
	float dist,vel,vel_ratio,t;
	int tick, is_interior, seq_tick;
	string msg;
		
	/* for simplicity's sake, eliminate calculation of interior/invalid areas as well */
	if (GetScriptHidden(player) || ((cur_area = GetArea(player)) == OBJECT_INVALID) || GetIsAreaInterior(cur_area)) {
		DeleteLocalLocation(player,"loc_last_loc");
		return;
	}
	
	l = GetLocation(player);
	old_loc = GetLocalLocation(player,"loc_last_loc");
	last_area = GetAreaFromLocation(old_loc);

	tick = time();

	/* ignore if we get here via dimension door */
	if (GetLocalInt(player,"DIMENSION_DOOR_USED")) {
		DeleteLocalInt(player,"DIMENSION_DOOR_USED");
		cur_area = OBJECT_INVALID;
	}
	
	if ((last_area == cur_area) && (last_area != OBJECT_INVALID)) {
		t = IntToFloat(abs(GetLocalInt(player,"loc_timer") - tick))/SEC_PER_MIL;
		dist = loc_dist(GetPositionFromLocation(l),GetPositionFromLocation(old_loc));

		vel = dist/t;
		
		/* vel_ratio = current/max */
		vel_ratio = vel/get_std_speed(player);

		if (vel_ratio > (1.0f + LOC_EPS)) {
			WriteTimestampedLogEntry(" "+GetName(player)+" calculated to travel "+GetTag(cur_area)+" in "+FloatToString(t) +" sec at faster than MAX_SPEED: "+FloatToString(vel_ratio));
			PrintVector(GetPositionFromLocation(l),1);
			PrintVector(GetPositionFromLocation(old_loc),1);
		}

		seq_tick = GetLocalInt(player,"loc_seq")+1;
		vel_ratio += GetLocalFloat(player,"loc_speed");

		SetLocalInt(player, "loc_seq", seq_tick);
		SetLocalFloat(player, "loc_speed", vel_ratio);
		
		// WriteTimestampedLogEntry(" "+GetName(player)+" "+FloatToString(vel_ratio) + ", fatigue: "+IntToString(GetLocalInt(player,"loc_fatigue")));
		
		/* check velocity */
		if (seq_tick >= TICK_LIMIT) {
			// WriteTimestampedLogEntry(GetName(player)+" checking ticks");
		
			vel_ratio /= TICK_LIMIT;
		
			/* running, increase fatigue */
			if (vel_ratio > RUN_LIMIT_FACTOR) {
				SetLocalInt(player, "loc_fatigue", GetLocalInt(player,"loc_fatigue")+1);
				
				loc_damage_player(player, GetLocalInt(player,"loc_fatigue"));
				
				msg = (GetName(player)+" is running for an extended period in "+GetName(GetArea(player)) + " {"+GetTag(GetArea(player)) + "} [" + FloatToString(vel_ratio) + "*" + FloatToString(get_std_speed(player)) + "]");
				
				SendMessageToAllDMs(msg);
				WriteTimestampedLogEntry(msg);
			}
			/* stopped, reset fatigue */
			else 
				SetLocalInt(player, "loc_fatigue", 0);
			
			
			SetLocalInt(player, "loc_seq", 0);
			SetLocalFloat(player, "loc_speed", 0.0);
		}
	}
	
	
	SetLocalLocation(player, "loc_last_loc", l);
	SetLocalInt(player, "loc_timer", tick);
}

void loc_update_players()
{
	int first,i;
	object pc;

	pc = GetFirstPC();
	
	while (GetIsObjectValid(pc)) {
		if (!GetIsDM(pc) && !GetIsDMPossessed(pc))
			DelayCommand(GetRandomDelay(0.1,1.1), loc_update_player(pc));

		pc = GetNextPC();
	}
}

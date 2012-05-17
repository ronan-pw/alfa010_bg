#include "acr_area_i"


/* location:

	0: bg
	1: beregost
	2: nashkel
*/

const int CARAVAN_LOC_BG	= 0;
const int CARAVAN_LOC_BERE	= 1;
const int CARAVAN_LOC_NASH	= 2;

/* caravan states:

   0 - unoccupied
   1 - loading
   2 - travel
   3 - unloading
*/

const int CARAVAN_STATE_EMPTY	= 0;
const int CARAVAN_STATE_LOAD	= 1;
const int CARAVAN_STATE_TRAVEL	= 2;
const int CARAVAN_STATE_UNLOAD	= 3;

const float CARAVAN_SHAKE_DELAY = 3.0f;

const int CARAVAN_TRAVEL_TICKS = 50;
const int CARAVAN_LOADING_TICKS = 9;
const int CARVAAN_UNLOADING_TICKS = 3;


string caravan_dest_name(int l)
{
	string str;

	switch (l) {
		case CARAVAN_LOC_BG:
			str = "Baldur's Gate";
			break;
		case CARAVAN_LOC_BERE:
			str = "Beregost";
			break;
		case CARAVAN_LOC_NASH:
			str = "Nashkel";
			break;
		default:
			str = "ERROR";
	}
	return str;
}

location caravan_dest_loc(int l)
{
	string str;

	switch (l) {
		case CARAVAN_LOC_BG:
			str = "caravan_bg";
			break;
		case CARAVAN_LOC_BERE:
			str = "caravan_beregost";
			break;
		case CARAVAN_LOC_NASH:
			str = "caravan_nashkel";
			break;
		default:
			str = "ERROR";
	}
	return GetLocation(GetWaypointByTag(str));
}

void caravan_message(string str, object o)
{
	SendChatMessage(o, OBJECT_INVALID, CHAT_MODE_TALK, str);
}

void let_out_players()
{
	object o;
	location l = GetLocalLocation(OBJECT_SELF, "dest_loc");

	// spit out @ start if this is rebooted
	if (l == LOCATION_INVALID)
		l = GetStartingLocation();

	for (ObjectToInt(o = GetFirstObjectInArea(OBJECT_SELF)); o != OBJECT_INVALID; ObjectToInt(o = GetNextObjectInArea()))
		if (GetIsPC(o))
			AssignCommand(o, ActionJumpToLocation(l));
}

void shake_players()
{
	object o;
	for (ObjectToInt(o = GetFirstObjectInArea(OBJECT_SELF)); o != OBJECT_INVALID; ObjectToInt(o = GetNextObjectInArea()))
		if (GetIsPC(o)) {
			ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_STRIKE_HOLY), GetLocation(o));
			DelayCommand(CARAVAN_SHAKE_DELAY,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_STRIKE_HOLY), GetLocation(o)));
		}
}

object get_car_wp(string tag)
{
	object o;
	for (ObjectToInt(o = GetFirstObjectInArea(OBJECT_SELF)); o != OBJECT_INVALID; ObjectToInt(o = GetNextObjectInArea()))
		if ((GetObjectType(o) == OBJECT_TYPE_WAYPOINT) && (GetTag(o) == tag))
			return o;
			
	return OBJECT_INVALID;
}


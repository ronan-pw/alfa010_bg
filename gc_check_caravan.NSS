#include "010_caravan_i"

int StartingConditional(int dest, int src)
{
    object oPC = GetPCSpeaker();
	object wp;
	object area;
	int state;

	return TRUE;
#if 0
	
	wp = GetWaypointByTag("inside_caravan");
	area = GetArea(wp);
	state = GetLocalInt(area,"state");
	
	if (	state == CARAVAN_STATE_TRAVEL || 
		state == CARAVAN_STATE_UNLOAD)
		return TRUE;
	
	if (	(state == CARAVAN_STATE_LOAD) &&
		(dest != GetLocalInt(area,"dest_index")) &&
		(src != GetLocalInt(area, "src_index")))
		return TRUE;
		
	return FALSE;
#endif
}

#include "010_caravan_i"


void main(int loc, int src_loc)
{
    object oPC = GetPCSpeaker();
	object wp;
	object area;
	string str, src_str;
	location l;
	
	wp = GetWaypointByTag("inside_caravan");
	area = GetArea(wp);

	DelayCommand(2.0,AssignCommand(oPC,ActionJumpToObject(wp)));
	SendMessageToPC(oPC, "You hop aboard the wagon.");
	
	switch (GetLocalInt(area,"state")) {
		case CARAVAN_STATE_EMPTY:
			SetLocalLocation(area, "dest_loc", caravan_dest_loc(loc));
			SetLocalString(area, "dest_name", caravan_dest_name(loc));
			SetLocalInt(area, "state", CARAVAN_STATE_LOAD);
			SetLocalInt(area, "dest_index", loc);
			SetLocalInt(area, "src_index", src_loc);
			
			break;
		case CARAVAN_STATE_LOAD:			
			break;
		default:
			SendMessageToPC(oPC, "ERROR, has already left");
	}
}

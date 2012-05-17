#include "010_caravan_i"


void main(int loc, int src_loc)
{
    object oPC = GetPCSpeaker();
	object area, tmp, wp;
	string str, src_str;
	location l;
	
	/* If there already exists a caravan, use it */
	area = find_caravan(loc, src_loc, CARAVAN_STATE_LOAD);

	/* otherwise, create another */
	if (area == OBJECT_INVALID) {
		area = GetObjectByTag("travel_caravan");
		tmp = ACR_GetInstancedAreaTemplate(area);

		if (tmp != OBJECT_INVALID)
			area = tmp;

		area = ACR_CreateAreaInstance(area);

		start_caravan_trip(area, loc, src_loc);
	}

	wp = GetLocalObject(area, "waypoint");
	
	DelayCommand(2.0, AssignCommand(oPC, ActionJumpToObject(wp)));
	SendMessageToPC(oPC, "You hop aboard the wagon.");
}

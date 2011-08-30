/* loc:

	0: bg
	1: beregost
	2: nashkel
*/

void main(int loc)
{
    object oPC = GetPCSpeaker();
	object wp;
	object area;
	string str;
	location l;
	
	wp = GetWaypointByTag("inside_caravan");
	area = GetArea(wp);

	DelayCommand(0.5,AssignCommand(oPC,ActionJumpToObject(wp)));
	SendMessageToPC(oPC, "You hop aboard the wagon.");
	
	switch (GetLocalInt(area,"state")) {
		case 0:
			switch (loc) {
				case 0:
					l = GetLocation(GetWaypointByTag("bgcity_docks"));
					str = "Baldur's Gate";
					break;
				case 1:
					l = GetLocation(GetWaypointByTag("TW09_BEREGOST"));
					str = "Beregost";
					break;
				default:
					l = GetLocation(GetWaypointByTag("TW15_TW14"));
					str = "Nashkel";
			}
			
			SetLocalLocation(area,"dest_loc",l);
			SetLocalString(area,"dest_name",str);
			
			break;
		case 1:			
			break;
		default:
			SendMessageToPC(oPC, "ERROR, has already left");
	}
}
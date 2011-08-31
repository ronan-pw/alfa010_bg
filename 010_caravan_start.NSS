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

	DelayCommand(2.0,AssignCommand(oPC,ActionJumpToObject(wp)));
	SendMessageToPC(oPC, "You hop aboard the wagon.");
	
	switch (GetLocalInt(area,"state")) {
		case 0:
			switch (loc) {
				case 0:
					l = GetLocation(GetWaypointByTag("caravan_bg"));
					str = "Baldur's Gate";
					break;
				case 1:
					l = GetLocation(GetWaypointByTag("caravan_beregost"));
					str = "Beregost";
					break;
				default:
					l = GetLocation(GetWaypointByTag("caravan_nashkel"));
					str = "Nashkel";
			}
			
			SetLocalLocation(area,"dest_loc",l);
			SetLocalString(area,"dest_name",str);
			SetLocalInt(area,"state",1);
			
			break;
		case 1:			
			break;
		default:
			SendMessageToPC(oPC, "ERROR, has already left");
	}
}
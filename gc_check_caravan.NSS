int StartingConditional(string dest)
{
    object oPC = GetPCSpeaker();
	object wp;
	object area;
	
	wp = GetWaypointByTag("inside_caravan");
	area = GetArea(wp);
	
	if (GetLocalInt(area,"state") > 1)
		return TRUE;
	
	if ((GetLocalInt(area,"state") == 1) && (dest != GetLocalString(area,"dest_name")))
		return TRUE;
		
	return FALSE;
}
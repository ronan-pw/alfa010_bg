int StartingConditional()
{
    object oPC = GetPCSpeaker();
	object wp;
	object area;
	
	wp = GetWaypointByTag("inside_caravan");
	area = GetArea(wp);
	
	if (GetLocalInt(area,"state") > 1)
		return TRUE;
		
	return FALSE;
}
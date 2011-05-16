
int StartingConditional()
{
    // returns whether the PC should be allowed to leave the start area.
    int nSubRace = GetSubRace(GetPCSpeaker());
	if ((nSubRace == RACIAL_SUBTYPE_AASIMAR) || (nSubRace == RACIAL_SUBTYPE_TIEFLING)) {
	    return FALSE;
	} else if ((nSubRace == RACIAL_SUBTYPE_AIR_GENASI) || (nSubRace == RACIAL_SUBTYPE_EARTH_GENASI) || (nSubRace == RACIAL_SUBTYPE_FIRE_GENASI) 
	  || (nSubRace == RACIAL_SUBTYPE_WATER_GENASI)|| (nSubRace == 46)) {
	    return FALSE;
	} else {
	    return TRUE;
	}
}
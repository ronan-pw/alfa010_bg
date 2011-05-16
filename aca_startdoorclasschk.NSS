
int StartingConditional()
{
    // returns whether the PC should be allowed to leave the start area.
	object oPC = GetPCSpeaker();
    int nSubRace = GetSubRace(oPC);
	if ((nSubRace == RACIAL_SUBTYPE_AASIMAR) || (nSubRace == RACIAL_SUBTYPE_TIEFLING)) {
		// check for token
		if(GetItemPossessedBy(oPC, "abr_it_ooc_planetouch_token") == OBJECT_INVALID) {
	    	return FALSE;
		} else {
			return TRUE;
		}
	} else if ((nSubRace == RACIAL_SUBTYPE_AIR_GENASI) || (nSubRace == RACIAL_SUBTYPE_EARTH_GENASI) || (nSubRace == RACIAL_SUBTYPE_FIRE_GENASI) || (nSubRace == RACIAL_SUBTYPE_WATER_GENASI)) {
		// check for token
		if(GetItemPossessedBy(oPC, "abr_it_ooc_planetouch_token") == OBJECT_INVALID) {
	    	return FALSE;
		} else {
			return TRUE;
		}
	//} else if (GetLevelByClass(CLASS_TYPE_WARLOCK, oPC)  || GetLevelByClass(CLASS_TYPE_FAVORED_SOUL, oPC)) {
	} else if  (GetLevelByClass(CLASS_TYPE_FAVORED_SOUL, oPC)) {
		// check for token
		if(GetItemPossessedBy(oPC, "abr_it_ooc_planetouch_token") == OBJECT_INVALID) {
	    	return FALSE;
		} else {
			return TRUE;
		}
	} else {
	    return TRUE;
	}
}
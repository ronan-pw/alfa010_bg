//handles assignment of a Mind Over Body token to anyone who has taken that feat.
// called by start door convo, before they enter the IC area of the module.
#include "acr_db_persist_i"

void main() {

    object oPC = GetPCSpeaker();
	if (GetHasFeat(FEAT_MIND_OVER_BODY, oPC)) {
	    // check if they have already been awarded the token
		if (ACR_GetPersistentInt(oPC, "ACR_FEAT_MINDOVERBODY_TOKEN") != TRUE) {
		    object oToken = CreateItemOnObject("abr_it_ooc_mindoverbody", oPC);
			if (oToken != OBJECT_INVALID) {
			    ACR_SetPersistentInt(oPC, "ACR_FEAT_MINDOVERBODY_TOKEN", TRUE);
			}
		}
	} 

}
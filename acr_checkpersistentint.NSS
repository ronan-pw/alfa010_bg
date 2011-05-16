// Generic script to check a persistent ACR integer, for use in conversation conditionals
//    Default checks whether the given variable is TRUE (=1) for the PCSpeaker.

#include "acr_db_persist_i"

int StartingConditional(string sVariableName, int sVariableValue=TRUE)
{   
	object oPC = GetPCSpeaker(); 

	if (ACR_GetPersistentInt(oPC, sVariableName) == sVariableValue) {
		return TRUE;
	} else {
		return FALSE;
	}

}
 
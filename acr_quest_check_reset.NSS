// Is this valid/reset?
#include "acr_time_i"

int StartingConditional(string plot)
{
    object oPC = GetPCSpeaker();
	string name = "i_rst_"+plot;
	int days = ACR_GetPersistentInt(oPC, name);
	
	return (ACR_GetGameDaysSinceStart() >= days);
}
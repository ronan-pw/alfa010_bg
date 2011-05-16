#include "acr_xp_i"
#include "acr_time_i"


void main(string plot, int gp, int xp, int reset_days)
{
    object oPC = GetPCSpeaker();
	string name = "i_rst_"+plot;
	int val = ACR_GetGameDaysSinceStart() + reset_days;
	
	GiveGoldToCreature(oPC,gp);
	ACR_AwardStaticQuestXP(oPC,plot,xp); 
   
	// Prevent re-doing until n days
	ACR_SetPersistentInt(oPC, name, val);
}
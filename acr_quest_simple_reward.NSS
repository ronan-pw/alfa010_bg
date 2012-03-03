#include "acr_xp_i"
#include "acr_time_i"


void main(string plot, int gp, int xp, float reset_days)
{
	object oPC = GetPCSpeaker();
	string name = "i_rst_"+plot;
	int val = ACR_GetGameDaysSinceStart();

	// val = RL days, converted into game days (truncate)
	val += FloatToInt(reset_days/ACR_GetGameToRealTimeRatio());
	
	GiveGoldToCreature(oPC,gp);
	ACR_AwardStaticQuestXP(oPC,plot,xp); 
   
	// Prevent re-doing until n days
	ACR_SetPersistentInt(oPC, name, val);
}

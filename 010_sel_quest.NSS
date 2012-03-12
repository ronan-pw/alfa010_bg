#include "acr_xp_i"

int GoldToXP(int nGold, object oPC)
{
	int nHD = GetHitDice(oPC);
	int nXP = nGold;
	if(nHD < 9)
	/* 1.25 gold/xp */
		nXP = (nXP*4)/5;
	else if(nHD < 13)
	/* 2.5 gold/xp */
		nXP = (nXP*2)/5;
	else if(nHD < 17)
	/* 5 gold/xp */
		nXP = nXP/5;
	else
	/* 10 gold/xp */
		nXP = nXP/10;
	return nXP;
}

void main(string sQuest, int nAct)
{
	object oPC = GetPCSpeaker();
	string sPC = GetName(oPC);
	if(GetStringLength(sPC) > 15)
		sPC = GetStringLeft(sPC, 15);
	if(sQuest == "ssil")
	{
		if(nAct == 1)
		/* Failed a quest that Ssil has given. */
			SetLocalInt(GetModule(), sPC+"SSIL_WORK", 1);
		else if(nAct == 2)
		/* Ssil has learned that the PC is evil. */
			SetLocalInt(GetModule(), sPC+"SSIL_WORK", 2);
		else if(nAct == 3)
		/* Ssil has given the PC quest #1. */
			SetLocalInt(GetModule(), sPC+"SSIL_WORK", 3);
		else if(nAct == 4)
		/* Quest #1 from Ssil is complete, but the PC has not been paid. */
			SetLocalInt(GetModule(), sPC+"SSIL_WORK", 4);
		else if(nAct == 5)
		/* Quest #1 from Ssil is complete, and the PC is getting paid. */
		{
			SetLocalInt(GetModule(), sPC+"SSIL_WORK", 5);
			int nGold = 5;
			int nXP = GoldToXP(5, oPC);
			ACR_AwardStaticQuestXP(oPC, "010_sel_ssildiplo", nXP);
			GiveGoldToCreature(oPC, nGold, TRUE);
		}
	}
}
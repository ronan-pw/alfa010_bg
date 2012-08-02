// ga_destroy_item
/*
    This takes an item from a player
        sItemTag    = This is the string name of the item's tag
        nQuantity   = The number of items to destroy. -1 is all of the Player's items of that tag.
        nPCFaction  = Take from the whole PC faction
*/
// FAB 9/30
// DBR 8/10/6

#include "nw_i0_plot"
#include "acr_xp_i"

float Gxp = 0.0f;
int Ggold = 0;

void DestroyItems(object oTarget,string sItem,int nNumItems,int gold, float xp)
{
    int nCount = 0;
    object oItem = GetFirstItemInInventory(oTarget);

    while (GetIsObjectValid(oItem) == TRUE && nCount < nNumItems)
    {
        if (GetTag(oItem) == sItem)
        {
		DestroyObject(oItem,0.0f);
		Gxp += xp;
		Ggold += gold;
        	nCount++;
        }
        oItem = GetNextItemInInventory(oTarget);
    }

   return;
}


void main(string sItemTag)
{
	int nGP;
	float fXP;
	object oPC = GetPCSpeaker(), oItem;       // Items in inventory
	string sStr;

	sStr = "firerattail";
	nGP = 5;
	fXP = 3.0f;
	DestroyItems(oPC,sStr, GetNumItems(oPC, sStr), nGP, fXP);
	
	sStr = "vampirebatfang";
	nGP = 8;
	fXP = 4.0f;
	DestroyItems(oPC,sStr, GetNumItems(oPC, sStr), nGP, fXP);
	
	sStr = "batguano";
	nGP = 3;
	fXP = 2.0f;
	DestroyItems(oPC,sStr, GetNumItems(oPC, sStr), nGP, fXP);
	
	sStr = "pmoss";
	nGP = 15;
	fXP = 10.0f;
	DestroyItems(oPC,sStr, GetNumItems(oPC, sStr), nGP, fXP);
	
	sStr = "it_sulfur";
	nGP = 30;
	fXP = 15.0f;
	DestroyItems(oPC,sStr, GetNumItems(oPC, sStr), nGP, fXP);
	
	sStr = "it_flashwort";
	nGP = 20;
	fXP = 10.0f;
	DestroyItems(oPC,sStr, GetNumItems(oPC, sStr), nGP, fXP);

	sStr = "it_gloomshroom";
	nGP = 15;
	fXP = 7.5f;
	DestroyItems(oPC,sStr, GetNumItems(oPC, sStr), nGP, fXP);

	sStr = "it_plot_hide_troll";
	nGP = 50;
	fXP = 25.0f;
	DestroyItems(oPC,sStr, GetNumItems(oPC, sStr), nGP, fXP);
	
	sStr = "it_plot_beetle_fire";
	nGP = 3;
	fXP = 1.0f;
	DestroyItems(oPC,sStr, GetNumItems(oPC, sStr), nGP, fXP);

	sStr = "010_it_misc_rtooth";
	nGP = 100;
	fXP = 50.0f;
	DestroyItems(oPC,sStr, GetNumItems(oPC, sStr), nGP, fXP);
	
	sStr = "it_plot_gear_electrum";
	nGP = 5;
	fXP = 3.0f;
	DestroyItems(oPC,sStr, GetNumItems(oPC, sStr), nGP, fXP);

	sStr = "it_plot_gear_gold";
	nGP = 15;
	fXP = 7.5f;
	DestroyItems(oPC,sStr, GetNumItems(oPC, sStr), nGP, fXP);

	sStr = "it_plot_gear_platinum";
	nGP = 100;
	fXP = 50.0f;
	DestroyItems(oPC,sStr, GetNumItems(oPC, sStr), nGP, fXP);

	sStr = "it_plot_gear_adamantine";
	nGP = 350;
	fXP = 150.0f;
	DestroyItems(oPC,sStr, GetNumItems(oPC, sStr), nGP, fXP);

	sStr = "it_misc_ankheg_acid_gland";
	nGP = 20;
	fXP = 10.0f;
	DestroyItems(oPC,sStr, GetNumItems(oPC, sStr), nGP, fXP);

	sStr = "it_misc_wyvern_stinger";
	nGP = 40;
	fXP = 20.0f;
	DestroyItems(oPC,sStr, GetNumItems(oPC, sStr), nGP, fXP);

	GiveGoldToCreature(oPC,Ggold);
	ACR_AwardStaticQuestXP(oPC,"Components",FloatToInt(Gxp)); 
   
}

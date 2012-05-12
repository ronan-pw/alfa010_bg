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


	sStr = "magmush";
	nGP = 2;
	fXP = 1.0f;
	DestroyItems(oPC,sStr, GetNumItems(oPC, sStr), nGP, fXP);

	sStr = "it_garnishcap";
	nGP = 1;
	fXP = 0.5f;
	DestroyItems(oPC,sStr, GetNumItems(oPC, sStr), nGP, fXP);

	sStr = "firefernfrond";
	nGP = 10;
	fXP = 5.0f;
	DestroyItems(oPC,sStr, GetNumItems(oPC, sStr), nGP, fXP);
	
	sStr = "seaweed";
	nGP = 10;
	fXP = 5.0f;
	DestroyItems(oPC,sStr, GetNumItems(oPC, sStr), nGP, fXP);
     
	sStr = "it_cassil";
	nGP = 30;
	fXP = 15.0f;
	DestroyItems(oPC,sStr, GetNumItems(oPC, sStr), nGP, fXP);
	
	sStr = "it_garclive";
	nGP = 4;
	fXP = 2.0f;
	DestroyItems(oPC,sStr, GetNumItems(oPC, sStr), nGP, fXP);

	sStr = "it_elderberry";
	nGP = 4;
	fXP = 2.0f;
	DestroyItems(oPC,sStr, GetNumItems(oPC, sStr), nGP, fXP);

	sStr = "it_henbane";
	nGP = 35;
	fXP = 17.5;
	DestroyItems(oPC,sStr, GetNumItems(oPC, sStr), nGP, fXP);

	sStr = "it_skullcap";
	nGP = 32;
	fXP = 16.0;
	DestroyItems(oPC,sStr, GetNumItems(oPC, sStr), nGP, fXP);

	GiveGoldToCreature(oPC,Ggold);
	ACR_AwardStaticQuestXP(oPC,"Herbs",FloatToInt(Gxp)); 
   

}

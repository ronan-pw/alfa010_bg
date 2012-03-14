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

int Gxp = 0;
int Ggold = 0;

void DestroyItems(object oTarget,string sItem,int gold, int xp)
{
    int nStack;
    object oItem = GetFirstItemInInventory(oTarget);

    while (GetIsObjectValid(oItem) == TRUE)
    {
        if (GetTag(oItem) == sItem)
        {
	    nStack = GetNumStackedItems(oItem);

            DestroyObject(oItem,0.0f);
            Gxp += nStack * xp;
            Ggold += nStack * gold;
        }
        oItem = GetNextItemInInventory(oTarget);
    }

   return;
}


void main(int type)
{
    int nTotalItem;
    object oPC = GetPCSpeaker();
    object oItem;       // Items in inventory


    switch (type) {
        // goblin
        case 0:
            DestroyItems(oPC,"it_plot_goblin_bounty",4,4);
            break;
    }
	
    GiveGoldToCreature(oPC, Ggold);
    ACR_AwardStaticQuestXP(oPC,"DPSS Bounty",Gxp);  
}

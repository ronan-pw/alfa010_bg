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

void DestroyItems(object oTarget,string sItem,int nNumItems,int gold, int xp)
{
    int nCount = 0;
    object oItem = GetFirstItemInInventory(oTarget);

    while (GetIsObjectValid(oItem) == TRUE && nCount < nNumItems)
    {
        if (GetTag(oItem) == sItem)
        {
            //ActionTakeItem(oItem,oTarget);
			DestroyObject(oItem,0.0f);
			Gxp = Gxp + xp;
			Ggold = Ggold + gold;
            nCount++;
        }
        oItem = GetNextItemInInventory(oTarget);
    }

   return;
}


void main(string sItemTag)
{
    int nTotalItem;
    object oPC = GetPCSpeaker();
    object oItem;       // Items in inventory



    nTotalItem = GetNumItems( oPC,"firerattail" );
    DestroyItems( oPC,"firerattail",nTotalItem,5,5 );
	
	nTotalItem = GetNumItems( oPC,"vampirebatfang" );
    DestroyItems( oPC,"vampirebatfang",nTotalItem,8,8 );
	
	nTotalItem = GetNumItems( oPC,"batguano" );
    DestroyItems( oPC,"batguano",nTotalItem,10,10 );
	
	nTotalItem = GetNumItems( oPC,"pmoss" );
    DestroyItems( oPC,"pmoss",nTotalItem,3,3 );
	
	nTotalItem = GetNumItems( oPC,"it_sulfur" );
    DestroyItems( oPC,"it_sulfur",nTotalItem,15,15 );
	
	nTotalItem = GetNumItems( oPC,"it_plot_hide_troll" );
    DestroyItems( oPC,"it_plot_hide_troll",nTotalItem,10,10 );
	
	nTotalItem = GetNumItems( oPC,"010_it_misc_rtooth" );
    DestroyItems( oPC,"010_it_misc_rtooth",nTotalItem,50,50 );
	
	nTotalItem = GetNumItems( oPC,"it_plot_gear_electrum" );
    DestroyItems( oPC,"it_plot_gear_electrum",nTotalItem,5,5 );
	
	nTotalItem = GetNumItems( oPC,"it_plot_gear_gold" );
    DestroyItems( oPC,"it_plot_gear_gold",nTotalItem,15,15 );
	
	nTotalItem = GetNumItems( oPC,"it_plot_gear_platinum" );
    DestroyItems( oPC,"it_plot_gear_platinum",nTotalItem,50,50 );
	
	nTotalItem = GetNumItems( oPC,"it_plot_gear_adamantine" );
    DestroyItems( oPC,"it_plot_gear_adamantine",nTotalItem,150,150 );
     
    GiveGoldToCreature(oPC,Ggold);
	ACR_AwardStaticQuestXP(oPC,"Components",Gxp);  
   

}
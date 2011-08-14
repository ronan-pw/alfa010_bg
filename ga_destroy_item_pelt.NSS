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


	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_plot_hide_badger" ));
    DestroyItems( oPC,"it_plot_hide_badger",nTotalItem,2,2 );

	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_plot_hide_bear" ));
    DestroyItems( oPC,"it_plot_hide_bear",nTotalItem,10,10 );
	
	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_plot_hide_boar" ));
    DestroyItems( oPC,"it_plot_hide_boar",nTotalItem,5,5 );
			
	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_plot_hide_berry" ));
    DestroyItems( oPC,"it_plot_hide_berry",nTotalItem,1,1 );
	
    nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_plot_hide_cat" ));
    DestroyItems( oPC,"it_plot_hide_cat",nTotalItem,2,2 );	
	
	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_plot_hide_deer" ));
    DestroyItems( oPC,"it_plot_hide_deer",nTotalItem,3,3 );	
	
	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_plot_hide_rabbit" ));
    DestroyItems( oPC,"it_plot_hide_rabbit",nTotalItem,1,1 );
	
	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_plot_hide_weasel" ));
    DestroyItems( oPC,"it_plot_hide_weasel",nTotalItem,1,1 );
	
	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_plot_hide_wolf" ));
    DestroyItems( oPC,"it_plot_hide_wolf",nTotalItem,5,5 );	
	
	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_plot_hide_wolverine" ));
    DestroyItems( oPC,"it_plot_hide_wolverine",nTotalItem,3,3 );	
	
	GiveGoldToCreature(oPC,Ggold);
	ACR_AwardStaticQuestXP(oPC,"Pelts",Gxp); 
     
   

}
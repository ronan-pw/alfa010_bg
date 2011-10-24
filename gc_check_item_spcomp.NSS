// gc_check_item
/*
    This script checks to see if the PC has an item in their inventory
        sItem   = The tag name you want to check to see if the PC has
        bCheckParty = TRUE if you want to check the entire party for possession of the item
*/
// FAB 10/5
// EPF 3/13/06 -- second parameter now used to check and see if the item is held by anyone in the party
//				  also checks the PC Speaker instead of the first PC if bCheckParty is FALSE.

int StartingConditional()
{

    object oPC = GetPCSpeaker();
	if(GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(),"firerattail"))) return TRUE;
	if(GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(),"vampirebatfang"))) return TRUE;
	if(GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(),"batguano"))) return TRUE;
	if(GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(),"pmoss"))) return TRUE;
	if(GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(),"it_sulfur"))) return TRUE;
	if(GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(),"it_plot_gear_electrum"))) return TRUE;
	if(GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(),"it_plot_gear_gold"))) return TRUE;
	if(GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(),"it_plot_gear_platinum"))) return TRUE;
	if(GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(),"it_plot_gear_adamantine"))) return TRUE;
	if(GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(),"it_plot_hide_troll"))) return TRUE;
	if(GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(),"010_it_misc_rtooth"))) return TRUE;
	if(GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(),"it_misc_ankheg_acid_gland"))) return TRUE;
	if(GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(),"it_misc_wyvern_stinger"))) return TRUE;
  
   // return GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(),sItem));
    
    return FALSE;

}
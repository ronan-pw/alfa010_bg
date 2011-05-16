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

    object otarget = GetPCSpeaker();
	if(GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(),"it_dcrab"))) return TRUE;
	if(GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(),"it_fish"))) return TRUE;
	if(GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(),"it_scallop"))) return TRUE;
  
   // return GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(),sItem));
    
    return FALSE;

}
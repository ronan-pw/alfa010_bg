// gc_check_item
/*
    This script checks to see if the PC has an item in their inventory
        sItem   = The tag name you want to check to see if the PC has
        bCheckParty = TRUE if you want to check the entire party for possession of the item
*/
// FAB 10/5
// EPF 3/13/06 -- second parameter now used to check and see if the item is held by anyone in the party
//				  also checks the PC Speaker instead of the first PC if bCheckParty is FALSE.

void main(string checker, string NPCtoCheck)
{

  object oNPC = GetObjectByTag(NPCtoCheck);
  object oInventory = GetItemPossessedBy(oNPC, checker); 

  //if(oInventory != OBJECT_INVALID){ 
    //CopyItem(oInventory,GetObjectByTag("helm&cloak"));
  DestroyObject(oInventory);
    //CreateItemOnObject("hc1", GetObjectByTag("host"));
  //}
	//if(GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(),"magmush"))) return TRUE;
  
   // return GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(),sItem));
    
    //return FALSE;

}
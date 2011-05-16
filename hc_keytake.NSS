void main()
{
object oPC = GetEnteringObject();
object oInventory = GetItemPossessedBy(oPC, "hc1"); 

if(oInventory != OBJECT_INVALID){ 
  //CopyItem(oInventory,GetObjectByTag("helm&cloak"));
  DestroyObject(oInventory);
  CreateItemOnObject("hc1", GetObjectByTag("host"));
}

oInventory = GetItemPossessedBy(oPC, "hc2"); 

if(oInventory != OBJECT_INVALID){ 
  //CopyItem(oInventory,GetObjectByTag("helm&cloak"));
  DestroyObject(oInventory);
  CreateItemOnObject("hc2", GetObjectByTag("host"));
}



//else SpeakOneLinerConversation("This odd plant almost feels warm to the touch.");
//GetClickingObject()

}
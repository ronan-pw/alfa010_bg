void main()
{
object oPC = GetEnteringObject();
object oInventory = GetItemPossessedBy(oPC, "fai1"); 

if(oInventory != OBJECT_INVALID){ 
  //CopyItem(oInventory,GetObjectByTag("helm&cloak"));
  DestroyObject(oInventory);
  CreateItemOnObject("fai1", GetObjectByTag("c_bentley"));
}

oInventory = GetItemPossessedBy(oPC, "fai2"); 

if(oInventory != OBJECT_INVALID){ 
  //CopyItem(oInventory,GetObjectByTag("helm&cloak"));
  DestroyObject(oInventory);
  CreateItemOnObject("fai2", GetObjectByTag("c_bentley"));
}

oInventory = GetItemPossessedBy(oPC, "fai3");

if(oInventory != OBJECT_INVALID){ 
  //CopyItem(oInventory,GetObjectByTag("helm&cloak"));
  DestroyObject(oInventory);
  CreateItemOnObject("fai3", GetObjectByTag("c_bentley"));
}

oInventory = GetItemPossessedBy(oPC, "fai4"); 

if(oInventory != OBJECT_INVALID){ 
  //CopyItem(oInventory,GetObjectByTag("helm&cloak"));
  DestroyObject(oInventory);
  CreateItemOnObject("fai4", GetObjectByTag("c_bentley"));
}


oInventory = GetItemPossessedBy(oPC, "fai5");

if(oInventory != OBJECT_INVALID){ 
  //CopyItem(oInventory,GetObjectByTag("helm&cloak"));
  DestroyObject(oInventory);
  CreateItemOnObject("fa5", GetObjectByTag("c_bentley"));
}

oInventory = GetItemPossessedBy(oPC, "fai6"); 

if(oInventory != OBJECT_INVALID){ 
  //CopyItem(oInventory,GetObjectByTag("helm&cloak"));
  DestroyObject(oInventory);
  CreateItemOnObject("fai6", GetObjectByTag("c_bentley"));
}





//else SpeakOneLinerConversation("This odd plant almost feels warm to the touch.");
//GetClickingObject()

}
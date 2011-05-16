void main()
{
 object oPC = GetLastUsedBy();
 object oChest = GetObjectByTag("weapon_pile"); //Must be a unique tag
 object oItem = GetFirstItemInInventory(oPC);
 int rSave = ReflexSave(oPC, 24, SAVING_THROW_TYPE_TRAP, OBJECT_SELF);


    ActionWait(15.0);   //wait fifteen seconds, then close door.
    ActionCloseDoor(OBJECT_SELF);


 if (rSave==0)
    {
  while(oItem != OBJECT_INVALID)
 {
  AssignCommand(oChest, ActionTakeItem(oItem, oPC));
       // strip equipped items
    //int nSlot;
    //for ( nSlot = 0; nSlot < NUM_INVENTORY_SLOTS; nSlot++ )
     int nSlot = INVENTORY_SLOT_LEFTHAND +1;
while( nSlot > INVENTORY_SLOT_RIGHTHAND)
    {
        oItem = GetItemInSlot( nSlot, oPC );
       if ( GetIsObjectValid(oItem) )
          AssignCommand(oChest, ActionTakeItem(oItem, oPC));
    }
  oItem = GetNextItemInInventory(oPC);
 }
    }
else
    {
    ActionSpeakString ("You manage to hold on to your items", TALKVOLUME_TALK);
    }


}
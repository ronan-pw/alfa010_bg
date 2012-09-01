void main()
{
	object oItem;
	
	if (!GetLocalInt(OBJECT_SELF, "ready")) {
		ActionSpeakString("<i>The machine is still and silent; it appears to be non-functional presently.</i>");
		return;
	}
	
	oItem = GetFirstItemInInventory();
	
	while (GetIsObjectValid(oItem)) {
		if ((GetBaseItemType(oItem) == BASE_ITEM_KEY) && (GetLocalInt(oItem,"ACR_KEYCOPY") == 0)) {
			
			ActionSpeakString("<i>The machine rumbles for a moment and soon a new key pops out of the chute before you.</i>");
			
			
			oItem = CopyItem(oItem);
			SetLocalInt(oItem, "ACR_KEYCOPY", 1);
			SetFirstName(oItem, "Copy of " + GetName(oItem));
			DeleteLocalInt(OBJECT_SELF, "ready");
			return;
		}
		oItem = GetNextItemInInventory();
	}
	
	ActionSpeakString("<i>The machine rumbles for a moment and then lets out a shrill buzz.  Apparently it does not like what was put inside.</i>");
}

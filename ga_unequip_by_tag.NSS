
#include "ginc_param_const"
#include "ginc_item"

void main(string tag)
{
	object pc =  GetPCSpeaker();
	object o;
	int i,fnd=0;
	
	for (i=0; i<NUM_INVENTORY_SLOTS; ++i)
	{
		o = GetItemInSlot(i, pc);
		
		if ((GetIsObjectValid(o)) && (GetTag(o) == tag)) {
			fnd = 1;
			break;
		}
	}
	
	if (fnd) {
		RememberEquippedItem(pc, i);
		UnequipSlot(pc, i);
	}
}
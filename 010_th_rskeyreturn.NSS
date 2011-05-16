// Script to remove red sheaf keys from inventory and copy them back to the store inventory

void main()
{
object oPC = GetEnteringObject();
object oKEY = (GetFirstItemInInventory(oPC));
while (GetIsObjectValid(oKEY))
{
if (GetStringLeft(GetTag(oKEY),10)=="010_rs_inn")
{CopyItem(oKEY, GetObjectByTagAndType("010_bg_red_sheaf", OBJECT_TYPE_STORE, 1), TRUE);
DestroyObject(oKEY, 1.0);
object oKEY = GetNextItemInInventory(oPC);
}
	
	
}
}
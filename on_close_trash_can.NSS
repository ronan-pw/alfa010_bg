void main()
{
object oItem = GetFirstItemInInventory();
if(GetIsObjectValid(oItem))
    {
    while(GetIsObjectValid(oItem))
        {
        SetPlotFlag(oItem, FALSE);
        DestroyObject(oItem);
        oItem = GetNextItemInInventory();
        }
    }
}
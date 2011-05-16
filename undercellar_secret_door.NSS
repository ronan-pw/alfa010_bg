void main()
{
object PCclick;
object oDoor1=GetObjectByTag("uc1");
object oDoor2=GetObjectByTag("uc2"); 

PCclick = GetEnteringObject();

//if(GetDistanceToObject(PCclick) > 5.0) return;

if(GetIsObjectValid(GetItemPossessedBy(PCclick,"hh_orb"))){
ActionOpenDoor(oDoor1);
ActionOpenDoor(oDoor2);
SendMessageToPC(PCclick, "The strange copper orb you hold glows.");  
}
else
SendMessageToPC(PCclick, "You think there is a hidden door trigger here, but you can find no way to open it."); 
}
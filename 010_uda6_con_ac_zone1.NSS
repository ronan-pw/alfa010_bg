void main()
{
object UDA6=GetArea(OBJECT_SELF);
string ZONE="ZONE1";



object oNPC=GetObjectByTag("UDA6_"+ZONE+"_NPC");
object oDoor=GetObjectByTag("UDA6_E_DOOR_"+ZONE);
SetLocked(oDoor,FALSE);
AssignCommand(oDoor,ActionOpenDoor(oDoor));
SetLocalInt(UDA6,"PUZZLE_"+ZONE+"_SUCCESS",1);
DelayCommand(1.0,SetScriptHidden(oNPC,TRUE));
}
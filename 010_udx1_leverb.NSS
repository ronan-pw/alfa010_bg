void main()
{
object oDoor=GetObjectByTag("UDX1_DOOR_B");
SetLocked(oDoor,FALSE);
AssignCommand(oDoor,ActionOpenDoor(oDoor));
DelayCommand(1.0,SetLocked(oDoor,TRUE));
DelayCommand(60.0,AssignCommand(oDoor,ActionCloseDoor(oDoor)));

}
void main()
{
object oEntering=GetEnteringObject();
string sTag=GetTag(OBJECT_SELF);
object oWP=GetWaypointByTag(sTag);

AssignCommand(oEntering,ActionJumpToObject(oWP,FALSE));
}
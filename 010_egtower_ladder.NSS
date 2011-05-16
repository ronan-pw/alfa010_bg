void main()
{
object oPC=GetLastUsedBy();
object oWP=GetWaypointByTag("WP_EGTOWER_IN");
AssignCommand(oPC,ActionJumpToObject(oWP,FALSE));

}
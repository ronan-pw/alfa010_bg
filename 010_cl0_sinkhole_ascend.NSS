void main()
{
	object o = GetPCSpeaker();

	DelayCommand(1.0,AssignCommand(o,ActionJumpToObject(GetWaypointByTag("WP_SINKHOLE_TOP"))));
}
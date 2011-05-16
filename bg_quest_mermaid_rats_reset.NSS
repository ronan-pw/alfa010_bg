void main()
{
	location loc;
	object o;
	
	o = GetNearestObjectByTag("bg_mermaid_lower_in");
	AssignCommand(o,ActionCloseDoor(o));
	SetLocked(o,1);
}
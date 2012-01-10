void main()
{
	location loc;
	object o;
	
	o = GetNearestObjectByTag("ud_mistmoot_lower_in");
	AssignCommand(o,ActionCloseDoor(o));
	SetLocked(o,1);
}

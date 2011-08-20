void main()
{
	object o;
	float f = 0.1;
	o = OBJECT_SELF;
	
	if (GetLocked(o))
		return;
		
	if ((Random(100)/100.0) > f)
		return;
		
	AssignCommand(o,ActionOpenDoor(o));
}
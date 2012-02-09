const int _DOOR_ALIGN_THRESHOLD = 10;

void door_shift_align(object o, int lawful)
{
	int i;
	string msg = "DOOR_ALIGN: +1 ";

#if 0
	/* Remove until a more workable implementation is used
	 */
	
	i = GetLocalInt(o,"010_door_align");
	
	if (lawful) {
		SetLocalInt(o,"010_door_align", i+1);
	}
	else {
		SetLocalInt(o,"010_door_align", i-1);
	}
	
	if (i < -_DOOR_ALIGN_THRESHOLD) {
		AdjustAlignment(o,ALIGNMENT_CHAOTIC,1);
		msg += "Chaotic";
	}
	else if (i > _DOOR_ALIGN_THRESHOLD) {
		AdjustAlignment(o,ALIGNMENT_LAWFUL,1);
		msg += "Lawful";
	}
	else
		return;
		
	msg += " for " + GetName(o);
	
	DeleteLocalInt(o,"010_door_align");
	WriteTimestampedLogEntry(msg);
#endif
}

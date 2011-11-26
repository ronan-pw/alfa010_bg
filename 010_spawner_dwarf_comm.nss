void main()
{
	string sResRef;
	switch (Random(20))
		{
			case 1:sResRef="abr_cr_dwarf_commoner1";break;
			case 2:sResRef="abr_cr_dwarf_commoner2";break;
			case 3:sResRef="abr_cr_dwarf_commoner3";break;
			case 4:sResRef="abr_cr_dwarf_commoner4";break;
			case 5:sResRef="abr_cr_dwarf_commoner5";break;
			case 6:sResRef="abr_cr_dwarf_commoner1_walk";break;
			case 7:sResRef="abr_cr_dwarf_commoner2_walk";break;
			case 8:sResRef="abr_cr_DwarfExpertM";break;
			case 9:sResRef="abr_cr_DwarfExpertF";break;
			case 10:sResRef="abr_cr_DwarfWarriorA";break;
			case 11:sResRef="abr_cr_DwarfWarriorH";break;
			case 12:sResRef="abr_cr_DwarfAdeptM";break;
			case 13:sResRef="abr_cr_DwarfAdeptF";break;
			default: sResRef="";
		}

	DelayCommand(0.1,DestroyObject(OBJECT_SELF));

	if (sResRef == "")
		return;
		
	object oSpawned=CreateObject(OBJECT_TYPE_CREATURE,sResRef,GetLocation(OBJECT_SELF),FALSE,GetTag(OBJECT_SELF));	
	
	SetLocalInt(oSpawned, "X2_L_SPAWN_USE_AMBIENT_IMMOBILE", 1);
	
	if (Random(100) > 80)
		SetLocalInt(oSpawned, "X2_L_SPAWN_USE_AMBIENT", 1);

}
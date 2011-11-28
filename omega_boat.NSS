void main()

	{object oDM = OBJECT_SELF;
	 location lLocation = GetItemActivatedTargetLocation();
	 object oMod = GetModule();
	 int nNumber = GetLocalInt(oMod, "omega_boat_number");
	 string sName = "Rowboat #" + IntToString(nNumber);
	 int nStart = GetLocalInt(oDM, "omega_temp_boat");
	 string sBoat = "tsm_rowboat";
	if(nStart == 0)
		{nNumber++;
		 SetLocalInt(oMod,"omega_boat_number", nNumber);
		 }
	if(nStart == 3)
		{sBoat = "tsm_rowboat_via";
		}
		 
	object oBoat = CreateObject(OBJECT_TYPE_PLACEABLE, sBoat, lLocation);
	SetFirstName(oBoat, sName);
	SendMessageToAllDMs("Created " + GetName(oBoat));
	
}		
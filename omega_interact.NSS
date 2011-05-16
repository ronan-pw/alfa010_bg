void main()

	{object oDM = OBJECT_SELF;
	object oNPC = GetLocalObject(oDM, "Object_Target");
	object oPlaceable = GetNearestObject(OBJECT_TYPE_PLACEABLE, oNPC, 1);

	
	AssignCommand(oNPC, ActionForceMoveToObject(oPlaceable, FALSE));
	AssignCommand(oNPC, ActionInteractObject(oPlaceable));
	
}		
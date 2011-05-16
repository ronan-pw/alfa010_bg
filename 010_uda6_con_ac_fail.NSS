void main()
{
object UDA6=GetArea(OBJECT_SELF);
int iLives=GetLocalInt(UDA6,"PUZZLE_LIVES");
iLives=iLives-1;
SetLocalInt(UDA6,"PUZZLE_LIVES",iLives);



if (iLives==0)
	{	
	object oWP=GetWaypointByTag("WP_PORTAL_UDA4_D");
	object oPC=GetPCSpeaker();
	object oLoop=GetFirstFactionMember(oPC);
	effect eRemove;
	while (GetIsObjectValid(oLoop))
		{
		eRemove=GetFirstEffect(oLoop);
		while (GetIsEffectValid(eRemove))
			{
			if (GetEffectCreator(eRemove)==oLoop)
				{
				RemoveEffect(oLoop,eRemove);
				}
			eRemove=GetNextEffect(oLoop);	
			}
		
		DelayCommand(0.5,AssignCommand(oLoop,ActionJumpToObject(oWP)));
		oLoop=GetNextFactionMember(oPC);
		}
	DeleteLocalInt(UDA6,"PARTY_MEMBERS");
	DeleteLocalInt(UDA6,"PUZZLE_STATE");
	DeleteLocalInt(UDA6,"PCS_IN_MAIN");
	DeleteLocalInt(UDA6,"PUZZLE_ZONE1_SUCCESS");
	DeleteLocalInt(UDA6,"PUZZLE_ZONE2_SUCCESS");
	DeleteLocalInt(UDA6,"PUZZLE_ZONE3_SUCCESS");
	DeleteLocalInt(UDA6,"PUZZLE_ZONE4_SUCCESS");
	DeleteLocalInt(UDA6,"PUZZLE_ZONE5_SUCCESS");
	DeleteLocalInt(UDA6,"PUZZLE_ZONE6_SUCCESS");
	DeleteLocalInt(UDA6,"PUZZLE_ZONE7_SUCCESS");
	
	
	
	}	
}
void main()
{
object UDA6=GetArea(OBJECT_SELF);
string ZONE="ZONE7";



object oNPC=GetObjectByTag("UDA6_"+ZONE+"_NPC");
object oDoor=GetObjectByTag("UDA6_E_DOOR_"+ZONE);
SetLocked(oDoor,FALSE);
AssignCommand(oDoor,ActionOpenDoor(oDoor));
SetLocalInt(UDA6,"PUZZLE_"+ZONE+"_SUCCESS",1);
DelayCommand(1.0,SetScriptHidden(oNPC,TRUE));


object oPC=GetPCSpeaker();
object oLoop=GetFirstFactionMember(oPC);
location lTarget;
effect eRemove;

while (GetIsObjectValid(oLoop))
	{
	lTarget=Location(GetObjectByTag("underdark_a6_shadowcrypt"),
							GetPosition(oLoop),
								GetFacing(oLoop));
	DelayCommand(0.5,AssignCommand(oLoop,ActionJumpToLocation(lTarget)));	
	eRemove=GetFirstEffect(oLoop);
	while (GetIsEffectValid(eRemove))
		{
		if (GetEffectCreator(eRemove)==oLoop)
			{
			RemoveEffect(oLoop,eRemove);
			}
		eRemove=GetNextEffect(oLoop);	
		}	
	oLoop=GetNextFactionMember(oPC);
	}
}
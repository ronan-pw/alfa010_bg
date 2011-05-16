#include "010_uda6_puzzle_inc"
void main()
{
object oPC=GetEnteringObject();

if (!GetLocalInt(GetArea(OBJECT_SELF),"PARTY_MEMBERS"))
	{
	int iPartyMembers;
	object oLoop=GetFirstFactionMember(oPC);
	while (GetIsObjectValid(oLoop))
		{
		iPartyMembers=iPartyMembers+1;
		SetLocalInt(GetArea(OBJECT_SELF),"PARTY_MEMBERS",iPartyMembers);
		oLoop=GetNextFactionMember(oPC);
		}
	if (DEBUG==1)
	{SendMessageToPC(oPC,"Partymembers="+IntToString(GetLocalInt(GetArea(OBJECT_SELF),"PARTY_MEMBERS")));}
	SetLocalInt(GetArea(OBJECT_SELF),"PUZZLE_LIVES",3);
	}
effect eEthereal=EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE);
AssignCommand(oPC,ApplyEffectToObject(DURATION_TYPE_PERMANENT,eEthereal,oPC));
}
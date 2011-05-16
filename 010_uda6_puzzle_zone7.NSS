#include "010_uda6_puzzle_inc"
void main()
{
object UDA6=GetArea(OBJECT_SELF);
object oPC=GetEnteringObject();
string ZONE="ZONE7";

object oNPC=GetObjectByTag("UDA6_"+ZONE+"_NPC");
int PUZZLE_STATE=GetLocalInt(UDA6,"PUZZLE_STATE");
int PCS_IN_ZONE=GetLocalInt(UDA6,"PCS_IN_"+ZONE);
int PARTY_MEMBERS=GetLocalInt(UDA6,"PARTY_MEMBERS");

PCS_IN_ZONE=PCS_IN_ZONE+1;
SetLocalInt(UDA6,"PCS_IN_"+ZONE,(PCS_IN_ZONE));
if (DEBUG==1){SendMessageToPC(oPC,"PCs in "+ZONE+"="+IntToString(GetLocalInt(UDA6,"PCS_IN_"+ZONE)));}
if (DEBUG==1){SendMessageToPC(oPC,"PCs in Party="+IntToString(GetLocalInt(UDA6,"PARTY_MEMBERS")));}
if (DEBUG==1){SendMessageToPC(oPC,"Puzzle State="+IntToString(GetLocalInt(UDA6,"PUZZLE_STATE")));}

if (PCS_IN_ZONE==PARTY_MEMBERS)
	{
	object oDoor=GetObjectByTag("UDA6_E_DOOR_"+ZONE);
	AssignCommand(oDoor,ActionCloseDoor(oDoor));
	SetLocked(oDoor,TRUE);
	DelayCommand(3.0,SetScriptHidden(oNPC,FALSE));
	}
}
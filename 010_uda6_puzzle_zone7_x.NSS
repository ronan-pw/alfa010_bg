#include "010_uda6_puzzle_inc"

void main()
{
object UDA6=GetArea(OBJECT_SELF);
object oPC=GetEnteringObject();
string ZONE="ZONE7";
int PCS_IN_ZONE=GetLocalInt(UDA6,"PCS_IN_"+ZONE);
SetLocalInt(UDA6,"PCS_IN_"+ZONE,(PCS_IN_ZONE-1));
if (DEBUG==1){SendMessageToPC(oPC,"PCs in "+ZONE+"="+IntToString(GetLocalInt(UDA6,"PCS_IN_"+ZONE)));}
}
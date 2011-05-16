#include "acr_door_i"

void main() {

object oPC = GetLastUsedBy();
SendMessageToPC(oPC, "Using start area door");
ACR_DoorOnOpen();

AssignCommand(oPC, ActionStartConversation(oPC, "010_startarea_door", TRUE, FALSE));
}
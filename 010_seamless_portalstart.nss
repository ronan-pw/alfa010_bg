////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Server Portal initator
//     Filename : acr_trg_portalstart.nss
//    $Revision:: 1        $ current version of the file
//        $Date:: 2009-02-08#$ date the file was created or modified
//       Author : AcadiusLost
//
//  Local Variable Prefix =
//
//  Dependencies external of nwscript:
//
//  Description
//  This script starts the portalling convo.
//
//  Revision History
//    2009-02-08  AcadiusLost: Inception
////////////////////////////////////////////////////////////////////////////////
#include "acr_trigger_i"

void main() {

object oPC = GetClickingObject();
if (!GetIsPC(oPC)) { return; }

int nDestServerID = GetLocalInt(OBJECT_SELF, "ACR_PORTAL_DEST");
int nPortalNumber = GetLocalInt(OBJECT_SELF, "ACR_PORTAL_NUM");
int bAdjacency = GetLocalInt(OBJECT_SELF, "ACR_PORTAL_ADJACENT");

if (nDestServerID == 0) {
	// portal is not configured, notify the player and DMs.
	SendMessageToPC(oPC, "This server portal is not configured properly.  Please notify the DM team.");
	SendMessageToAllDMs("Incorrectly configured server portal activation in area: "+GetName(GetArea(OBJECT_SELF))+" by PC: "+GetName(oPC));
	return;
} else if (nPortalNumber == 0 ) {
	// portal is not numbered, assume it's #1
	nPortalNumber = 1;
}

	SendMessageToPC(oPC, "Using portal trigger.");
	ACR_PortalPC_Start(oPC, nDestServerID, nPortalNumber, bAdjacency);
}

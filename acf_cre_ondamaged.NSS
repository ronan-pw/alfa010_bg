////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_cre_ondamaged
//    $Revision:: 280        $ current version of the file
//        $Date:: 2007-03-20#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnDamaged event handler for creatures and
//  any custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_creature_i"

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Variables ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main()
{
	ACR_CreatureOnDamaged();
	object o,self = OBJECT_SELF;
	int i;
	
	if (GetLocalInt(self,"ACR_MAKE_HOSTILE")) {
		ChangeToStandardFaction(self,STANDARD_FACTION_HOSTILE);
		DeleteLocalInt(self, "ACR_MAKE_HOSTILE");

		o = self;
		i = 1;

		while (GetIsObjectValid(o)) {
			o = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, self, i);

			if (GetLocalInt(o,"ACR_MAKE_HOSTILE") && GetDistanceBetween(self, o) < 15.0) {
				ChangeToStandardFaction(o,STANDARD_FACTION_HOSTILE);
				DeleteLocalInt(o, "ACR_MAKE_HOSTILE");
			}
			++i;
		}
	}
}

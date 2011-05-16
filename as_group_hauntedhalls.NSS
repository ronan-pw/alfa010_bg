////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Spawn System
//     Filename : as_group_example.nss
//      Version : 1.0
//         Date : 2006-9-17
//       Author : Ronan
//
//  Description
//  This is a simple example of a spawn group script which is used by the ACR's
//  spawn system. Though the name of the script is "as_group_example", the spawn
//  point which uses this script would simply have "example" listed as a spawn
//  group name, since the "as_group_" is always added on to the beginning. For a
//  more complex example of spawn groups, see the script "as_group_complex".
//
//  Revision History
// Rick, made several types of rats.
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// This line is required on all spawn group scripts.
#include "acr_spawn_i"

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

// This is the main function, which is what the spawn system runs when this
// spawn group is spawned.
void main();

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main() {
object oChest;
object oTrap;
object oCheckTrigger;


switch(Random(5)) {
			case 0:
	            oChest = ACR_SpawnObject("phat_lewt_chest_small", OBJECT_TYPE_PLACEABLE);
	            oCheckTrigger = GetNearestObjectByTag("phat_lewt_trigger", OBJECT_SELF, 1);
				if(GetDistanceBetween(oCheckTrigger, OBJECT_SELF) > 10.0)
					{oCheckTrigger = OBJECT_INVALID;
					}
				SetLocalObject(oCheckTrigger, "oChest", oChest);
				SetUseableFlag(oChest, FALSE);
				SetLocalInt(oChest, "Trappable", 1);
				break;
	        case 1:
	            oChest = ACR_SpawnObject("phat_lewt_chest_large", OBJECT_TYPE_PLACEABLE);
	            oCheckTrigger = GetNearestObjectByTag("phat_lewt_trigger", OBJECT_SELF, 1);
				if(GetDistanceBetween(oCheckTrigger, OBJECT_SELF) > 10.0)
					{oCheckTrigger = OBJECT_INVALID;
					}
				SetLocalObject(oCheckTrigger, "oChest", oChest);
				SetUseableFlag(oChest, FALSE);
				SetLocalInt(oChest, "Trappable", 1);
				break;
			case 2:
	            oChest = ACR_SpawnObject("phat_lewt_sarcophagus", OBJECT_TYPE_PLACEABLE);
	            oCheckTrigger = GetNearestObjectByTag("phat_lewt_trigger", OBJECT_SELF, 1);
				if(GetDistanceBetween(oCheckTrigger, OBJECT_SELF) > 10.0)
					{oCheckTrigger = OBJECT_INVALID;
					}
				SetLocalObject(oCheckTrigger, "oChest", oChest);
				SetUseableFlag(oChest, FALSE);
				SetLocalInt(oChest, "Trappable", 1);
				break;
			case 3:
	            ACR_SpawnObject("corpse1", OBJECT_TYPE_PLACEABLE);
				break;
			case 4:
	            ACR_SpawnObject("batguanopile", OBJECT_TYPE_PLACEABLE);
				break;

				}
}
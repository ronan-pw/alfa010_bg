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
	switch(Random(20)) {
        case 0:
            ACR_SpawnObject("010_cr_an_boar", OBJECT_TYPE_CREATURE);
            break;
        case 1:
            ACR_SpawnObject("010_cr_wolverinedire", OBJECT_TYPE_CREATURE);
            break;
        case 2:
            ACR_SpawnObject("010_cr_an_deer_male", OBJECT_TYPE_CREATURE);
			ACR_SpawnObject("010_cr_an_deer_female", OBJECT_TYPE_CREATURE);
            break;
        case 3:
			ACR_SpawnObject("010_cr_an_brownbear", OBJECT_TYPE_CREATURE);
            break;			
	    case 4:
            ACR_SpawnObject("010_cr_an_wildcat", OBJECT_TYPE_CREATURE);
			ACR_SpawnObject("010_cr_an_wildcat", OBJECT_TYPE_CREATURE);
            break;
        case 5:
            ACR_SpawnObject("010_cr_an_weasel", OBJECT_TYPE_CREATURE);
            break;
        case 6:
            ACR_SpawnObject("010_cr_an_wolverine", OBJECT_TYPE_CREATURE);
            break;
        case 7:
			ACR_SpawnObject("010_cr_an_bunny", OBJECT_TYPE_CREATURE);
			ACR_SpawnObject("010_cr_an_bunny", OBJECT_TYPE_CREATURE);
            break;			
	    case 8:
            ACR_SpawnObject("010_cr_badgerdire2", OBJECT_TYPE_CREATURE);
			ACR_SpawnObject("010_cr_badgerdire1", OBJECT_TYPE_CREATURE);
			ACR_SpawnObject("010_cr_badgerdire1", OBJECT_TYPE_CREATURE);
            break;
        case 9:
            ACR_SpawnObject("010_cr_an_wolf_timber", OBJECT_TYPE_CREATURE);
			ACR_SpawnObject("010_cr_an_wolf_timber", OBJECT_TYPE_CREATURE);
			break;
		case 10:
			ACR_SpawnObject("010_cr_an_wolf_timber", OBJECT_TYPE_CREATURE);
            break;
		case 11:	
			ACR_SpawnObject("010_cr_an_wolf", OBJECT_TYPE_CREATURE);
			ACR_SpawnObject("010_cr_an_wolf_timber", OBJECT_TYPE_CREATURE);
			break;
		case 12:	
			ACR_SpawnObject("010_cr_badgerdire2", OBJECT_TYPE_CREATURE);
            break;			
		case 13:
			ACR_SpawnObject("010_cr_wolverinedire0", OBJECT_TYPE_CREATURE);
            break;			
		case 14:
			ACR_SpawnObject("010_cr_an_boar_male", OBJECT_TYPE_CREATURE);
			ACR_SpawnObject("010_cr_an_boar_female", OBJECT_TYPE_CREATURE);
            break;			
		case 15:	
			ACR_SpawnObject("010_cr_an_wolf", OBJECT_TYPE_CREATURE);
            break;			
		case 16:	
			ACR_SpawnObject("010_cr_an_badger", OBJECT_TYPE_CREATURE);
			break;
		case 17:
			ACR_SpawnObject("010_cr_an_boar", OBJECT_TYPE_CREATURE);	
            break;			
		case 18:	
			ACR_SpawnObject("010_cr_an_berrygobbler", OBJECT_TYPE_CREATURE);
			ACR_SpawnObject("010_cr_an_berrygobbler", OBJECT_TYPE_CREATURE);
            break;			
		default:
		
			switch (Random(3)) {
				case 0:
					ACR_SpawnObject("010_cr_beardire", OBJECT_TYPE_CREATURE);
					break;
				case 1:
					ACR_SpawnObject("010_cr_boardire", OBJECT_TYPE_CREATURE);
					break;
				case 2:
            		ACR_SpawnObject("010_cr_wolfdire", OBJECT_TYPE_CREATURE);
					ACR_SpawnObject("010_cr_an_wolf", OBJECT_TYPE_CREATURE);
					ACR_SpawnObject("010_cr_an_wolf", OBJECT_TYPE_CREATURE);
					break;
					}
        }
}	
    
			
   
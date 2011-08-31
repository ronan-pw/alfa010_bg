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
#include "010_spawn_ex"

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

	switch(Random(24)) {
        case 0:
            spawn_npc("010_cr_comm_human");
            break;
        case 1:
            spawn_npc("010_cr_comm_human0");
            break;
        case 2:
            spawn_npc("010_cr_comm_human000");
            break;
        case 3:
            spawn_npc("010_cr_comm_human1");
            break;			
        case 4:
            spawn_npc("010_cr_comm_human10");
            break;		
        case 5:
			spawn_npc("010_cr_comm_human80");
            break;
        case 6:
            spawn_npc("010_cr_comm_human11");
            break;
        case 7:
			spawn_npc("010_cr_comm_human70");
            break;
        case 8:
            spawn_npc("010_cr_comm_human2");
            break;
        case 9:
            spawn_npc("010_cr_comm_human20");
            break;			
	    case 10:
            spawn_npc("010_cr_comm_human3");
            break;		
	    case 11:
            spawn_npc("010_cr_comm_human30");
            break;
		case 12:
            spawn_npc("010_cr_comm_human4");
            break;
        case 13:
            spawn_npc("010_cr_comm_human40");
            break;
        case 14:
            spawn_npc("010_cr_comm_human5");
            break;
        case 15:
            spawn_npc("010_cr_comm_human50");
            break;			
	    case 16:
            spawn_npc("010_cr_comm_human6");
            break;		
	    case 17:
            spawn_npc("010_cr_comm_human60");
            break;
	    case 18:
            spawn_npc("010_cr_comm_human8");
            break;
        case 19:
            spawn_npc("010_cr_comm_human_f0");
            break;			
	    case 20:
            spawn_npc("010_cr_comm_human_f1");
            break;		
	    case 21:
            spawn_npc("010_cr_comm_human_m0");
            break;
	    case 22:
            spawn_npc("010_cr_comm_human_m1");
            break;
        default:
            spawn_npc("010_cr_comm_human7");
       }				
}
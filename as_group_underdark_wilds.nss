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
		
	switch(Random(10)) {
		// easy (cr0-2)
		case 0:
			switch(Random(14)) {
				case 0:
					spawn_group("skeletons_low");
            		break;
				case 1:
            		spawn_group("spiders_small");
            		break;
				case 2:
		            spawn_group("zombies_low");
		            break;
				case 3:
				case 4:
					spawn_group("svirf_patrol");
					break;
				case 5:
				case 6:
					spawn_group("animal_rothe");
					spawn_group("animal_rothe");
					spawn_group("animal_rothe",0.5);
					spawn_group("animal_rothe",0.5);
					break;
				case 7:
				case 8:
					spawn_group("drow_patrol");
					break;
				case 9:
				case 10:
					spawn_group("duergar_patrol");
					break;
				case 11:
					spawn_group("goblin_raiders");
					break;
				default:
					spawn_group("gibberlings");
			}
			break;
		// medium (cr3-5)
		case 1:
		case 2:
		case 3:
			switch(Random(13)) {
				case 0:
					spawn_group("constructs");
					break;
				case 1:
					spawn_group("shadows_low");
					break;
				case 2:
				case 3:
					spawn_group("bugbears");
					break;
				case 4:
					spawn_group("phaerlock_low");
					break;
				case 5:
					spawn_group("spiders_high");
					break;
				case 6:
					spawn_group("baphitaur_low");
					break;
				case 7:
				case 8:
					spawn_group("spiders_medium");
					break;
				case 9:
					spawn_group("skeletons_guard");
					break;
				case 10:
					spawn_group("zombies_elite");
					break;
				case 11:
					spawn_group("wererat_troupe");
					break;
				default:
					spawn_group("ooze");
					
			}
			break;
		// difficult (cr 6+)
		default:
			switch(Random(15)) {
				case 0:
					spawn_hostile_npc("010_cr_aberration_drider");
					break;
				case 1:
					spawn_group("shadows_med");
					break;
				case 2:
					spawn_group("abr_cr_mb_grender");
					break;
				case 3:
					spawn_hostile_npc("010_cr_ab_umberhulk");
					break;
				case 4:
				case 5:
					spawn_group("drow_slavers");
					break;
				case 6:
					spawn_group("myconid_troupe");
					break;
				case 7:
				case 8:
					spawn_group("duergar_raiders");
					break;
				case 9:
					spawn_group("vampire_troupe");
					break;
				case 10:
					spawn_group("derro_raiders");
					break;
				case 11:
					spawn_group("abishai");
					break;
				case 12:
					spawn_group("trolls");
					break;
				case 13:
					spawn_hostile_npc("010_cr_aber_beholder");
					break;
				default:
					spawn_hostile_npc("abr_cr_ab_mindflayer");
				
			}
	}

}	


    
			
   

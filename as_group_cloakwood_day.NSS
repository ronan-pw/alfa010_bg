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
	
	switch(Random(35)) {
        case 0:
            spawn_hostile_npc("010_cr_humanoid_gargoyle");
			spawn_hostile_npc("010_cr_humanoid_gargoyle",0.5);
            break;
        case 1:
			spawn_group("trolls",0.5);
			spawn_group("trolls",0.5);
			spawn_group("trolls",0.5);
            break;
		case 2:
			spawn_hostile_npc("010_cr_an_stirge");
			spawn_hostile_npc("010_cr_an_stirge");
			spawn_hostile_npc("010_cr_an_stirge",0.5);
			spawn_hostile_npc("010_cr_an_stirge",0.5);
			spawn_hostile_npc("010_cr_an_stirge",0.5);
			spawn_hostile_npc("010_cr_an_stirge",0.5);
			spawn_hostile_npc("010_cr_an_stirge",0.5);
			spawn_hostile_npc("010_cr_an_stirge",0.5);
			break;
		case 3:	
            spawn_group("gibberlings");
			spawn_group("gibberlings",0.5);
			break;	
        case 4:
			spawn_group("bandits");
            break;
        case 5:
			if (get_area_region() == 4)
				spawn_group("lycanthrope");
			else 
	            spawn_group("gnoll_hunters",0.5);
				
            break;			
		case 6:	
			spawn_placeable("phat_lewt_crate");
			
			if (get_area_region() == 4)
				spawn_group("lycanthrope");
			else {
				spawn_group("kobolds_low");
				spawn_group("kobolds_low",0.5);
				spawn_group("kobolds_elite",0.5);
				spawn_group("kobolds_elite",0.5);
				spawn_group("kobolds_boss",0.5);
				spawn_group("kobolds_boss",0.5);
			}
			
			break;
		case 7:	
			spawn_placeable("phat_lewt_crate");
						
			if (get_area_region() == 4)
				spawn_group("lycanthrope");
			else {
				spawn_group("goblins_low");
				spawn_group("goblins_low",0.5);
				spawn_group("goblins_med",0.5);
				spawn_group("goblins_med",0.5);
				spawn_group("goblins_boss",0.5);
				spawn_group("goblins_boss",0.5);
			}
			break;
        case 8:
			if (get_area_region() == 4)
				spawn_group("lycanthrope");
			else {
            	spawn_hostile_npc("tg_treant1");
			}
            break;
		case 9:
		case 10:
			if (get_area_region() == 4)
				spawn_group("lycanthrope");
			else 
				spawn_group("fey");
            break;
        case 11:
            spawn_hostile_npc("abr_cr_vm_spider_mediumhunt");
            spawn_hostile_npc("abr_cr_vm_spider_smallhunt");
            spawn_hostile_npc("abr_cr_vm_spider_smallhunt");
            spawn_hostile_npc("abr_cr_vm_spider_tinyhunt");
            spawn_hostile_npc("abr_cr_vm_spider_tinyhunt");
            break;
		case 12:	
            spawn_hostile_npc("abr_cr_vm_spider_largehunt");
            break;		
	    case 13:
            spawn_group("rats_high");
            break;
        case 14:
            spawn_hostile_npc("abr_cr_gt_ogre");
			break;
		case 15:	
			spawn_group("complex");
			break;		
		case 16:
			spawn_hostile_npc("010_cr_an_wolf_timber");
			spawn_hostile_npc("010_cr_an_wolf_timber");
			spawn_hostile_npc("010_cr_an_wolf_timber",0.5);
			spawn_hostile_npc("010_cr_an_wolf_timber",0.5);
            break;
		case 17:
            spawn_hostile_npc("abr_cr_vm_beetle_stag");
           break;		
		case 18:	
			spawn_hostile_npc("010_cr_undead_wight",0.5);
			spawn_hostile_npc("010_cr_undead_wight1",0.5);
			break;			
		case 19:
			switch (Random(6)) {
				case 0:
				case 1:
					spawn_group("shadows_low");
					break;
				case 2:
					spawn_hostile_npc("abr_cr_gt_ogremage");
					spawn_hostile_npc("abr_cr_gt_ogre");
					break;
				case 3:
					spawn_hostile_npc("abr_cr_dragon_wyvern");
					break;
				case 4:
					spawn_group("shadows_high");
					break;
				default:
					spawn_hostile_npc("010_cr_hillgiant");
			}
			break;
		default:
			switch (Random(2)) {
				case 0:
					spawn_group("wild_nonhostile");
					break;
				default:
					spawn_group("wild");
			}
	}
}	
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
		
	switch(Random(20)) {
        case 0:
            spawn_hostile_npc("010_cr_humanoid_gargoyle");
            break;
        case 1:
			spawn_group("trolls",0.5);
			spawn_group("trolls",0.5);
			spawn_group("trolls",0.5);
            break;
		case 2:	
			spawn_group("zombies_low");
			spawn_group("zombies_low",0.5);
			spawn_group("zombies_low",0.5);
			spawn_group("zombies_elite",0.5);
			break;	
        case 3:
            spawn_hostile_npc("abr_cr_dragon_wyvern");
            break;
        case 4:
            spawn_group("shadows_low");
			spawn_group("shadows_low",0.5);
            break;			
	    case 5:
			if (get_area_region() == 4)
				spawn_group("lycanthrope");
			else 
	            spawn_group("gnoll_hunters",0.5);
				
            break;
		case 6:
		case 7:	
			if (get_area_region() == 4)
				spawn_group("lycanthrope");
			else 
				spawn_group("fey");
			break;
        case 8:
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
		case 9:	
			if (get_area_region() == 4)
				spawn_group("lycanthrope");
			else {
            	spawn_hostile_npc("tg_treant1");
			}
            break;
        case 10:
            spawn_group("abr_cr_vm_spider_hugehunt");
            break;
        case 11:
            spawn_group("abr_cr_vm_spider_mediumhunt");
            spawn_group("abr_cr_vm_spider_smallhunt");
            spawn_group("abr_cr_vm_spider_smallhunt");
            spawn_group("abr_cr_vm_spider_largehunt");
            spawn_group("abr_cr_vm_spider_tinyhunt");
            break;
		case 12:	
            spawn_group("abr_cr_vm_beetle_doombugb");
			spawn_group("abr_cr_vm_beetle_doombug");
            break;		
	    case 13:
            spawn_group("010_cr_ratdire");
			spawn_group("010_cr_ratdire");
			spawn_group("010_cr_ratdire");
			spawn_group("010_cr_ratdire");
            break;
        case 14:
            spawn_group("abr_cr_gt_ogre");
			spawn_group("abr_cr_gt_ogre");
			spawn_group("abr_cr_gt_ogre_war");
			break;
		case 15:	
			if (get_area_region() == 4)
				spawn_group("lycanthrope");
			else {
            	spawn_hostile_npc("tg_treant1");
			}
			break;		
		case 16:
			spawn_group("010_cr_an_wolf_timber");
			spawn_group("010_cr_an_wolf_timber");
            break;
		case 17:
            spawn_hostile_npc("abr_cr_vm_beetle_stag");
           break;		
		case 18:	
			spawn_hostile_npc("010_cr_undead_wight",0.5);
			spawn_hostile_npc("010_cr_undead_wight1",0.5);
			spawn_hostile_npc("010_cr_undead_wight",0.5);
			spawn_hostile_npc("010_cr_undead_wight1",0.5);
			break;			
		default:
			switch (Random(5)) {
				case 0:
					if (get_area_region() == 5)
					{
						spawn_hostile_npc("abr_cr_drow_fighter01");
						spawn_hostile_npc("abr_cr_drow_fighter02");
						spawn_hostile_npc("abr_cr_drow_cleric01");
						spawn_hostile_npc("abr_cr_drow_wizard01");
						break;
					}
				case 1:
					spawn_hostile_npc("abr_cr_mh_greenhag");
					break;
				case 2:
					spawn_hostile_npc("abr_cr_gt_ogremage");
            		spawn_hostile_npc("abr_cr_gt_ogre");
					spawn_hostile_npc("abr_cr_gt_ogre");
					spawn_hostile_npc("abr_cr_gt_ogre_war");
					break;
				default:
					spawn_hostile_npc("010_cr_hillgiant");
					break;
			}
           				
		break;}
}	
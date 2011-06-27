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
	object o;
	
	// fire
	if (Random(3) == 0) {
		switch (Random(5)) {
			case 0:
				spawn_placeable("plc_mr_campfire1", 1.0, 50.0, 0.0, 3.0);
				break;
			case 1:
				spawn_placeable("plc_mr_campfire2", 1.0, 50.0, 0.0, 3.0);
				spawn_placeable("plc_ml_tripodm1", 0.5, 50.0, 0.0, 3.0);
				break;
			case 2:
				spawn_placeable("plc_mr_campfire3", 1.0, 50.0, 0.0, 3.0);
				spawn_placeable("plc_ml_tripodm1", 0.5, 50.0, 0.0, 3.0);
				break;
			case 3:
				spawn_placeable("plc_mr_campfire4", 1.0, 50.0, 0.0, 3.0);
				break;
			case 4:
				spawn_placeable("plc_ml_cauldrong", 1.0, 50.0, 0.0, 3.0);
				break;
		}
	}
	
	// wagon
	if (Random(3) == 0) {
		spawn_group("animal_horse");
		spawn_group("animal_horse", 0.5);
		switch (Random(10)) {
			case 0:
				spawn_placeable("plc_mr_wagon01");
				break;
			case 1:
				spawn_placeable("plc_mr_wagon02");
				break;
			case 2:
				spawn_placeable("plc_mr_wagon02br");
				break;
			case 3:
				spawn_placeable("plc_mr_wagon01br");
				break;
			case 4:
				spawn_placeable("plc_mc_merchwagon3_x2");
				break;
			case 5:
				spawn_placeable("plc_mr_wagon03");
				break;
			case 6:
				spawn_placeable("plc_mr_wagon06");
				break;
			case 7:
				spawn_placeable("plc_mc_merchwagon1");
				break;
			case 8:
				spawn_placeable("plc_mc_merchwagon2");
				break;
			case 9:
				spawn_placeable("plc_mc_merchwagon4_x2");
				break;
		}
	}
	
	// Tent
	if (Random(5) == 0) {
		spawn_placeable("plc_bl_tents01", 0.5, 180.0);
		spawn_placeable("plc_bl_tents02", 0.5, 240.0);
	}
	
	// Containers
	if (Random(4) == 0) {
		spawn_placeable("plc_ml_chestl01", 0.5, 70.0, 0.0);
		spawn_placeable("plc_ml_chestl02", 0.5, 80.0, 0.0);
		spawn_placeable("plc_mc_crate04", 0.5, 90.0, 0.0);
		spawn_placeable("plc_mc_crate05", 0.5, 100.0, 0.0);
		spawn_placeable("plc_mc_crate08", 0.5, 110.0, 0.0);;
	}
	
	// dog
	spawn_group("animal_dog",0.1);
	spawn_group("animal_dog",0.1);
	spawn_group("animal_dog",0.1);
	
	switch(Random(13)) {
        case 0:
			spawn_npc("abr_cr_npc_cl_3_lath", 0.5);
			spawn_npc("abr_cr_npc_ftr_3", 0.5);
			spawn_npc("abr_cr_npc_wiz_3", 0.5);
			spawn_group("commoner", 0.5);
            spawn_group("merchant0", 0.5);
            break;
        case 1:
			spawn_npc("abr_cr_npc_cl_3_lath",0.5);
			spawn_npc("abr_cr_npc_ftr_3", 0.5);
			spawn_npc("abr_cr_npc_wiz_3", 0.5);
			spawn_group("commoner", 0.5);
			spawn_group("merchant1", 0.5);
            break;
			
		case 2:
			spawn_npc("abr_cr_npc_cl_3_lath", 0.5);
			spawn_npc("abr_cr_npc_ftr_3", 0.5);
			spawn_npc("abr_cr_npc_wiz_3", 0.5);
			spawn_group("commoner", 0.5);
			spawn_group("merchant0", 0.5);
			spawn_group("merchant1", 0.5);
			break;
			
        case 3:
			spawn_npc("abr_cr_npc_brb_3", 0.5);
			spawn_npc("abr_cr_npc_cl_3_lath", 0.5);
			spawn_npc("abr_cr_npc_ftr_3", 0.5);
			spawn_npc("abr_cr_npc_rog_3", 0.5);
			spawn_npc("abr_cr_npc_wiz_3", 0.5);
            break;			
	    case 4:
			spawn_npc("abr_cr_npc_brb_3", 0.5);
			spawn_npc("abr_cr_npc_cl_3_lath", 0.5);
			spawn_npc("abr_cr_npc_ftr_3", 0.5);
			spawn_npc("abr_cr_npc_rog_3", 0.5);
			spawn_npc("abr_cr_npc_wiz_3", 0.5);
			spawn_group("child", 0.5);
			spawn_group("commoner", 0.5);
			spawn_group("commoner", 0.5);
			spawn_group("commoner", 0.5);
			spawn_group("commoner", 0.5);
			spawn_group("commoner", 0.5);
			spawn_group("commoner", 0.5);
			spawn_group("commoner", 0.5);
			spawn_group("commoner", 0.5);
            break;
        case 5:
			spawn_group("child", 0.5);
			spawn_group("child", 0.5);
			spawn_group("commoner", 0.5);
			spawn_group("commoner", 0.5);
			spawn_group("commoner", 0.5);
			spawn_group("commoner", 0.5);
			spawn_group("commoner", 0.5);
			spawn_group("commoner", 0.5);
			spawn_group("commoner", 0.5);
			spawn_group("commoner", 0.5);
			spawn_group("animal_horse", 0.5);
			spawn_group("animal_horse", 0.5);
            break;
        case 6:
			spawn_group("child", 0.5);
			spawn_group("commoner", 0.5);
			spawn_group("commoner", 0.5);
			spawn_group("commoner", 0.5);
			spawn_group("commoner", 0.5);
			spawn_group("commoner", 0.5);
			spawn_group("animal_cow", 0.5);
			spawn_group("animal_cow", 0.5);
            break;	
	    case 7:
			spawn_npc("abr_cr_npc_cl_3_lath", 0.5);
			spawn_npc("abr_cr_npc_ftr_3", 0.5);
			spawn_npc("abr_cr_npc_wiz_3", 0.5);
			o = spawn_npc("010_nashkel_amnian_infantry", 0.5);
			if (GetIsObjectValid(o)) {
				SetFirstName(o,"Mercenary");
				SetLastName(o,"");
			}
			o = spawn_npc("010_nashkel_amnian_infantry", 0.5);
			if (GetIsObjectValid(o)) {
				SetFirstName(o,"Mercenary");
				SetLastName(o,"");
			}
			spawn_npc("amn_noble1", 0.5);
			spawn_npc("amn_noblef1", 0.5);
			spawn_npc("amn_noble2", 0.5);
			spawn_npc("amn_noblef2", 0.5);
            break;
		case 8:
			spawn_npc("10_cr_tempus_cleric", 0.5);
			break;
		default:
			ACR_SpawnGroup("friendly_guard");
	}
}
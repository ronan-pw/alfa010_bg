////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Spawn System
//     Filename : as_group_complex.nss
//      Version : 1.3
//         Date : 2007-4-24
//       Author : Ronan
//
//  Description
//  This is a complex example of a spawn group script which is used by the ACR's
//  spawn system. Though the name of the script is "as_group_complex", the spawn
//  point which uses this script would simply have "complex" listed as a spawn
//  group name, since the "as_group_" is always added on to the beginning. This
//  example is intended for people familiar with programming. For a simpler
//  example, see the script as_group_example.
//
//  Revision History
//  1.0 2006-09-17: Ronan - Inception
//  1.1 2007-04-24: AcadiusLost: altered to use ABR resource names.
//  1.2 2007-04-26: AcadiusLost: switched placables to base-pallete resources
//  1.3 2007-04-27: AcadiusLost: fixed a typo in placables
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

// 7,634
void main() {
	switch(Random(6)) 
	{
	case 0:
		spawn_hostile_npc("abr_cr_ou_abishai_black");
		spawn_hostile_npc("abr_cr_ou_abishai_black",0.5);
		spawn_hostile_npc("abr_cr_ou_abishai_black",0.5);
		break;
	case 1:
		spawn_hostile_npc("010_cr_out_erinyes",0.5);
		spawn_hostile_npc("abr_cr_ou_imp",0.5);
		spawn_hostile_npc("abr_cr_ou_imp",0.5);
		spawn_hostile_npc("abr_cr_ou_imp",0.5);
		spawn_hostile_npc("abr_cr_ou_hellhound",0.5);
		break;
	case 2:
		spawn_hostile_npc("abr_cr_ou_succubus",0.5);
		spawn_hostile_npc("abr_cr_ou_quasit",0.5);
		spawn_hostile_npc("abr_cr_ou_quasit",0.5);
		spawn_hostile_npc("abr_cr_ou_quasit",0.5);
		break;
	case 3:
		spawn_hostile_npc("abr_cr_ou_meph_fire");
		spawn_hostile_npc("abr_cr_ou_meph_fire",0.5);
		spawn_hostile_npc("abr_cr_ou_meph_fire",0.5);
		spawn_hostile_npc("abr_cr_ou_meph_fire",0.5);
		break;
	case 4:
		spawn_hostile_npc("abr_cr_ou_genie_efreeti");
		break;
	case 5:
		spawn_hostile_npc("010_cr_elementalfire2",0.5);
		spawn_hostile_npc("010_cr_elementalfire2",0.5);
		spawn_hostile_npc("010_cr_elementalfire1",0.5);
		spawn_hostile_npc("010_cr_elementalfire1",0.5);
		spawn_hostile_npc("010_cr_elementalfire0",0.5);
		spawn_hostile_npc("010_cr_elementalfire0",0.5);
		break;
	default:
		spawn_hostile_npc("abr_cr_ou_abishai_black",0.5);
		spawn_hostile_npc("abr_cr_ou_abishai_green",0.5);
		spawn_hostile_npc("abr_cr_ou_abishai_white",0.5);
		spawn_hostile_npc("abr_cr_ou_abishai_red",0.5);
		spawn_hostile_npc("abr_cr_ou_abishai_blue",0.5);
	}
}

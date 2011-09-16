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

	int n = get_area_region();
	WriteTimestampedLogEntry("ACR_Spawn(guard): get_area_region(): retval = "+IntToString(n));

	switch (n) {
		// beregost
		case 2:
		case 7:
			switch (Random(2)) {
				case 0:
					spawn_npc("templeoflathanderpike01", 0.5);
					spawn_npc("templeoflathanderpike01", 0.5);
					spawn_npc("templeoflathandermanatarms01", 0.5);
					spawn_npc("templeoflathandermanatarms01", 0.5);
					spawn_npc("templeoflathanderguard", 0.5);
					spawn_npc("templeoflathanderbow01", 0.5);
		            break;
				default:
					spawn_npc("templeoflathandermanatarms01", 0.5);
					spawn_npc("10_cr_merchant_bow", 0.5);
					spawn_npc("10_cr_merchant_clr", 0.5);
					spawn_npc("10_cr_merchant_ftr", 0.5);
			}
			break;
		// candlekeep
		case 3:
			spawn_npc("abr_cr_npc_cl_3_lath", 0.5);
			spawn_npc("010_cr_ck_guard", 0.5);
			spawn_npc("010_cr_ck_guard", 0.5);
			spawn_npc("010_cr_ck_guard", 0.5);
			spawn_npc("010_cr_ck_guard", 0.5);
			spawn_npc("010_cr_ck_guard", 0.5);
			break;
		// amn
		case 4:
		case 8:
			spawn_npc("abr_cr_npc_cl_3_lath", 0.5);
			spawn_npc("010_nashkel_amnian_infantry", 0.5);
			spawn_npc("010_nashkel_amnian_infantry", 0.5);
			spawn_npc("010_nashkel_amnian_infantry", 0.5);
			spawn_npc("010_nashkel_amnian_infantry", 0.5);
			spawn_npc("010_nashkel_amnian_infantry", 0.5);
			break;
		// bg
		default:
			switch (Random(3)) {
		        case 0:
					spawn_npc("10_ksiel_flamingfist_cleric01", 0.5);
					spawn_npc("10_ksiel_flamingfist_archer01", 0.5);
					spawn_npc("ffm_sword", 0.5);
					spawn_npc("10_ksiel_flamingfist_scout01", 0.5);
					spawn_npc("10_ksiel_flamingfist_sergeant01", 0.5);
					spawn_npc("ffm_sword", 0.5);
		            break;
			    case 1:
					spawn_npc("10_cr_merchant_bow", 0.5);
					spawn_npc("10_cr_merchant_bow", 0.5);
					spawn_npc("10_cr_merchant_clr", 0.5);
					spawn_npc("10_cr_merchant_clr", 0.5);
					spawn_npc("10_cr_merchant_ftr", 0.5);
					spawn_npc("10_cr_merchant_ftr", 0.5);
					spawn_npc("10_cr_merchant_ftr", 0.5);
		            break;
			    default:
					spawn_npc("10_cr_merchant_ftr", 0.5);
					spawn_npc("10_cr_merchant_bow", 0.5);
					spawn_npc("10_cr_merchant_clr", 0.5);
					spawn_npc("10_cr_merchant_ftr", 0.5);
			}
	}
}	
    
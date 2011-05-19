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
	int n=3;
	int m=2;
	int k=4;
	int i=2;

		if (Random(2) == 0) {
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
		
		if (Random(2*n) == 0) {
			o = spawn_npc("010_cr_bane_brencis");
			SetFirstName(o,"Warrior");
		}
			
		if (Random(2*n) == 0) {
			o = spawn_npc("010_cr_bane_tarquin");
			SetFirstName(o,"Warrior");
		}
		
		if (Random(n) == 0) {
			o = spawn_npc("010_cr_bane_corgis");
			SetFirstName(o,"Warrior");
		}
			
		if (Random(n) == 0) {
			o = spawn_npc("010_cr_bane_dorm");
			SetFirstName(o,"Warrior");
		}
			
		if (Random(n) == 0) {
			o = spawn_npc("010_cr_bane_lucius");
			SetFirstName(o,"Warrior");
		}
			
		if (Random(n) == 0) {
			o = spawn_npc("010_cr_bane_morgan");
			SetFirstName(o,"Warrior");
		}
			
		if (Random(n) == 0) {
			o = spawn_npc("010_cr_bane_nix");
			SetFirstName(o,"Warrior");
		}
			
		if (Random(n) == 0) {
			o = spawn_npc("010_cr_bane_victoria");
			SetFirstName(o,"Warrior");
		}
}
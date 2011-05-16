////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Spawn System
//     Filename : as_group_complex.nss
//      Version : 1.3
//         Date : 2007-4-24
//       Author : Ronan
//
//  Description
//  This is a complex example of a spawn group script which is used by the ACR"s
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
// Banite Patrol or random monsters

	WriteTimestampedLogEntry("ACR_Spawn: spawning banites0");

	ACR_SpawnGroup("wild_nonhostile");
	//object o;
	//int n=3, m=2, k=4, i=2;
/*	
	if (Random(i)) {
	
		if (Random(2)) {
			ACR_SpawnObject("plc_ml_cauldrong", OBJECT_TYPE_PLACEABLE);
		}
		
		if (!Random(2*n)) {
			o = ACR_SpawnObject("010_cr_bane_brencis", OBJECT_TYPE_CREATURE);
			SetFirstName(o,"Warrior");
		}
			
		if (!Random(2*n)) {
			o = ACR_SpawnObject("010_cr_bane_tarquin", OBJECT_TYPE_CREATURE);
			SetFirstName(o,"Warrior");
		}
		
		if (!Random(n)) {
			o = ACR_SpawnObject("010_cr_bane_corgis", OBJECT_TYPE_CREATURE);
			SetFirstName(o,"Warrior");
		}
			
		if (!Random(n)) {
			o = ACR_SpawnObject("010_cr_bane_dorm", OBJECT_TYPE_CREATURE);
			SetFirstName(o,"Warrior");
		}
			
		if (!Random(n)) {
			o = ACR_SpawnObject("010_cr_bane_lucius", OBJECT_TYPE_CREATURE);
			SetFirstName(o,"Warrior");
		}
			
		if (!Random(n)) {
			o = ACR_SpawnObject("010_cr_bane_morgan", OBJECT_TYPE_CREATURE);
			SetFirstName(o,"Warrior");
		}
			
		if (!Random(n)) {
			o = ACR_SpawnObject("010_cr_bane_nix", OBJECT_TYPE_CREATURE);
			SetFirstName(o,"Warrior");
		}
			
		if (!Random(n)) {
			o = ACR_SpawnObject("010_cr_bane_victoria", OBJECT_TYPE_CREATURE);
			SetFirstName(o,"Warrior");
		}
	}
	else {*/
		/*i = Random(m);
		if (i == 0)
			ACR_SpawnGroup("wild_nonhostile");
		else if (i == 1) 
			ACR_SpawnGroup("wild");
		
		else if (i == 2)
		{
				int nType = d100();
				if (nType <= 50) 
					ACR_SpawnObject("010_nashkell_merchant", OBJECT_TYPE_CREATURE);
				else
					ACR_SpawnObject("010_nashkell_merchant2", OBJECT_TYPE_CREATURE);
		}*/
	//}
}
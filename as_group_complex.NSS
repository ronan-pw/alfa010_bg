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
    // Lets say this spawn group is an orc encampment. Its got some level 1
    // warrior orcs, a shaman, some tents, a cookpot and a few poor
    // goblin runts for the orcs to kick around.

			spawn_placeable("phat_lewt_crate",0.5);
			spawn_placeable("plc_ml_cauldrong", 1.0, 0.0, 180.0, 1.0);
		
			spawn_placeable("plc_br_tentm01", 1.0, 30.0);
			spawn_placeable("plc_bl_tentm02", 1.0, 80.0);
			spawn_placeable("plc_br_tentm01", 1.0, 120.0);
		
		    spawn_hostile_npc("010_sand_orc1");
		    spawn_hostile_npc("010_sand_orc2");
		    spawn_hostile_npc("010_sand_orc3");
		    spawn_hostile_npc("010_sand_orc11");
			spawn_hostile_npc("010_sand_orc1",0.5);
		    spawn_hostile_npc("010_sand_orc2",0.5);
		    spawn_hostile_npc("010_sand_orc3",0.5);
		    spawn_hostile_npc("010_sand_orc11",0.5);
			spawn_hostile_npc("abr_cr_hu_orcbattlepriest",0.5);
			spawn_hostile_npc("abr_cr_hu_orctracker",0.5);
			
    // We're done! This spawn group spawned both placeables and creatures in the
    // same group. But you don't have to do this, you can place each of these in
    // their own seperate spawn groups. Why do this? Because it allows the
    // re-use of spawn groups for many purposes. For example, a "camp with
    // cookpot" spawn group could be used on many different points, and combined
    // with other spawn groups such as human rangers, barbarians, gnolls,
    // wood elves, or many other things. A builder could set up a encampment
    // and populate that encampment with a random spawn group chosen from the
    // ACR_SPAWN_GROUP_RANDOM array on the spawn point.
}
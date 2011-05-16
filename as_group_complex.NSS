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

    // First, lets place the cookpot in the middle of the spawn point.
    ACR_SpawnObject("plc_ml_cauldrong", OBJECT_TYPE_PLACEABLE);

    // Now lets place 3 tents in a circle around it.
    location lLoc = ACR_GetSpawnLocationFromDirectionAndFacing(
        0.0,    // zero degrees, put this one at 12 o'clock.
        6.0,    // Six meters out, so the radius of the circle is 6m.
        180.0); // Flipped around 180 degrees, so it faces the center of the
                // spawn point, and therefore the firepot.
    ACR_SpawnObjectAtLocation("plc_br_tentm01", OBJECT_TYPE_PLACEABLE, lLoc);

    lLoc = ACR_GetSpawnLocationFromDirectionAndFacing(
        120.0,  // 120 degrees, put this one at 4 o'clock.
        6.0,    // Six meters out, so the radius of the circle is 6m.
        300.0); // Turned 180 + 120 degrees, so it faces the center.
    ACR_SpawnObjectAtLocation("plc_bl_tentm02", OBJECT_TYPE_PLACEABLE, lLoc);

    lLoc = ACR_GetSpawnLocationFromDirectionAndFacing(
        240.0,  // 240 degrees, put this one at 8 o'clock.
        6.0,    // Six meters out, so the radius of the circle is 6m.
        60.0); // Turned 180 + 240 degrees, so it faces the center.
    ACR_SpawnObjectAtLocation("plc_br_tentm01", OBJECT_TYPE_PLACEABLE, lLoc);

    // Lets spawn the orcs in the center.
    ACR_SpawnObject("010_sand_orc1", OBJECT_TYPE_CREATURE);
    ACR_SpawnObject("010_sand_orc2", OBJECT_TYPE_CREATURE);
    ACR_SpawnObject("010_sand_orc3", OBJECT_TYPE_CREATURE);
    ACR_SpawnObject("010_sand_orc11", OBJECT_TYPE_CREATURE);

    // This one is the shaman:
    //ACR_SpawnObject("abr_cr_hu_orcbattlepriest", OBJECT_TYPE_CREATURE);

    // As usual, the goblins have been bullied into doing the job no one wants:
    // keeping watch. So they are scattered about on at three waypoints which the
    // builder has placed and tagged "gobo_scouts". Lets find these waypoints.
    int i;
    // We loop three times, one for each possible waypoint.
    for(i = 1; i <= 3; i++) {
        // Lets find the ith nearest waypoint to the center of the spawn point,
        // and place the ith group of goblins there.
        object oWP = GetNearestObjectByTag("gobo_scouts", OBJECT_SELF, i);

        // Lets make sure this waypoint actually exists in this area. If it
        // doesn't, we don't want to try to spawn anything at it. That would be
        // Very Bad.
        location lLoc;
        if(oWP != OBJECT_INVALID) {
            // Waypoint found in area, spawn the goblins there.
            lLoc = GetLocation(oWP);
        } else {
            // No waypoint found, buider error. Lets just put them back at the
            // camp.
            lLoc = GetLocation(OBJECT_SELF);
            PrintString("Hey! Someone forgot a waypoint of tag 'gobo_scouts' for"
                        + " my orc camp spawn group in area " + GetName(GetArea(OBJECT_SELF))
                        + "! I bet this is Fionn's fault.");
        }

        // Now lets actually spawn the goblins at whichever location we've
        // decided on.
        ACR_SpawnObjectAtLocation("010_cr_goblin1", OBJECT_TYPE_CREATURE, lLoc);
        ACR_SpawnObjectAtLocation("010_cr_goblin2", OBJECT_TYPE_CREATURE, lLoc);
        ACR_SpawnObjectAtLocation("010_cr_goblin0", OBJECT_TYPE_CREATURE, lLoc);
    }

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
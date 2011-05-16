////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Spawn System
//     Filename : as_group_example.nss
//      Version : 1.1
//         Date : 2007-4-24
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
//  1.0 2006-09-17: Ronan - Inception
//  1.1 2007-04-24: AcadiusLost: altered to use ABR resource names.
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

void main() {
    // Lets say this spawn group is an orc hunting party. Lets spawn some level
    // 1 warrior orcs, with either a level 3 leader who is either a barbarian,
    // ranger, or cleric.
    ACR_SpawnObject("abr_cr_hu_orcbasher02", OBJECT_TYPE_CREATURE);
    // The string "abr_cr_hu_orcbasher02" is the creature's resource name in the toolset. Make
    // sure you spell it right, or the creature will either not spawn, or
    // something else may spawn in its place!
    // OBJECT_TYPE_CREATURE tells the spawn system what type of object you are
    // trying to spawn. For other object types, use OBJECT_TYPE_ITEM,
    // OBJECT_TYPE_PLACEABLE, OBJECT_TYPE_STORE or OBJECT_TYPE_WAYPOINT.

    // Lets add three more of those generic orc warriors.
    ACR_SpawnObject("abr_cr_hu_orcbasher02", OBJECT_TYPE_CREATURE);
    ACR_SpawnObject("abr_cr_hu_orcbasher03", OBJECT_TYPE_CREATURE);
    ACR_SpawnObject("abr_cr_hu_orcbasher03", OBJECT_TYPE_CREATURE);
    
	location lLoc = ACR_GetSpawnLocationFromDirectionAndFacing(
        240.0,  // 240 degrees, put this one at 8 o'clock.
        6.0,    // Six meters out, so the radius of the circle is 6m.
        60.0); // Turned 180 + 240 degrees, so it faces the center.
    ACR_SpawnObjectAtLocation("abr_cr_hu_orcbasher02", OBJECT_TYPE_CREATURE, lLoc);
	
    // Now lets say we have 3 possible leaders for this group of thugs. We want
    // to randomly select one of them.
    switch(Random(3)) {
        // Each "case" is a possible result of random(3). So only one of the
        // following will be run. And yes, its supposed to start at 0 and not
        // reach 3, Random(3) returns a number from 0 to 2.
        case 0:
            // This is a level 2 barbarian / 1 humanoid orc.
            ACR_SpawnObject("abr_cr_hu_orcberserker", OBJECT_TYPE_CREATURE);
            break;
        case 1:
            // This is a level 2 ranger / 1 humanoid orc.
            ACR_SpawnObject("abr_cr_hu_orctracker", OBJECT_TYPE_CREATURE);
            break;
        case 2:
            // This is a level 2 cleric / 1 humanoid.
            ACR_SpawnObject("abr_cr_hu_orcbattlepriest", OBJECT_TYPE_CREATURE);
            break;
    }
}
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

const int TELEPORT_DESPAWN_DELAY = 1;

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

void TeleportDespawn(object oCreature);

void ScheduleTeleport(object oCreature);

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void TeleportDespawn(object oCreature) {
	if(GetIsInCombat(oCreature)) {
		ScheduleTeleport(oCreature);
		return;
	}
	
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(33), GetLocation(oCreature));
	DestroyObject(oCreature, 6.0);
}

void ScheduleTeleport(object oCreature) {
	DelayCommand(HoursToSeconds(TELEPORT_DESPAWN_DELAY), TeleportDespawn(oCreature));
}

void main() {

	// Only 1 out of 10 points spawns.
	if(Random(10)) return;

	// Spawns in Throrgar are highly random.
	switch(Random(20)) {
		case 0: 
		case 1: 
		case 2: 
		case 3: 
		case 4:
			ScheduleTeleport(ACR_SpawnObject("abr_cr_ou_demon_hezrou", OBJECT_TYPE_CREATURE)); break;
		case 5:
		case 6:
		case 7:
			ScheduleTeleport(ACR_SpawnObject("abr_cr_ou_demon_hezrou", OBJECT_TYPE_CREATURE));
			ScheduleTeleport(ACR_SpawnObject("abr_cr_ou_demon_hezrou", OBJECT_TYPE_CREATURE)); break;
		case 8: 
		case 9:			
		case 10:
		case 11:
		case 13:
			ScheduleTeleport(ACR_SpawnObject("abr_cr_ou_demon_babau", OBJECT_TYPE_CREATURE)); break;
		case 14:
		case 15:
			ScheduleTeleport(ACR_SpawnObject("abr_cr_ou_demon_babau", OBJECT_TYPE_CREATURE));
			ScheduleTeleport(ACR_SpawnObject("abr_cr_ou_demon_babau", OBJECT_TYPE_CREATURE));
			ScheduleTeleport(ACR_SpawnObject("abr_cr_ou_demon_babau", OBJECT_TYPE_CREATURE)); break;
		case 16:
		case 17:
		case 18:
			ScheduleTeleport(ACR_SpawnObject("abr_cr_ou_demon_babau", OBJECT_TYPE_CREATURE));
			ScheduleTeleport(ACR_SpawnObject("abr_cr_ou_demon_babau", OBJECT_TYPE_CREATURE)); break;
		case 19:
			ScheduleTeleport(ACR_SpawnObject("abr_cr_ou_demon_babau", OBJECT_TYPE_CREATURE)); break;
	}
}
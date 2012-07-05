////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ALFA Configuration File
//     Filename : acf_mod_onmoduleload.nss
//    $Revision:: 197        $ current version of the file
//        $Date:: 2006-12-23#$ date the file was created or modified
//       Author : Ronan
//
//  Local Variable Prefix = None
//
//  Description
//  This script calls the module's OnLoad event, and any custom code added by
//  this server. It is usually used to set up server-specific options, such as
//  the population system (see below).
//  This file should NOT be overwriten in ACR updates so as to preserve any of
//  the server's customized code they may have added.
//
//  Revision History
//   2010/12/24  AcadiusLost - interim ModuleLoad code hack for server population and IP Address
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#include "acr_mod_events_i"
#include "acr_db_persist_i"
#include "010_door_i"
#include "010_throrgar_spire_i"

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

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main() {


    SetGlobalInt(_ACR_SETTINGS_SERVER_ID, 10);
	SetGlobalInt(_ACR_SETTINGS_SERVER_REGION, 3559);
	SetGlobalString(_ACR_SETTINGS_SERVER_NAME, "ALFA 010 Baldur's Gate");
	SetGlobalString(_ACR_SETTINGS_SERVER_IP, "giles.dynalias.org");
	
    ACR_ModuleOnModuleLoad();

    // Custom code goes below this line.
	object oInitialize = CreateObject(OBJECT_TYPE_ITEM, "n2_it_spoon", GetStartingLocation());
	DestroyCampaignDatabase("_acr_test");
	ACR_SetPersistentObject(GetModule(), "1", oInitialize, "_acr_test");
	DelayCommand(4.0, DestroyObject(oInitialize));
	DelayCommand(4.1, WriteTimestampedLogEntry("There is no spoon."));
	
	DelayCommand(6.0, InitializeDoors());

	SetLocalInt(GetModule(), "ACR_HEALTHMONITOR_GAMEOBJUPDATE_BACKOFF", 1);
	
	ExecuteScript("nwnx_craft_init", GetModule());

	CreateObject(OBJECT_TYPE_PLACEABLE, "x0_mod_treasure_low_admin", GetLocation(GetWaypointByTag("WP_ADMIN_LOOT_LOW")));
	CreateObject(OBJECT_TYPE_PLACEABLE, "x0_mod_treasure_med_admin", GetLocation(GetWaypointByTag("WP_ADMIN_LOOT_MED")));
	CreateObject(OBJECT_TYPE_PLACEABLE, "x0_mod_treasure_high_admin", GetLocation(GetWaypointByTag("WP_ADMIN_LOOT_HIGH")));
	CreateObject(OBJECT_TYPE_PLACEABLE, "x0_mod_treasure_uniq_admin", GetLocation(GetWaypointByTag("WP_ADMIN_LOOT_UNIQ")));

	InitializeThrorgarSpire();
}
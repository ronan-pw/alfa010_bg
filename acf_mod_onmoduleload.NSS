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

	//  Temporary: interim code from the ACR_OnModuleLoad() event
    object oModule = GetModule();
    
    // ORDER MATTERS !!

    // Start the debuging system and create debugging ids for the module event scripts
    ACR_InitializeDebugging();
    ACR_CreateDebugSystem(_ONLOAD_DEBUG, DEBUG_TARGET_LOG | DEBUG_TARGET_DB, DEBUG_TARGET_LOG | DEBUG_TARGET_DB, DEBUG_TARGET_LOG | DEBUG_TARGET_DB);
    string sServerId = IntToString(ACR_SERVER_ID);
    ACR_PrintDebugMessage("acr_mod_events_i: ALFA " + sServerId + " loading version " + ACR_VERSION + " of the ALFA Core Rules.", _ONLOAD_DEBUG, DEBUG_LEVEL_INFO);

    // Check NWNX status
    if (! NWNXInstalled())
    {
        // record the status
        ACR_SetModuleStatus(ACR_MOD_NWNX_FAILED);
        ACR_PrintDebugMessage("acr_mod_events_i: NWNX unavailable on ALFA server " + sServerId + ". Rescheduling OnModuleLoad(). Server restart may be required.", _ONLOAD_DEBUG, DEBUG_LEVEL_FATAL);

        // reschedule the OnModuleLoad() handler
        DelayCommand(ACR_MOD_RELOAD_CYCLE, ACR_ModuleOnModuleLoad());
        return;
    }
	else
	{
		// create the SQL tables if need be
		ACR_CreateSQLTables();
	}	

    // Initialize spell hook
    SetLocalString(oModule, "X2_S_UD_SPELLSCRIPT", "acr_spellhook");

    // Initialize storage objects used by many systems.
    // ACR_InitializeStorageObjects();

    // Initialize game engine constants.
    //ACR_InitializeGameConstants();

    // Initialize the spawn system.
    ACR_InitializeSpawns();

    // Initialize the time system.
    ACR_InitializeTime();
//    ACR_PrintDebugMessage("acr_mod_events_i: Starting date: " + GetDateAsString(), _ONLOAD_DEBUG, DEBUG_LEVEL_INFO);
//    ACR_PrintDebugMessage("acr_mod_events_i: Sarting time: " + GetTimeAsString(), _ONLOAD_DEBUG, DEBUG_LEVEL_INFO);
    ACR_PrintDebugMessage("acr_mod_events_i: Time compression ratio: " + FloatToString(ACR_GetGameToRealTimeRatio()), _ONLOAD_DEBUG, DEBUG_LEVEL_INFO);

    // Initialize one-time PC status setups
    ACR_PCOnModuleLoad();

    // Recreate player corpses
    ACR_RestoreCorpsesOnModuleLoad();

    // Set bioware/obsidian module switches as desired:
    SetModuleSwitch(MODULE_SWITCH_ENABLE_INVISIBLE_GLYPH_OF_WARDING, TRUE);
    SetModuleSwitch(MODULE_SWITCH_ENABLE_CROSSAREA_WALKWAYPOINTS, TRUE);
    //SetModuleSwitch(MODULE_SWITCH_ENABLE_UMD_SCROLLS, TRUE);
    SetModuleSwitch(MODULE_SWITCH_ENABLE_NPC_AOE_HURT_ALLIES, TRUE);
    SetModuleSwitch(MODULE_SWITCH_ENABLE_MULTI_HENCH_AOE_DAMAGE, TRUE);
    SetModuleSwitch(MODULE_SWITCH_AOE_HURT_NEUTRAL_NPCS, TRUE);
    SetModuleSwitch(MODULE_VAR_AI_STOP_EXPERTISE_ABUSE, TRUE);
    SetModuleSwitch(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS, TRUE);

	string sSID = IntToString(ACR_SERVER_ID);
	// grab the server name from the module properties so it will be updated.
	string sServerName = GetName(oModule);
    // check that the server information is in the database
    ACR_SQLQuery("SELECT * FROM servers WHERE ID=" + sSID);

    // create the record if it does not already exist
    if (ACR_SQLFetch() != SQL_SUCCESS)
    {
        ACR_SQLQuery("INSERT INTO servers (ID, Name, IPAddress) VALUES(" + sSID + ",'" + ACR_SQLEncodeSpecialChars(sServerName) + "','" + ACR_SERVER_IP + "')"); 
    }
	else
	{	
		// update server name and ip address if they've changed
		//if (ACR_SQLGetData(1) != sServerName || ACR_SQLGetData(2) != ACR_SERVER_IP)
		//{
		//	ACR_SQLQuery("UPDATE servers SET Name='" + ACR_SQLEncodeSpecialChars(sServerName) + "', IPAddress='" + ACR_SERVER_IP + "' WHERE ID=" + sSID);
		//}
		//  EDIT - only update server name for now
		//   this will preserve manual edits to IPAddress for testing.  Eventually replace with Hialmar's xp_vaultster external IP query.
	   if (ACR_SQLGetData(1) != sServerName) {
	   	ACR_SQLQuery("UPDATE servers SET Name='" + ACR_SQLEncodeSpecialChars(sServerName) + "' WHERE ID=" + sSID);
	   }
	}

    // clear all online statuses
	//  EDIT: Only where ServerID = the ID of the server that has just finished loading.
    ACR_SQLQuery("UPDATE characters SET IsOnline=0 WHERE ServerID=" + sSID);
	
	// Initialize chatlogging buffer
	ACR_InitializeChat();

    // This should be the last time in this function.
    ACR_PrintDebugMessage("acr_mod_events_i: ALFA server " + sServerId + " loaded.", _ONLOAD_DEBUG, DEBUG_LEVEL_INFO);

	
	
	
    // Custom code goes below this line.
	object oInitialize = CreateObject(OBJECT_TYPE_ITEM, "n2_it_spoon", GetStartingLocation());
	DestroyCampaignDatabase("_acr_test");
	ACR_SetPersistentObject(GetModule(), "1", oInitialize, "_acr_test");
	DelayCommand(4.0, DestroyObject(oInitialize));
	DelayCommand(4.1, WriteTimestampedLogEntry("There is no spoon."));
	
	ExecuteScript("nwnx_craft_init", GetModule());

}
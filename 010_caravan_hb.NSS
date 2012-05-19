
////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_area_onhbeat.nss
//      Version : 0.1
//         Date : 7/25/06
//       Author : Ronan
//
//  Local Variable Prefix =
//
//
//  Dependencies external of nwscript:
//
//  Description
//  This script calls the ACR's OnAreaHeartbeat code, and any custom code a
//  server may need. It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#include "010_caravan_i"


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

// The main event handler.
void main();

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main()
{
	object snd,wp,o;
	int ticks;
	
	ACR_AreaOnHeartbeat();

    // Custom code goes below this line.
	wp = GetLocalObject(OBJECT_SELF,"waypoint");
	
	if (wp == OBJECT_INVALID)
		init_caravan();

		
	o = GetNearestObjectByTag("010_cr_caravan",wp);
	
	
	ticks = GetLocalInt(OBJECT_SELF,"ticks");
	
	switch (GetLocalInt(OBJECT_SELF,"state")) {
		case CARAVAN_STATE_LOAD:
			if (ticks == 0) {
				caravan_message("All aboard!  Setting off in one minute to "+GetLocalString(OBJECT_SELF, "dest_name")+".",o);
			}
			else if (ticks > CARAVAN_LOADING_TICKS) {
				caravan_message("Hold on tight, we're heading out.",o);
				
				ticks = -1;
				SetLocalInt(OBJECT_SELF, "state", CARAVAN_STATE_TRAVEL);
				
				snd = GetNearestObjectByTag("wagon_sound", wp);
				SoundObjectPlay(snd);
				
				shake_players();
			}
			break;
		case CARAVAN_STATE_TRAVEL:
			if (ticks == CARAVAN_TRAVEL_TICKS/2) {
				caravan_message("We're about halfway to "+GetLocalString(OBJECT_SELF, "dest_name")+".",o);
			}
			else if (ticks > CARAVAN_TRAVEL_TICKS) {
				caravan_message("We're almost at "+GetLocalString(OBJECT_SELF, "dest_name")+".  Get your things ready.",o);
				ticks = -1;
				SetLocalInt(OBJECT_SELF,"state",CARAVAN_STATE_UNLOAD);
			}
			shake_players();
			break;
		case CARAVAN_STATE_UNLOAD:
			if (ticks == 0) {
				caravan_message("Please wait while we begin unloading.  You'll be let out soon.",o);
				
				snd = GetNearestObjectByTag("wagon_sound", wp);
				SoundObjectStop(snd);
			}
			else if (ticks > CARVAAN_UNLOADING_TICKS) {
				ticks = -1;
				SetLocalInt(OBJECT_SELF,"state", CARAVAN_STATE_EMPTY);
				caravan_message("Watch your step!",o);
			}
			break;
		default:
			let_out_players();

			return;
	}
	SetLocalInt(OBJECT_SELF,"ticks", ticks+1);

}

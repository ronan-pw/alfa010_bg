
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

#include "acr_area_i"


////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

const int CARAVAN_TRAVEL_TICKS = 50;
const int CARAVAN_LOADING_TICKS = 10;
const int CARVAAN_UNLOADING_TICKS = 5;

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

/* caravan states:

   0 - unoccupied
   1 - loading
   2 - travel
   3 - unloading
*/

void caravan_message(string str)
{
	SendChatMessage(OBJECT_SELF, OBJECT_SELF, CHAT_MODE_TALK, str);
}

void let_out_players()
{
	object o;
	location l = GetLocalLocation(OBJECT_SELF, "dest_loc");
	for (o = GetFirstObjectInArea(OBJECT_SELF); o != OBJECT_INVALID; o = GetNextObjectInArea())
		if (GetIsPC(o))
			AssignCommand(o, ActionJumpToLocation(l));
}

void main()
{
	location loc;
	object wp;
	int ticks;
	
    ACR_AreaOnHeartbeat();

    // Custom code goes below this line.
	
	wp = GetNearestObjectByTag("inside_caravan");
	
	loc = GetLocation(wp);
	
	ticks = GetLocalInt(OBJECT_SELF,"ticks");
	
	switch (GetLocalInt(OBJECT_SELF,"state")) {
		case 1:
			if (ticks == 0) {
				caravan_message("All aboard!  Setting off in one minute to "+GetLocalString(OBJECT_SELF, "dest_name")+".");
			}
			else if (ticks > CARAVAN_LOADING_TICKS) {
				caravan_message("Hold on tight, we're heading out.");
				ticks = -1;
				SetLocalInt(OBJECT_SELF,"state",2);
			}
			break;
		case 2:
			if (ticks == CARAVAN_LOADING_TICKS/2) {
				caravan_message("We're about halfway to "+GetLocalString(OBJECT_SELF, "dest_name")+".");
			}
			else if (ticks > CARAVAN_TRAVEL_TICKS) {
				caravan_message("We're almost at "+GetLocalString(OBJECT_SELF, "dest_name")+".  Get your things ready.");
				ticks = -1;
				SetLocalInt(OBJECT_SELF,"state",3);
			}
			ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), loc, 6.0);
			break;
		case 3:
			if (ticks == 0) {
				caravan_message("Please wait while we begin unloading.  You'll be let out soon.");
			}
			else if (ticks > CARAVAN_LOADING_TICKS) {
				ticks = -1;
				SetLocalInt(OBJECT_SELF,"state",0);
				caravan_message("Watch your step!");
			}
			break;
		default:
			let_out_players();
			return;
	}
	SetLocalInt(OBJECT_SELF,"ticks", ticks+1);

}
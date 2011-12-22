
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
const int CARAVAN_LOADING_TICKS = 9;
const int CARVAAN_UNLOADING_TICKS = 3;

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

void caravan_message(string str, object o)
{
	SendChatMessage(o, OBJECT_INVALID, CHAT_MODE_TALK, str);
}

void let_out_players()
{
	object o;
	location l = GetLocalLocation(OBJECT_SELF, "dest_loc");

	// spit out @ start if this is rebooted
	if (l == LOCATION_INVALID)
		l = GetStartingLocation();

	for (ObjectToInt(o = GetFirstObjectInArea(OBJECT_SELF)); o != OBJECT_INVALID; ObjectToInt(o = GetNextObjectInArea()))
		if (GetIsPC(o))
			AssignCommand(o, ActionJumpToLocation(l));
}

void shake_players()
{
	object o;
	for (ObjectToInt(o = GetFirstObjectInArea(OBJECT_SELF)); o != OBJECT_INVALID; ObjectToInt(o = GetNextObjectInArea()))
		if (GetIsPC(o)) {
			ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_STRIKE_HOLY), GetLocation(o));
			DelayCommand(3.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_STRIKE_HOLY), GetLocation(o)));
		}
}

object get_car_wp(string tag)
{
	object o;
	for (ObjectToInt(o = GetFirstObjectInArea(OBJECT_SELF)); o != OBJECT_INVALID; ObjectToInt(o = GetNextObjectInArea()))
		if ((GetObjectType(o) == OBJECT_TYPE_WAYPOINT) && (GetTag(o) == tag))
			return o;
			
	return OBJECT_INVALID;
}

void main()
{
	object snd,wp,o;
	int ticks;
	
	ACR_AreaOnHeartbeat();

    // Custom code goes below this line.
	wp = GetLocalObject(OBJECT_SELF,"waypoint");
	
	if (!GetIsObjectValid(wp)) {
		wp = get_car_wp("inside_caravan");
		SetLocalObject(OBJECT_SELF,"waypoint",wp);
		SetLocalInt(OBJECT_SELF,"state",0);
	}
		
	o = GetNearestObjectByTag("010_cr_caravan",wp);
	
	
	ticks = GetLocalInt(OBJECT_SELF,"ticks");
	
	switch (GetLocalInt(OBJECT_SELF,"state")) {
		case 1:
			if (ticks == 0) {
				caravan_message("All aboard!  Setting off in one minute to "+GetLocalString(OBJECT_SELF, "dest_name")+".",o);
			}
			else if (ticks > CARAVAN_LOADING_TICKS) {
				caravan_message("Hold on tight, we're heading out.",o);
				
				ticks = -1;
				SetLocalInt(OBJECT_SELF,"state",2);
				
				snd = GetNearestObjectByTag("wagon_sound",wp);
				SoundObjectPlay(snd);
				
				shake_players();
			}
			break;
		case 2:
			if (ticks == CARAVAN_TRAVEL_TICKS/2) {
				caravan_message("We're about halfway to "+GetLocalString(OBJECT_SELF, "dest_name")+".",o);
			}
			else if (ticks > CARAVAN_TRAVEL_TICKS) {
				caravan_message("We're almost at "+GetLocalString(OBJECT_SELF, "dest_name")+".  Get your things ready.",o);
				ticks = -1;
				SetLocalInt(OBJECT_SELF,"state",3);
			}
			shake_players();
			break;
		case 3:
			if (ticks == 0) {
				caravan_message("Please wait while we begin unloading.  You'll be let out soon.",o);
				
				snd = GetNearestObjectByTag("wagon_sound",wp);
				SoundObjectStop(snd);
			}
			else if (ticks > CARVAAN_UNLOADING_TICKS) {
				ticks = -1;
				SetLocalInt(OBJECT_SELF,"state",0);
				caravan_message("Watch your step!",o);
			}
			break;
		default:
			let_out_players();
			return;
	}
	SetLocalInt(OBJECT_SELF,"ticks", ticks+1);

}

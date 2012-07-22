
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
void send_elfsong_msg(string str, object o);

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void send_elfsong_msg(string str, object o)
{
	SendChatMessage(o, OBJECT_INVALID, CHAT_MODE_TALK, str);
}

void main() {
	object o;

	ACR_AreaOnHeartbeat();


	if (GetIsNight() && (GetLocalInt(OBJECT_SELF, "singing") == 0) && !Random(10)) {

		o = GetObjectByTag("010_cr_elfsong_voice");

		SetLocalInt(OBJECT_SELF, "singing", 1);

		if (Random(2)) {
			DelayCommand(1.0f, send_elfsong_msg("<i>An eerie ethereal melody slowly springs to life, its substance coming forth from the very the inn itself; a ghostly elven voice sings an elegaic lament that tears at one's heart at which the entire tavern quiets suddenly to listen keenly.",o));
		}
		else {
			DelayCommand(1.0f, send_elfsong_msg("<i>A haunting elegy reverberates through the halls of the tavern, seeming to spring forth from the very floorboards themselves; all the tavern's patrons quiet themselves in apparent respect to the voice -- the normally rowdy place silences so that the eerie voice is clearly audible to all.",o));
		}

		if (Random(2)) {
			DelayCommand(45.0f, send_elfsong_msg("<i>One of the patrons yells towards the barkeep -- he is summarily shushed by the rest of the patrons and quiets to listen to the singing.",o));
		}
		else {
			DelayCommand(45.0f, send_elfsong_msg("<i>The elegaic melody continues softly, the patrons of the tavern keeping their rapt attention on the song.",o));
		}

		DelayCommand(120.0f, send_elfsong_msg("<i>The haunting song slowly comes to a close, the nearby patrons still silent either in admiration or discomfort.",o));


		MusicBackgroundChangeNight(OBJECT_SELF, 472); 
		MusicBackgroundPlay(OBJECT_SELF); 

		DelayCommand(130.0f, MusicBackgroundChangeNight(OBJECT_SELF, 0)); 
		DelayCommand(130.0f, MusicBackgroundStop(OBJECT_SELF)); 
		DelayCommand(600.0f, SetLocalInt(OBJECT_SELF, "singing", 0)); 
	}
}

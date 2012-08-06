
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

void main()
{
	object o;
	string str;

	ACR_AreaOnHeartbeat();


	if (GetIsNight() && (GetLocalInt(OBJECT_SELF, "singing") == 0) && !Random(15)) {

		o = GetObjectByTag("010_cr_elfsong_voice");

		SetLocalInt(OBJECT_SELF, "singing", 1);

		switch (Random(3)) {
			case 0:
				str = "<i>An eerie ethereal melody slowly springs to life, its substance coming forth from the very the inn itself; a ghostly elven voice sings an elegaic lament that tears at one's heart at which the entire tavern quiets suddenly to listen keenly.";
				break;
			case 1:
				str = "<i>A haunting elegy reverberates through the halls of the tavern, seeming to spring forth from the very floorboards themselves; all the tavern's patrons quiet themselves in apparent respect to the voice -- the normally rowdy place silences so that the eerie voice is clearly audible to all.";
				break;
			case 2:
				str = "<i>A gentle melody crescendos up from from the din of the surrounding tavern, hushing the patrons to silence as the distant elven voice begins to sing an otherworldly mournful tune.";
				break;
		}

		DelayCommand(0.0f, send_elfsong_msg(str, o));

		switch (Random(3)) {
			case 0:
				str = "<i>One of the patrons yells towards the barkeep -- he is summarily shushed by the rest of the patrons and quiets to listen to the singing.";
				break;
			case 1:
				str = "<i>The elegaic melody continues softly, the patrons of the tavern keeping their rapt attention on the song.";
				break;
			case 2:
				str = "<i>The singing continues to waft through the air, moist eyes visible on even the most burly of patrons.";
				break;
		}

		DelayCommand(40.0f, send_elfsong_msg(str, o));

		switch (Random(3)) {
			case 0:
				str = "<i>The haunting song slowly comes to a close, the nearby patrons still silent either in admiration or discomfort.";
				break;
			case 1:
				str = "<i>Once the melody comes to a close only an uncomfortable silence remains within the tavern.";
				break;
			case 2:
				str = "<i>As the elegaic voice recedes into nothingness once more a soft din errupts in the tavern, a good many voices commenting on the remarkable singing.";
				break;
		}

		DelayCommand(120.0f, send_elfsong_msg(str, o));


		DelayCommand(2.0f, MusicBackgroundChangeNight(OBJECT_SELF, 472)); 
		DelayCommand(2.0f, MusicBackgroundChangeDay(OBJECT_SELF, 472)); 
		DelayCommand(2.0f, MusicBackgroundPlay(OBJECT_SELF));

		DelayCommand(130.0f, MusicBackgroundChangeNight(OBJECT_SELF, 0)); 
		DelayCommand(130.0f, MusicBackgroundChangeDay(OBJECT_SELF, 0)); 
		DelayCommand(130.0f, MusicBackgroundStop(OBJECT_SELF)); 
		DelayCommand(600.0f, SetLocalInt(OBJECT_SELF, "singing", 0)); 
	}
}

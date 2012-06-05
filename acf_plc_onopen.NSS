////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_plc_onopen.nss
//    $Revision:: 183        $ current version of the file
//        $Date:: 2006-12-21#$ date the file was created or modified
//       Author : Ronan
//
//  Local Variable Prefix =
//
//  Dependencies external of nwscript:
//
//  Description
//  This script calls the ACR's OnOpen code for placeables, and any
//  custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#include "acr_placeable_i"

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

void main() {
	object o;
	string sResref;

	ACR_PlaceableOnOpen();

	if (!GetLocalInt(OBJECT_SELF, "ACR_JUNK_SPAWN"))
		return;


	switch (Random(26)) {
	case 0:
		sResref = "010_it_junk_armour_pad"; 
		break;
	case 1:
		sResref = "010_it_junk_codpiece";  
		break;
	case 2:
		sResref = "010_it_junk_pot";
		break;
	case 3:
		sResref = "010_it_junk_barstool";   
		break;
	case 4:
		sResref = "010_it_junk_drawing";   
		break;
	case 5:
		sResref = "010_it_junk_rags";
		break;
	case 6:
		sResref = "010_it_junk_board";      
		break;
	case 7:
		sResref = "010_it_junk_fish";      
		break;
	case 8:
		sResref = "010_it_junk_scroll";
		break;
	case 9:
		sResref = "010_it_junk_bone";       
		break;
	case 10:
		sResref = "010_it_junk_glass";     
		break;
	case 11:
		sResref = "010_it_junk_spoke";
		break;
	case 12:
		sResref = "010_it_junk_book";       
		break;
	case 13:
		sResref = "010_it_junk_gloves";    
		break;
	case 14:
		sResref = "010_it_junk_spring";
		break;
	case 15:
		sResref = "010_it_junk_boots";      
		break;
	case 16:
		sResref = "010_it_junk_handle";    
		break;
	case 17:
		sResref = "010_it_junk_tankard";
		break;
	case 18:
		sResref = "010_it_junk_bottle";     
		break;
	case 19:
		sResref = "010_it_junk_horseshoe"; 
		break;
	case 20:
		sResref = "010_it_junk_trash";
		break;
	case 21:
		sResref = "010_it_junk_charcoal";   
		break;
	case 22:
		sResref = "010_it_junk_meat";
		break;
	case 23:
		sResref = "010_it_junk_clothes";    
		break;
	case 24:
		sResref = "010_it_junk_misc";
		break;
	case 25:
		sResref = "010_it_junk_pottery";
		break;
	}

	o = CreateObject(OBJECT_TYPE_ITEM, sResref, GetLocation(OBJECT_SELF));

	// 50% appear
	if (Random(2))
		CopyObject(o, GetLocation(OBJECT_SELF), OBJECT_SELF);

	DestroyObject(o);

	DeleteLocalInt(OBJECT_SELF, "ACR_JUNK_SPAWN");
}

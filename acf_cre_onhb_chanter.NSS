////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_cre_onspawnin
//    $Revision:: 280        $ current version of the file
//        $Date:: 2007-03-20#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnSpawnIn event handler for creatures
//  and any custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_creature_i"

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

void main()
{
	string str;
	int i,j;
	
    ACR_CreatureOnHeartBeat();

	i = GetLocalInt(OBJECT_SELF,"i");
	j = GetLocalInt(OBJECT_SELF,"j");
	
	i++;
	
	SetLocalInt(OBJECT_SELF,"i",i);
	if (i < 5)
		return;
	
	i = 0;
	
	switch (j) {
		case 0:
			str = "In the year of the Starving, a great pestilence will sweep across the land to cause great suffering and loss.";
			break;
		case 1:
			str = "When shadows descend upon the lands, our divine lords will walk alongside us as equals.";
			break;
		case 2:
			str = "The Wyrm shall wander the earth and such a pestilence will follow in his wake that all who know of his passing shall be struck down by the plague.";
			break;
		case 3:
			str = "When conflict sweeps across the Dales the great lizards of the north shall descend with fire and fury.";
			break;
		case 4:
			str = "A silent sound shall tremble earth and sky, and the heavens a new throne shall make.";
			break;
		case 5:
			str = "When the silent thunder rolls and the ebony maiden's grace be given, the path to the throne shall be lain.";
			break;
		case 6:
			str = "Twelve days before Greengrass, his last rally mounts Azzer-ash shall leave his men but for one.  To him, he will name barons and viscounts.  And there disclose his dream to the iron son.";
			break;
		case 7:
			str = "His vision entails his own demise.  Unheralded beneath the north sea wave.  He will ask his memory be kept alive.  His name invoked in war and peace to save.";
			break;
		case 8:
			str = "Two days hence, the dragons shall roar its last.  The proud king's body shall never be found.  His solidiers will keep his memory fast, his kingdom shall become his sacred ground.";
			break;
		case 9:
			str = "The eternal king nigh thirteen score year, inclement tyrant and holy savior.";
			break;
		case 10:
			str = "White birds shall vanish from the North, and great evil shall die and be reborn.";
			break;
		case 11:
			str = "When Nightal is almost at a close there from the gate wall shall descend, a serpent to blow the Horn of Doom at the graveyard Kingdom of Man.";
			break;
		case 12:
			str = "As the Star of Storms reaches its brightest, when the dulcet ballad is played soundest ground shall be torn asunder, the tapestry forever frayed.";
			break;
		case 13:
			str = "When the Raging King has failed to keep his five retainers true, come 'morrow, the blessed sun will rise and no chaos shall ill ensue.";
			break;
		case 14:
			str = "When fire dances betwixt the eternal spires to the land of the dragon shall come a chosen champion of the Bearer to herald the death of fear.";
			break;
		case 15:
			str = "Both a fey and pious knight.  But in the feud of blood and soul, the strongest will must be torn asunder a raging darkness devours the whole.";
			break;
		case 16:
			str = "Healing wounds shall bleed once more, rallied foes shall stalk the land, till the worm and dragon's final war turns the fields of stone to sand.";
			break;
		default:
			str = "Sleepless death dreams in darkened places, tyranny returns the rule of Law.";
			j = -1;
	}
	
	j++;
	
	SetLocalInt(OBJECT_SELF,"j",j);
	
	str += "  So sayeth the ";
	str += ((i%2) ? "wise" : "great");
	str += " Alaundo.";

	ActionSpeakString(str);
}
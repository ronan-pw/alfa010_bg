////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ALFA Configuration File
//     Filename : acf_mod_onchat.nss
//    $Revision:: 0        $ current version of the file
//        $Date:: 2009-08-08#$ date the file was created or modified
//       Author : AcadiusLost
//
//  Local Variable Prefix = None
//
//  Description
//  This script calls the module's OnChat event, and any custom code added
//  by this server. It is usually used to set up server-specific options.
//  This file should NOT be overwriten in ACR updates so as to preserve any of
//  the server's customized code they may have added.
//
//  Revision History
//  2009/08/08  AcadiusLost  Inception
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#include "acr_mod_events_i"

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

int TEMP_ModuleOnChat(object oSpeaker, object oTarget, int nMode, string sText);

int StartingConditional(object oSpeaker, object oTarget, int nMode, string sText) {

    //SendMessageToPC(oSpeaker, "You said: "+sText+", heard by "+GetName(oTarget));
	//SendMessageToPC(oTarget, "You heard "+GetName(oSpeaker)+" say: "+sText);
	
	// ACR hook for OnChat event. Run this first in case the text needs to be suppressed.
	if (ACR_ModuleOnChat(oSpeaker, oTarget, nMode, sText) != TRUE) {
		return FALSE;
	}
	
    // Custom code goes below this line. Module scripts can supress chat text by returning false here.
	return TRUE;
}

int TEMP_ModuleOnChat(object oSpeaker, object oTarget, int nMode, string sText)
{
	//iterate the RPXP function to indicate an active PC
	SetLocalInt(oSpeaker, _RPXP_ACTIVITY, TRUE);
	
	if(nMode == CHAT_MODE_SERVER)
		return TRUE;
	if(nMode == CHAT_MODE_SHOUT)
		return TRUE;
	if(nMode == CHAT_MODE_SILENT_SHOUT)
		return TRUE;
	if(nMode == CHAT_MODE_TELL)
		return TRUE;

	// for now, this is all we'll place here.
	string sLangPick = GetLocalString(oSpeaker, "DefaultLanguage");
	if(GetStringLeft(sText, 1) == "@")
	{ // the player is attempting to specify a different language.
		string sNewPick = GetStringLowerCase(GetStringLeft(sText, 4));
		sText = GetStringRight(sText, GetStringLength(sText)-4);
		if(sNewPick == "@com")
		{
			sLangPick = "common";
		}
		else if(sNewPick == "@anm")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_ANIMAL) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_ANIMAL;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Animal.");
				return FALSE;
			}
		}
		else if(sNewPick == "@ass")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_ASSASSIN) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_ASSASSIN;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Assassin.");
				return FALSE;
			}
		}
		else if(sNewPick == "@aby")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_ASSASSIN) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_ASSASSIN;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Abyssal.");
				return FALSE;
			}
		}
		else if(sNewPick == "@alz")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_ALZHEDO) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_ALZHEDO;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Alzhedo.");
				return FALSE;
			}
		}
		else if(sNewPick == "@aqu")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_AQUAN) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_AQUAN;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Aquan.");
				return FALSE;
			}
		}
		else if(sNewPick == "@aur")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_AURAN) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_AURAN;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Auran.");
				return FALSE;
			}
		}
		else if(sNewPick == "@alg")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_ALGARONDAN) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_ALGARONDAN;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Algarondan.");
				return FALSE;
			}
		}
		else if(sNewPick == "@can")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_CANT) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_CANT;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Thieves' Cant.");
				return FALSE;
			}
		}
		else if(sNewPick == "@cel")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_CELESTIAL) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_CELESTIAL;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Celestial.");
				return FALSE;
			}
		}
		else if(sNewPick == "@che")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_CHESSENTAN) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_CHESSENTAN;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Chessentan.");
				return FALSE;
			}
		}
		else if(sNewPick == "@cho")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_CHONDATHAN) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_CHONDATHAN;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Chondathan.");
				return FALSE;
			}
		}
		else if(sNewPick == "@chu")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_CHULTAN) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_CHULTAN;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Chultan.");
				return FALSE;
			}
		}
		else if(sNewPick == "@dwa")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_DWARF) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_DWARF;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Dwarven.");
				return FALSE;
			}
		}
		else if(sNewPick == "@dro")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_DROW) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_DROW;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Drow.");
				return FALSE;
			}
		}
		else if(sNewPick == "@drs")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_DROWSIGN) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_DROWSIGN;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Drow Sign.");
				return FALSE;
			}
		}
		else if(sNewPick == "@dru")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_DRUIDIC) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_DRUIDIC;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Druidic.");
				return FALSE;
			}
		}
		else if(sNewPick == "@dra")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_DRACONIC) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_DRACONIC;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Draconic.");
				return FALSE;
			}
		}
		else if(sNewPick == "@dam")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_DAMARAN) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_DAMARAN;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Damaran.");
				return FALSE;
			}
		}
		else if(sNewPick == "@dmb")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_DAMBRATHAN) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_DAMBRATHAN;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Dambrathan.");
				return FALSE;
			}
		}
		else if(sNewPick == "@dur")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_DURPARI) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_DURPARI;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Durpari.");
				return FALSE;
			}
		}
		else if(sNewPick == "@elf")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_ELVEN) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_ELVEN;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Elven.");
				return FALSE;
			}
		}
		else if(sNewPick == "@gno")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_GNOME) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_GNOME;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Gnomish.");
				return FALSE;
			}
		}
		else if(sNewPick == "@gob")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_GOBLIN) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_GOBLIN;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Goblin.");
				return FALSE;
			}
		}
		else if(sNewPick == "@gia")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_GIANT) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_GIANT;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Giant.");
				return FALSE;
			}
		}
		else if(sNewPick == "@gnl")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_GNOLL) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_GNOLL;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Gnoll.");
				return FALSE;
			}
		}
		else if(sNewPick == "@hlf")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_HALFLING) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_HALFLING;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Halfling.");
				return FALSE;
			}
		}
		else if(sNewPick == "@ign")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_IGNAN) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_IGNAN;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Ignan.");
				return FALSE;
			}
		}
		else if(sNewPick == "@hdr")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_HALARDRIM) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_HALARDRIM;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Halardrim.");
				return FALSE;
			}
		}
		else if(sNewPick == "@hlr")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_HALRUAAN) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_HALRUAAN;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Halruaan.");
				return FALSE;
			}
		}
		else if(sNewPick == "@ill")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_ILLUSKAN) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_ILLUSKAN;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Illuskan.");
				return FALSE;
			}
		}
		else if(sNewPick == "@ims")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_IMASKAR) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_IMASKAR;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Imaskar.");
				return FALSE;
			}
		}
		else if(sNewPick == "@inf")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_INFERNAL) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_INFERNAL;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Infernal.");
				return FALSE;
			}
		}
		else if(sNewPick == "@l37")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_LEETSPEAK) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_LEETSPEAK;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Leet.");
				return FALSE;
			}
		}
		else if(sNewPick == "@lan")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_LANTANESE) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_LANTANESE;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Lantanese.");
				return FALSE;
			}
		}
		else if(sNewPick == "@lor")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_LOROSS) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_LOROSS;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Loross.");
				return FALSE;
			}
		}
		else if(sNewPick == "@mid")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_MIDANI) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_MIDANI;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Midani.");
				return FALSE;
			}
		}
		else if(sNewPick == "@mul")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_MULHORANDI) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_MULHORANDI;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Mulhorandi.");
				return FALSE;
			}
		}
		else if(sNewPick == "@nth")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_NETHERESE) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_NETHERESE;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Netherese.");
				return FALSE;
			}
		}
		else if(sNewPick == "@rsh")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_RASHEMI) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_RASHEMI;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Rashemi.");
				return FALSE;
			}
		}
		else if(sNewPick == "@ser")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_SERUSAN) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_SERUSAN;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Serusan.");
				return FALSE;
			}
		}
		else if(sNewPick == "@sha")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_SHAARAN) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_SHAARAN;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Sharran.");
				return FALSE;
			}
		}
		else if(sNewPick == "@sho")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_SHOU) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_SHOU;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Shou.");
				return FALSE;
			}
		}
		else if(sNewPick == "@syl")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_SYLVAN) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_SYLVAN;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Sylvan.");
				return FALSE;
			}
		}
		else if(sNewPick == "@ter")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_TERRAN) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_TERRAN;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Terran.");
				return FALSE;
			}
		}
		else if(sNewPick == "@tre")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_TREANT) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_TREANT;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Treant.");
				return FALSE;
			}
		}
		else if(sNewPick == "@tsh")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_TASHALAN) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_TASHALAN;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Tashalan.");
				return FALSE;
			}
		}
		else if(sNewPick == "@tui")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_TUIGAN) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_TUIGAN;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Tuigan.");
				return FALSE;
			}
		}
		else if(sNewPick == "@tur")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_TURMIC) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_TURMIC;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Turmic.");
				return FALSE;
			}
		}
		else if(sNewPick == "@orc")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_ORC) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_ORC;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Orc.");
				return FALSE;
			}
		}
		else if(sNewPick == "@nex")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_NEXALAN) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_NEXALAN;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Nexalan.");
				return FALSE;
			}
		}
		else if(sNewPick == "@yti")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_YUANTI) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_YUANTI;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Yuan-Ti.");
				return FALSE;
			}
		}
		else if(sNewPick == "@und")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_UNDERCOMMON) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_UNDERCOMMON;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Undercommon.");
				return FALSE;
			}
		}
		if(sNewPick == "@ulu")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_ULUIK) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_ULUIK;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Uluik.");
				return FALSE;
			}
		}
		else if(sNewPick == "@unt")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_UNTHERIC) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_UNTHERIC;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Untheric.");
				return FALSE;
			}
		}
		else if(sNewPick == "@vas")
		{
			if(_IsLanguageKnown(oSpeaker, LNG_VAASAN) || GetIsDM(oSpeaker) || GetIsDMPossessed(oSpeaker))
				sLangPick = LNG_VAASAN;
			else
			{
				SendMessageToPC(oSpeaker, "You don't know how to speak Vaasan.");
				return FALSE;
			}
		}
	}
	
	if(sLangPick == "common" || sLangPick == "")
	{
		if(GetStringLeft(sText, 4) == "@com")
			sText = GetStringRight(sText, GetStringLength(sText)-4);
		return TRUE;
	}
	
	object oTool = _GetDMFITool(oSpeaker);
	string sNewString = DMFI_ProcessLanguage(sText, sLangPick, oTool);
	
	if(nMode == CHAT_MODE_PARTY)
	{
		string sMessage = "<color=#D7C5B9>"+GetName(oSpeaker)+" : </color><color=#FFFFFF>["+_CapitalizeWord(sLangPick)+", Party] "+sText;
		object oListener = GetFirstPC();
		while(GetIsObjectValid(oListener))
		{

			if(GetFactionEqual(oSpeaker, oListener) || GetIsDM(oListener) || GetIsDMPossessed(oListener) || oListener == oSpeaker)
			{
				if(_IsLanguageKnown(oListener, sLangPick) || GetIsDM(oListener) || GetIsDMPossessed(oListener))
					SendMessageToPC(oListener, sMessage);
			}
			oListener = GetNextPC();
		}	
		SendChatMessage(oSpeaker, oSpeaker, nMode, sNewString);
		return FALSE;
	}
	if(nMode == CHAT_MODE_TALK)
	{
		string sMessage = "<color=#D7C5B9>"+GetName(oSpeaker)+" : </color><color=#FFFFFF>["+_CapitalizeWord(sLangPick)+"] "+sText;
		location lSelf = GetLocation(oSpeaker);
		object oListener = GetFirstObjectInShape(SHAPE_SPHERE, 20.0f, lSelf);
		while(GetIsObjectValid(oListener))
		{
			if(_IsLanguageKnown(oListener, sLangPick))
					SendMessageToPC(oListener, sMessage);
			oListener = GetNextObjectInShape(SHAPE_SPHERE, 20.0f, lSelf);
		}
		oListener = GetFirstPC();
		while(GetIsObjectValid(oListener))
		{

			if((GetIsDM(oListener) || GetIsDMPossessed(oListener)) && GetArea(oSpeaker) == GetArea(oListener) && GetDistanceBetween(oSpeaker, oListener) <= 20.0f)
				SendMessageToPC(oListener, sMessage);
			oListener = GetNextPC();
		}
		SendChatMessage(oSpeaker, oSpeaker, nMode, sNewString);
		return FALSE;
	}
	if(nMode == CHAT_MODE_WHISPER)
	{
		string sMessage = "<color=#D7C5B9>"+GetName(oSpeaker)+" : </color><color=#808080>["+_CapitalizeWord(sLangPick)+", Whisper] "+sText;
		location lSelf = GetLocation(oSpeaker);
		object oListener = GetFirstObjectInShape(SHAPE_SPHERE, 3.0f, lSelf);
		while(GetIsObjectValid(oListener))
		{
			if(_IsLanguageKnown(oListener, sLangPick))
					SendMessageToPC(oListener, sMessage);
			oListener = GetNextObjectInShape(SHAPE_SPHERE, 3.0f, lSelf);
		}
		SendChatMessage(oSpeaker, oSpeaker, nMode, sNewString);
		oListener = GetFirstPC();
		while(GetIsObjectValid(oListener))
		{

			if((GetIsDM(oListener) || GetIsDMPossessed(oListener)) && GetArea(oSpeaker) == GetArea(oListener) && GetDistanceBetween(oSpeaker, oListener) <= 3.0f)
				SendMessageToPC(oListener, sMessage);
			oListener = GetNextPC();
		}
		return FALSE;
	}

	return TRUE;
}
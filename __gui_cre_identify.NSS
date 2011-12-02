////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR GUI Script
//     Filename : gui_cre_identify
//    $Revision::            $ current version of the file
//        $Date::            $ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix: ACR_GUI
//  Dependencies: ALFA Creature Blueprints
//
//  Description
//  This script is called from the "Identify" option on the context menu.
//
//  Revision History
//  2007-02-18  Cipher  Inception
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
	// this script is free for all - no security measures required for execution
	
	object oPC = OBJECT_SELF;
	object oTarget = GetPlayerCurrentTarget(oPC);

	//WriteTimestampedLogEntry("gui_cre_identify.nss called by "+GetName(oPC)+" on creature "+GetResRef(oTarget)+", called: "+GetName(oTarget)+".");
	// only process creature inquiries
	if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
	{
		// implementation was rolled into acr_creature_i for hak implementation
		ACR_CreatureIdentify(oPC, oTarget);
		/*
		//  This part is no longer necessary, does not account for Knowledge skills
		//
		// do a knowledge check - exit on failure
		if (d20() + GetSkillRank(SKILL_LORE, oPC) < 10 + FloatToInt(GetChallengeRating(oTarget)))
		{
			// alert the player - should we also save the attempt (db) to prevent retries?
			SendMessageToPC(oPC, "You do not recognize this creature."); return;
		}

		// init variables - prepare to clean name
		string sName = GetName(oTarget); 		
		string sFirstChar = GetSubString(sName, 1, 1);
		int nEnd = GetStringLength(sName), i, p;

		// filter out the extras in the name of the creature
		if ((p = FindSubString(sName, ", CR ")) != -1)
		{
			nEnd = p - 1;
		}
		else if ((p = FindSubString(sName, " CR ")) != -1)
		{
			nEnd = p - 1;
		}
		else
		{
			// check alternate formatting
			for (i=0; i<9; i++)
			{
				// get the position of the Challenge Rating (marks the end of the name)
				if ((p = FindSubString(sName, " CR" + IntToString(i))) != -1) { nEnd = p + 1; break; }
			}
		}
		
		// compose the name to report to the player
		sName = ((sFirstChar == "A") || (sFirstChar == "E") || (sFirstChar == "I") ||
				 (sFirstChar == "O") || (sFirstChar == "U"))
				? "an " + GetSubString(sName, 1, nEnd) : "a " + GetSubString(sName, 1, nEnd);
		
		
		// report the filtered creature name
		SendMessageToPC(oPC, "You recognize the creature - <color=Magenta><i>" + sName + "!</i></color>");
		*/
	}
}
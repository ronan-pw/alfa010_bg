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

#include "acr_skills_i"

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


void ACR_CreatureIdentify(object oPC, object oTarget)
{
	// first, determine which Knowledge skill applies.
	int i,p,end,start,nKnowSkill = GetKnowlegeSkillOfRace(GetRacialType(oTarget));
	string sName,sOld,sTmp;


	if (nKnowSkill == -1) {
		WriteTimestampedLogEntry("Unaccounted RacialType Error identifying "+GetName(oTarget)+" with ResRef: "+GetResRef(oTarget)+" by PC: "+GetName(oPC)+" in area: "+GetName(GetArea(oTarget))); 
		nKnowSkill = SKILL_LORE;
	}
	// do a knowledge check - exit on failure
	if (!ACR_SkillCheck(nKnowSkill, oPC, 10 + FloatToInt(GetChallengeRating(oTarget)), TRUE)) {
		// alert the player - should we also save the attempt (db) to prevent retries?
		SendMessageToPC(oPC, "You fail to notice anything remarkable about this creature.");
		return;
	}

	sName = GetName(oTarget);
	sOld = sName;
	end = GetStringLength(sName);

	// Handle hidden text
	if ((p = FindSubString(sName, "{")) != -1) {
		start = p+1;

		if ((p = FindSubString(sName, "}")) != -1)
			end = p-1;

		sTmp = GetStringUpperCase(GetSubString(sName, start, end-start));

		// Clean name-candidate
		sName = GetSubString(sName, start, end-start);

		// Proper cr declaration
		if (TestStringAgainstPattern("**CR(*w|*n)**",sTmp)) {
		
			// imprecise, best 'guess' for cr formats
			if      ((p = FindSubString(sTmp, ", CR")) != -1) {}
			else if ((p = FindSubString(sTmp, "- CR")) != -1) {}
			else if ((p = FindSubString(sTmp, ": CR")) != -1) {}
			else if  ((p = FindSubString(sTmp, ":CR")) != -1) {}
			else if  ((p = FindSubString(sTmp, "-CR")) != -1) {}
			else if  ((p = FindSubString(sTmp, ",CR")) != -1) {}
			else if  ((p = FindSubString(sTmp, " CR")) != -1) {}
			// Panic, this is ONLY a cr no name
			else {
				sName = sOld;
				p = GetStringLength(sName);
			}
			end = p;
		}
		
		// compose the name to report to the player
		sName = GetSubString(sName, 0, end);   
		SetFirstName(oTarget, sName);
		SetLastName(oTarget, "");
	}

	// report the filtered creature name
	SendMessageToPC(oPC, "You recognize it as "+GetArticle(sName)+" <color=Magenta><i>"+sName+"</i></color>!");
}

void main()
{
	object oPC = OBJECT_SELF;
	object oTarget = GetPlayerCurrentTarget(oPC);

	// only process creature inquiries
	if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
	{
		// implementation was rolled into acr_creature_i for hak implementation
		ACR_CreatureIdentify(oPC, oTarget);
	}
}


////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ALFA Core Rules
//	 Filename : acr_creature_i
//	$Revision:: 533		$ current version of the file
//		$Date:: 2009-12-25#$ date the file was created or modified
//	   Author : Cipher & AcadiusLost
//
//	Var Prefix: ACR_CRE
//  Dependencies: None
//
//  Description
//  This script handles events executed on all creatures, either PCs or NPCs.
//
//  http://www.alandfaraway.org/docs/Technical/ACR2Creatures
//
//  Revision History
//  2006/11/01  Cipher  Added calls to VFX functions
//  2007/01/24  Cipher  Added link to ALFA Wiki placeables article
//  2007/03/20  Cipher  Added new includes and corrected filename
//  2007/03/20  Cipher  Added ACR_ReportSpawnDeath() call and corrected function names
//  2007/04/28  AcadiusLost Added calls to normal AI functions
//  2007/07/01  AcadiusLost included acr_xp_i, altered ACR_creatureondeath for rewards
//  2007/07/15  AcadiusLost scavenged useful code from default spawn and death scripts,
//				  also removed default treasure drops
//  2007/08/17  AcadiusLost added OnSpawn gold for random loot drops.
//  2007/08/20  Cipher  Added auto creature identification, cleaned up code
//  2007/09/02  Cipher  Added quest system bounty hook
//  2007/09/16  AcadiusLost amended events include
//  2007/09/21  Cipher  Modified quest function name
//  2007/04/17  AcadiusLost - commented out VFX calls and PC heartbeat/perception test
//  2008/04/04  Cipher  Added loot drop code hooks OnDeath
//  2009/12/25  AcadiusLost - added NoAI workaround hooks, linked identification to knowledge skills
//  2010/06/03  Sandermann - added advanced AI hook and re-introduced search and stealth functionality
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "x0_i0_anims"

#include "acr_events_i"
#include "acr_xp_i"
#include "acr_nonlethal_i"
#include "acr_spawn_i"
#include "acr_vfx_i"
#include "acr_wealth_i"
#include "acr_quest_i"

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

const string _CRE_NO_AI = "ACR_CRE_NO_AI";

////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Variables ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// The ACR's Creature event handler.
void ACR_CreatureOnSpawnIn();

// The ACR's Creature event handler.
void ACR_CreatureOnSpellCastAt();

// The ACR's Creature event handler.
void ACR_CreatureOnPhysicallyAttacked();

// The ACR's Creature event handler.
void ACR_CreatureOnDamaged();

// The ACR's Creature event handler.
void ACR_CreatureOnDeath();

// The ACR's Creature event handler.
void ACR_CreatureOnBlocked();

// The ACR's Creature event handler.
void ACR_CreatureOnEndCombatRound();

// The ACR's Creature event handler.
void ACR_CreatureOnConversation();

// The ACR's Creature event handler.
void ACR_CreatureOnInventoryDisturbed();

// The ACR's Creature event handler.
void ACR_CreatureOnHeartBeat();

// The ACR's Creature event handler.
void ACR_CreatureOnRested();

// The ACR's Creature event handler.
void ACR_CreatureOnPerception();

// The ACR's Creature event handler.
void ACR_CreatureOnUserDefined();

//! This function performs a creature identification check by oPC on oTarget
void ACR_CreatureIdentify(object oPC, object oTarget);


//-Sandermann 03/06/10
//This determines if the creature should use smart AI or not. Smart AI will include an intelligent 
//selection of spell and ability use, tactics and targetting. Note you must still set variables defined
//in x2_inc_switches.nss to use specail tactics. Setting X2_L_BEH_MAGIC to more than one turns this on
//default as without smart AI the creature will never cast a spell. This behaviour is default for any creature
//with an intelligence score over 10.
//to set smart AI behaviour manually set the variable ALFA_SMART_AI on the creature
int GetIsSmart(object oCreature=OBJECT_SELF);


////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

int GetIsSmart(object oCreature=OBJECT_SELF)
{
	return (GetAbilityScore(oCreature,ABILITY_INTELLIGENCE) > 5);
}

void ACR_CreatureOnSpawnIn()
{
	//SendMessageToAllDMs(GetFirstName(OBJECT_SELF)+" called ACR_CreatureOnSpawnIn()");
	// apply any effects on the creature
	ACR_VFXOnSpawn(OBJECT_SELF);
	
	// Scavenged code from nw_c2_default9.nss 
	// ---------- Begin scavenged code --------------------

	// Enable stealth mode by setting a variable on the creature
	// Great for ambushes
	if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_STEALTH) == TRUE)
	{
		SetSpawnInCondition(NW_FLAG_STEALTH);
	}
	
	// Make creature enter search mode after spawning by setting a variable
	// Great for guards, etc
	if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_SEARCH) == TRUE)
	{
		SetSpawnInCondition(NW_FLAG_SEARCH);
	}
	
	// Enable immobile ambient animations by setting a variable
	if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_AMBIENT_IMMOBILE) == TRUE)
	{
		SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);
	}
	// Enable mobile ambient animations by setting a variable
	if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_AMBIENT) == TRUE)
	{
		SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS);
	}
	// ***** DEFAULT GENERIC BEHAVIOR ***** //
	// * Goes through and sets up which shouts the NPC will listen to.
	SetListeningPatterns();

	// * Walk among a set of waypoints if they exist.
	// * 1. Find waypoints with the tag "WP_" + NPC TAG + "_##" and walk
	// *	among them in order.
	// * 2. If the tag of the Way Point is "POST_" + NPC TAG, stay there
	// *	and return to it after combat.
	//
	// * If "NW_FLAG_DAY_NIGHT_POSTING" is set, you can also
	// * create waypoints with the tags "WN_" + NPC Tag + "_##"
	// * and those will be walked at night. (The standard waypoints
	// * will be walked during the day.)
	// * The night "posting" waypoint tag is simply "NIGHT_" + NPC tag.
	WalkWayPoints(FALSE, "spawn");

	// ---------- end scavenged code --------------------
	
	
	//Sandermann 03/06/2010 - Are we smart? if so then run separate AI set up for spellcasting and other
	//variables
	
	// this obviously doesn't work so I'll just comment it out
	/*if GetIsSmart();
		{
		ExecuteScript("acf_advanced_spawn", OBJECT_SELF);
		}
	*/
}

void ACR_CreatureOnSpellCastAt()
{
	//object oCaster = GetLastSpellCaster();
	string ai_script = "nw_c2_defaultb";

	// apply any effects on the creature
	//ACR_VFXOnSpellCastAt(oCaster, OBJECT_SELF);
	
	if (GetLocalInt(OBJECT_SELF, _CRE_NO_AI) == FALSE) 
	{
		// if we are using smart AI, call the OE associate script
		// otherwise call the nw_c2 AI script
		if (GetIsSmart())
			ai_script = "gb_assoc_spell";
	
		ExecuteScript(ai_script, OBJECT_SELF);
	}  
}

void ACR_CreatureOnPhysicallyAttacked()
{
	//object oAttacker = GetLastAttacker();
	string ai_script = "nw_c2_default5";
	
	// apply any effects on the creature
	//ACR_VFXOnAttack(oAttacker, OBJECT_SELF);
	if (GetLocalInt(OBJECT_SELF, _CRE_NO_AI) == FALSE) 
	{ 	
		// if we are using smart AI, call the OE associate script
		// otherwise call the nw_c2 AI script
		if (GetIsSmart())
			ai_script = "gb_assoc_attack";
	
		ExecuteScript(ai_script, OBJECT_SELF);
	}
}

void ACR_CreatureOnDamaged()
{
	//object oDamager = GetLastDamager();
	string ai_script = "nw_c2_default6";

	//DoNonlethalOnDamaged();
	
	// apply any effects on the creature
	//ACR_VFXOnDamage(oDamager, OBJECT_SELF);

	// if we are using smart AI, call the OE associate script
	// otherwise call the nw_c2 AI script
	if (GetIsSmart())
		ai_script = "gb_assoc_damage";
	
	ExecuteScript(ai_script, OBJECT_SELF);
}

void ACR_CreatureOnDeath()
{
	object oKiller = GetLastKiller();

	// report the death to the spawn system
	ACR_ReportSpawnDeath(OBJECT_SELF);

	// apply any effects on the creature
	//ACR_VFXOnDeath(oKiller, OBJECT_SELF);

	// Call the ALFA XP award functions to handle XP award
	ACR_AwardCombatXP(oKiller, OBJECT_SELF);

	// generate loot drops for mob kills
	if (! GetIsPC(OBJECT_SELF)) { ACR_GenerateTreasure(OBJECT_SELF, ACR_GetRandomDropValue(OBJECT_SELF)); }
	
	// Code scavenged from nw_c2_default7, to handle AI
	//  ----start borrowed code -----------------
	
	// Call to allies to let them know we're dead
	SpeakString("NW_I_AM_DEAD", TALKVOLUME_SILENT_TALK);
	
	//Shout Attack my target, only works with the On Spawn In setup
	SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);

	// ----end borrowed code --------------------

	// process bounties
	ACR_QuestCreatureOnDeath(oKiller);
}

void ACR_CreatureOnBlocked()
{
	string ai_script = "nw_c2_defaulte";
	
	if (GetLocalInt(OBJECT_SELF, _CRE_NO_AI) == FALSE) 
	{ 	
		// if we are using smart AI, call the OE associate script
		// otherwise call the nw_c2 AI script
		if (GetIsSmart())
			ai_script = "gb_assoc_block";
	
		ExecuteScript(ai_script, OBJECT_SELF);
	}
}

void ACR_CreatureOnEndCombatRound()
{
	string ai_script = "nw_c2_default3";
	
	if (GetLocalInt(OBJECT_SELF, _CRE_NO_AI) == FALSE) 
	{ 	
		// if we are using smart AI, call the OE associate script
		// otherwise call the nw_c2 AI script
		if (GetIsSmart())
			ai_script = "gb_comp_combat";
	
		ExecuteScript(ai_script, OBJECT_SELF);
	}
}

void ACR_CreatureOnConversation()
{
	if (GetLocalInt(OBJECT_SELF, _CRE_NO_AI) == FALSE) {
		// still call the Obsidian script for AI for now.
		ExecuteScript("nw_c2_default4", OBJECT_SELF);
	}
}

void ACR_CreatureOnInventoryDisturbed()
{
	object oDisturber = GetLastDisturbed();

	// apply any effects on the creature
	ACR_VFXOnDisturb(oDisturber, OBJECT_SELF);

	if (GetLocalInt(OBJECT_SELF, _CRE_NO_AI) == FALSE) {		
		// still call the Obsidian script for AI for now.
		ExecuteScript("nw_c2_default8", OBJECT_SELF);
	}
}

void ACR_CreatureOnHeartBeat()
{
	// if this is a pc, check if they perceive any creatures
	// AcadiusLost - deleted for now
	/*
	if (GetIsPC(OBJECT_SELF))
	{
		// ignore DMs
		if (GetIsDM(OBJECT_SELF) || GetIsDMPossessed(OBJECT_SELF)) { return; }
		
		// do the math - calculate an coordinate offset based on orientation angle

		vector vPosition = GetPositionFromLocation(GetLocation(OBJECT_SELF));
		float fX, fY, fLength = RADIUS_SIZE_VAST, fRatio = fLength/90.0, fFacing = GetFacing(OBJECT_SELF);
		int nNumIncrements = FloatToInt(fFacing) % 90;
		
		// handle angle rollovers
		if (fFacing == 360.0) { fFacing = 0.0; }
		
		// compute the target x and y coordinates based on the orientation quadrant
		if (fFacing < 90.0 && fFacing >= 0.0)
		{
			fX = vPosition.x + fLength - (nNumIncrements * fRatio); fY = vPosition.y + (nNumIncrements * fRatio);
		}
		else if (fFacing < 180.0 && fFacing >= 90.0)
		{
			fX = vPosition.x - (nNumIncrements * fRatio); fY = vPosition.y + fLength - (nNumIncrements * fRatio);
		}
		else if (fFacing < 270.0 && fFacing >= 180.0)
		{
			fX = vPosition.x - fLength + (nNumIncrements * fRatio); fY = vPosition.y - (nNumIncrements * fRatio);
		}
		else if (fFacing < 360.0 && fFacing >= 270.0)
		{
			fX = vPosition.x + (nNumIncrements * fRatio); fY = vPosition.y - fLength + (nNumIncrements * fRatio);
		}

		// generate the location marking the endpoint of the cone
		location lLocation = Location(GetArea(OBJECT_SELF), Vector(fX, fY, vPosition.z), fFacing);
		
		// find objects within their viewing range
		object oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, fLength, lLocation, TRUE);

		// loop through the matching creature objects and check if the pc identifies any he sees
		while(GetIsObjectValid(oTarget))
		{
			if (GetObjectSeen(oTarget)) { ACR_CreatureIdentify(OBJECT_SELF, oTarget); }
			oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, fLength, lLocation, TRUE);
		}
		
		return;
	}
	
	// apply any effects on the creature
	ACR_VFXOnHeartBeat(OBJECT_SELF);
	*/
	
	string ai_script = "nw_c2_default1";
	
	if (GetLocalInt(OBJECT_SELF, _CRE_NO_AI) == FALSE) 
	{ 	
		// if we are using smart AI, call the OE associate script
		// otherwise call the nw_c2 AI script
		if (GetIsSmart())
			ai_script = "gb_assoc_heart";
	
		ExecuteScript(ai_script, OBJECT_SELF);
	}
}

void ACR_CreatureOnRested()
{
	if (GetLocalInt(OBJECT_SELF, _CRE_NO_AI) == FALSE) {
		// still call the Obsidian script for AI for now.
		ExecuteScript("nw_c2_defaulta", OBJECT_SELF);
	}
}

void ACR_CreatureOnPerception()
{
	//object oPerceived = GetLastPerceived();
	string ai_script = "nw_c2_default2";
	
	if (GetLocalInt(OBJECT_SELF, _CRE_NO_AI) == FALSE) 
	{ 	
		// if we are using smart AI, call the OE associate script
		// otherwise call the nw_c2 AI script
		if (GetIsSmart())
			ai_script = "gb_assoc_percep";
	
		ExecuteScript(ai_script, OBJECT_SELF);
	}
}

void ACR_CreatureOnUserDefined()
{
	if (GetLocalInt(OBJECT_SELF, _CRE_NO_AI) == FALSE) {
		// still call the Obsidian script for AI for now.
		ExecuteScript("nw_c2_defaultd", OBJECT_SELF);
	}
}

void ACR_CreatureIdentify(object oPC, object oTarget)
{
	// first, determine which Knowledge skill applies.
	int nKnowSkill = GetKnowlegeSkillOfRace(GetRacialType(oTarget));
	if (nKnowSkill == -1) {
		WriteTimestampedLogEntry("Unaccounted RacialType Error identifying "+GetName(oTarget)+" with ResRef: "+GetResRef(oTarget)+" by PC: "+GetName(oPC)+" in area: "+GetName(GetArea(oTarget))); 
		nKnowSkill = SKILL_LORE;
	}
	// do a knowledge check - exit on failure
	if (d20() + GetSkillRank(nKnowSkill, oPC) < 10 + FloatToInt(GetChallengeRating(oTarget)))
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
	string sDisplayName = GetSubString(sName, 1, nEnd);   
	// compose the name to report to the player
	sName = ((sFirstChar == "A") || (sFirstChar == "E") || (sFirstChar == "I") ||
			 (sFirstChar == "O") || (sFirstChar == "U"))
			? "an " + GetSubString(sName, 1, nEnd) : "a " + GetSubString(sName, 1, nEnd);
		
	// report the filtered creature name
	SendMessageToPC(oPC, "You recognize the creature - <color=Magenta><i>" + sName + "!</i></color>");
	SetFirstName(oTarget, sDisplayName);
}

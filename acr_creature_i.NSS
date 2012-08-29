///////////////////////////////////////////////////////////////////////////////
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
#include "acr_skills_i"

#include "npc_onhb"
#include "npc_onper"

//#define REMOVE_NO_AI

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

const string _CRE_NO_AI = "ACR_CRE_NO_AI";
const string ACR_CRE_ISUNDEAD = "ACR_CRE_ISUNDEAD";
const int ACR_CRE_FORCE_NOT_UNDEAD = 2;


////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Variables ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// Puts oCreature in modes that let it run.
void _startRunning(object oCreature = OBJECT_SELF);

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

//! Checks if the creature is an undead type, even if it is not racially categorized as undead.
int ACR_GetIsUndead( object oTarget );


int GetCreatureAIType(object oCreature=OBJECT_SELF);


const int _HENCH_AI_MIN_INT = 5;


////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

/*
 * Custom AI levels:
 *
 * 0: Highest
 * 1: Medium
 * 2: Lowest
 */
int GetCreatureAIType(object oCreature=OBJECT_SELF)
{
	int x,y,z;

	if (GetLocalInt(oCreature, "AI_TYPE_CALC")) {
		return GetLocalInt(oCreature, "AI_TYPE");
	}

	x = GetLocalInt(oCreature, "ACR_NPC");
	y = (GetAbilityScore(oCreature,ABILITY_INTELLIGENCE) <= _HENCH_AI_MIN_INT);
	
	z = (x > y) ? x : y;

	if (GetLocalInt(oCreature, "ACR_HENCHMAN"))
		z = 0;

	SetLocalInt(oCreature,"AI_TYPE",z);
	SetLocalInt(oCreature,"AI_TYPE_CALC",1);

	return z;
}

void _startRunning(object oCreature = OBJECT_SELF) {
	if(!GetHasFeat(FEAT_KEEN_SENSE, oCreature, TRUE))
		SetActionMode(OBJECT_SELF, ACTION_MODE_DETECT, FALSE);
	
	SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, FALSE);
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
	
	SetLocalInt(OBJECT_SELF,"X2_L_NOTREASURE",1);
	SetLocalInt(OBJECT_SELF, "X2_L_SPAWN_USE_AMBIENT_IMMOBILE", 1);

	if (d8() == 0) {
		SetAnimationCondition(NW_ANIM_FLAG_IS_MOBILE_CLOSE_RANGE, 1);
		SetLocalInt(OBJECT_SELF, "X2_L_SPAWN_USE_AMBIENT", 0);
	}
	else
		SetAnimationCondition(NW_ANIM_FLAG_IS_MOBILE_CLOSE_RANGE, 0);

}

void ACR_CreatureOnSpellCastAt()
{
	//object oCaster = GetLastSpellCaster();
	string ai_script = "nw_c2_defaultb";

	// apply any effects on the creature
	//ACR_VFXOnSpellCastAt(oCaster, OBJECT_SELF);
	
#ifndef REMOVE_NO_AI
	if (GetLocalInt(OBJECT_SELF, _CRE_NO_AI)) 
		return;
#endif
	switch (GetCreatureAIType()) {
		case 0:
			ai_script = "gb_assoc_spell";
			break;
	}
	
	ExecuteScript(ai_script, OBJECT_SELF);
}

void ACR_CreatureOnPhysicallyAttacked()
{
	//object oAttacker = GetLastAttacker();
	string ai_script = "nw_c2_default5";
	
	// apply any effects on the creature
	//ACR_VFXOnAttack(oAttacker, OBJECT_SELF);
#ifndef REMOVE_NO_AI
	if (GetLocalInt(OBJECT_SELF, _CRE_NO_AI)) 
		return;
#endif
	switch (GetCreatureAIType()) {
		case 0:
			ai_script = "gb_assoc_attack";
			break;
	}
	
	ExecuteScript(ai_script, OBJECT_SELF);
}

void ACR_CreatureOnDamaged()
{
	//object oDamager = GetLastDamager();
	string ai_script = "nw_c2_default6";

	//DoNonlethalOnDamaged();
	
	// apply any effects on the creature
	//ACR_VFXOnDamage(oDamager, OBJECT_SELF);

	switch (GetCreatureAIType()) {
		case 0:
			ai_script = "gb_assoc_damage";
			break;
	}
	
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
	
#ifndef REMOVE_NO_AI
	if (GetLocalInt(OBJECT_SELF, _CRE_NO_AI)) 
		return;
#endif
	switch (GetCreatureAIType()) {
		case 0:
			ai_script = "gb_assoc_block";
			break;
	}
	
	ExecuteScript(ai_script, OBJECT_SELF);
}

void ACR_CreatureOnEndCombatRound()
{
	string ai_script = "nw_c2_default3";
	
#ifndef REMOVE_NO_AI
	if (GetLocalInt(OBJECT_SELF, _CRE_NO_AI)) 
		return;
#endif
	switch (GetCreatureAIType()) {
		case 0:
			ai_script = "gb_comp_combat";
			break;
	}

	ExecuteScript(ai_script, OBJECT_SELF);
}

void ACR_CreatureOnConversation()
{
#ifndef REMOVE_NO_AI
	if (GetLocalInt(OBJECT_SELF, _CRE_NO_AI)) 
		return;
#endif

	// still call the Obsidian script for AI for now.
	ExecuteScript("nw_c2_default4", OBJECT_SELF);
}

void ACR_CreatureOnInventoryDisturbed()
{
	object oDisturber = GetLastDisturbed();

	// apply any effects on the creature
	ACR_VFXOnDisturb(oDisturber, OBJECT_SELF);

#ifndef REMOVE_NO_AI
	if (GetLocalInt(OBJECT_SELF, _CRE_NO_AI)) 
		return;
#endif

	// still call the Obsidian script for AI for now.
	ExecuteScript("nw_c2_default8", OBJECT_SELF);
}

void ACR_CreatureOnHeartBeat()
{
	string ai_script = "nw_c2_default1";
	
#ifndef REMOVE_NO_AI
	if (GetLocalInt(OBJECT_SELF, _CRE_NO_AI)) 
		return;
#endif

	switch (GetCreatureAIType()) {
		case 0:
			ai_script = "gb_assoc_heart";
			break;
		case 2:
			npc_onhb();
			return;
	}
	
	ExecuteScript(ai_script, OBJECT_SELF);
}

void ACR_CreatureOnRested()
{

#ifndef REMOVE_NO_AI
	if (GetLocalInt(OBJECT_SELF, _CRE_NO_AI)) 
		return;
#endif

	// still call the Obsidian script for AI for now.
	ExecuteScript("nw_c2_defaulta", OBJECT_SELF);
}

void ACR_CreatureOnPerception()
{
	string ai_script = "nw_c2_default2";

#ifndef REMOVE_NO_AI
	if (GetLocalInt(OBJECT_SELF, _CRE_NO_AI)) 
		return;
#endif

	switch (GetCreatureAIType()) {
		case 0:
			ai_script = "gb_assoc_percep";
			break;
		case 2:
			npc_onper();
			return;
	}
	
	ExecuteScript(ai_script, OBJECT_SELF);
}

void ACR_CreatureOnUserDefined()
{

#ifndef REMOVE_NO_AI
	if (GetLocalInt(OBJECT_SELF, _CRE_NO_AI)) 
		return;
#endif

	// still call the Obsidian script for AI for now.
	ExecuteScript("nw_c2_defaultd", OBJECT_SELF);
}


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


int ACR_GetIsUndead( object oTarget ) {
	if ( GetLocalInt( oTarget, ACR_CRE_ISUNDEAD ) == ACR_CRE_FORCE_NOT_UNDEAD ) return FALSE;
	if ( GetRacialType( oTarget ) == RACIAL_TYPE_UNDEAD ) return TRUE;
	if ( GetLevelByClass( CLASS_TYPE_UNDEAD, oTarget ) > 0 ) return TRUE;
	if ( GetLocalInt( oTarget, ACR_CRE_ISUNDEAD ) == TRUE ) return TRUE;
	return FALSE;
}

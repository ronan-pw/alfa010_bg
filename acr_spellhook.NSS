/////////////////////////////////////////////////////////////////////////////
//
//  System Name : ALFA Core Rules
//     Filename : acr_spellhook.nss
//    $Revision:: 336        $ current version of the file
//        $Date:: 2010-09-22#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix: ACR_SHK
//  Dependencies: None
//
//  Description
//  This is the ALFA spellhook script. This script runs before all spell scripts fire.
//
//  Revision History
//  2007/07/15  Cipher  Inception
//  2007/11/13 AcadiusLost - added hooks for scroll and potion use.
//  2008/March Wynna - added hooks for Silvy Uni quests and Silvy Wards
//  2008/08/31 AcadiusLost - improved potion handling.
//  2008/09/05 AcadiusLost - added possessed familiar handling.
//  2008/10/25 AcadiusLost - switched silvy exterior recognition to a LocalInt
//  2008/12/05 AcadiusLost - cleared Mythal/Wards references for Baldur's Gate
//  2008/02/13 AcadiusLost - Added tradescroll hooks
//  2010/09/22 AcadiusLost - Added exception to spelltracking for Cast Spell items

//////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_spelltrack_i"
#include "acr_tradescroll_i"
#include "acr_wildmagic_i"

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

void ACR_PotionUse(object oOwner, object oDrinker, int nSpellID);

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main()
{
	int nSpellId = GetSpellId();
	object oCaster = OBJECT_SELF;
	object oItem = GetSpellCastItem();
	object oTarget = GetSpellTargetObject();
	location lTarget = GetSpellTargetLocation();
	int nItemType = GetBaseItemType(oItem);
	effect eFailure = EffectSpellFailure(100);
	int nRes;

	// Hook spells cast by wizards at spellbooks for tradescrolls.
	_DoTradeScrollSpellHook();	
	// if it is a familiar casting, and the master is unconscious, the spell fails.
	if (GetIsPossessedFamiliar(oCaster)) {
	    if (GetCurrentHitPoints(GetMaster(oCaster)) < 1 ) {
		    SendMessageToPC(oCaster, "You cannot deliver touch spells from "+GetName(GetMaster(oCaster))+", must be conscious.");
			SetModuleOverrideSpellScriptFinished();
		} else {
			// if the master is conscious, log and track the spell as if cast by the master.
		    oCaster = GetMaster(oCaster);
		}
	}
	
	if (GetLocalInt(oCaster, "ACR_WILD_MAGIC_ZONE")) {
		nRes = ACR_DetermineWildMagic(oCaster,oTarget,nSpellId,oItem);

		if (nRes != _WILD_MAGIC_NORMAL) {
			SendMessageToPC(oCaster,"Something goes awry!");
			SetModuleOverrideSpellScriptFinished();
		}

		switch (nRes) {
			case _WILD_MAGIC_REBOUND:
				lTarget = GetLocation(oCaster);

				if (oTarget != OBJECT_INVALID)
					AssignCommand(oCaster, DelayCommand(_WILD_MAGIC_TEMP_DUR, ActionCastSpellAtObject(nSpellId, oCaster, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
				else
					AssignCommand(oCaster, DelayCommand(_WILD_MAGIC_TEMP_DUR, ActionCastSpellAtLocation(nSpellId, lTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
				break;
				
			case _WILD_MAGIC_RANDOM:
				lTarget = GetLocation(oCaster);

				if (oTarget != OBJECT_INVALID)
					AssignCommand(oCaster, DelayCommand(_WILD_MAGIC_TEMP_DUR, ActionCastSpellAtObject(nSpellId, ACR_PickRandomTargetInRadius(oCaster, _WILD_MAGIC_EFFECT_RADIUS), METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
				else
					AssignCommand(oCaster, DelayCommand(_WILD_MAGIC_TEMP_DUR, ActionCastSpellAtLocation(nSpellId, ACR_PickRandomLocation(oCaster), METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
				break;

			case _WILD_MAGIC_RGRAV:
				SendChatMessage(oCaster, oCaster, CHAT_MODE_TALK, "<i>*Suddenly everything around "+GetName(oCaster)+" begins floating up -- then shortly after slams down back into the ground.*");
				ACR_DamageInRadius(oCaster, _WILD_MAGIC_EFFECT_RADIUS, 2, "For a moment you float into the air, then you slam down back onto the ground painfully."); 
				break;

			case _WILD_MAGIC_PIT:
				SendChatMessage(oCaster, oCaster, CHAT_MODE_TALK, "<i>* A gaping pit opens under "+GetName(oCaster)+", causing the person to tumble down within and slam painfully into the bottom.  Almost as soon as it appears it vanishes, leaving everything as it was before.*");
				ACR_DamageInRadius(oCaster, _WILD_MAGIC_PIT_RADIUS, GetCasterLevel(oCaster), "A gaping hole opens underneath you and you slam into the ground, causing a great deal of pain."); 
				break;

			case _WILD_MAGIC_FAIL:
			case _WILD_MAGIC_FAIL_NOEX:
			case _WILD_MAGIC_RAIN:
				break;

			case _WILD_MAGIC_HEAL:
				ACR_EffectInRadius(oCaster, _WILD_MAGIC_EFFECT_RADIUS, EffectHeal(999), "A surge of healing energy flows through you.", DURATION_TYPE_INSTANT);
				break;

			case _WILD_MAGIC_DARK:
				ACR_EffectInRadius(oCaster, _WILD_MAGIC_EFFECT_RADIUS, EffectDarkness(), "A cloud of blackness surrounds you.", DURATION_TYPE_TEMPORARY, IntToFloat(d4()+d4())*_WILD_MAGIC_SHORT_DUR);
				break;

			case _WILD_MAGIC_GLITTER:
				ACR_EffectInRadius(oCaster, _WILD_MAGIC_EFFECT_RADIUS, EffectLinkEffects(EffectVisualEffect(VFX_DUR_SPELL_PREMONITION), EffectBlindness()), "Glittering lights fill the surrounding area, blinding you.", DURATION_TYPE_TEMPORARY, IntToFloat(d4())*_WILD_MAGIC_SHORT_DUR);
				ACR_RemoveInvisInRadius(oCaster, _WILD_MAGIC_EFFECT_RADIUS);
				break;

			case _WILD_MAGIC_MAX:
			case _WILD_MAGIC_NOEX:

				ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectLinkEffects(EffectAbilityIncrease(ABILITY_WISDOM, 4), EffectLinkEffects(EffectAbilityIncrease(ABILITY_CHARISMA, 4), EffectAbilityIncrease(ABILITY_INTELLIGENCE, 4))), oCaster, _WILD_MAGIC_TEMP_DUR);

				if (oTarget != OBJECT_INVALID)

					AssignCommand(oCaster, DelayCommand(_WILD_MAGIC_TEMP_DUR, ActionCastSpellAtObject(nSpellId, oTarget, METAMAGIC_MAXIMIZE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
				else
					AssignCommand(oCaster, DelayCommand(_WILD_MAGIC_TEMP_DUR, ActionCastSpellAtLocation(nSpellId, lTarget, METAMAGIC_MAXIMIZE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
		}
	}
	
	//SendMessageToPC(oCaster, "Debug: spell item is "+GetName(oItem)+", with base item type "+IntToString(GetBaseItemType(oItem)));
	// scroll hook
	if ( nItemType == 75) {
		ACR_ScrollUse(oCaster, oItem, nSpellId);
	} else if ( nItemType == 49 ) {
	    // potion use, don't need to track it for persistency
	} else if ( nItemType == 96 ) {
	    // targetable potion, special handling
		ACR_PotionUse(oCaster, oTarget, nSpellId);
	} else if (GetIsObjectValid(oItem)) {
	    // miscellaneous cast spell item, don't need to track it for spell memory
	} else if (GetIsPC(oCaster) && !GetIsDM(oCaster) && !GetIsDMPossessed(oCaster)) { 
	    // if being cast by a PC (and not from a scroll), track use in the DB
	    ACR_RecordSpellUses(oCaster, nSpellId); 
	}
    // THIS IS A TEMPORARY HACK FOR A NON FUNCTIONING PC SPELLCASTAT EVENT
    // THIS SHOULD BE REMOVED ONCE OBSIDIAN REPAIRS THIS FUNCTIONALITY 
    if (GetIsPC(oTarget)) { ExecuteScript("acf_cre_onspellcastat", oTarget); }
	

}


void ACR_PotionUse(object oOwner, object oDrinker, int nSpellID) {

    // don't need to worry about checks if the potion is being used on onesself.
    if (oOwner != oDrinker) {
	    // potion is being used on another creature, need to determine if it's successful
		SendMessageToPC(oOwner, "You attempt to feed the potion to "+GetName(oDrinker));
		// if it's a downed PC that's being targeted, allow it. Otherwise, more checks.
		if (GetCurrentHitPoints(oDrinker) > 0) {
		    // is the target an enemy? If so, it will fail.
			if (GetIsEnemy(oDrinker, oOwner)) {
				// apply healing to potion holder instead.
			    AssignCommand(oOwner, ActionCastSpellAtObject(nSpellID, oOwner, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
			    //SendMessageToPC(oOwner, "You cannot force your enemy to drink a potion.  The contents spill to the ground.");
				SetModuleOverrideSpellScriptFinished();
			} else if (GetIsInCombat(oDrinker)) {
			    // can't really feed a potion to an ally who is busy fighting, this is what healing spells are for.
				// redirect healing to the owner (since we can't get the potion back at this point)
				SendMessageToPC(oOwner, GetName(oDrinker)+" is busy fighting and cannot be fed a potion now.");
				AssignCommand(oOwner, ActionCastSpellAtObject(nSpellID, oOwner, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
				SetModuleOverrideSpellScriptFinished();
			}
		} // target is nonhostile and not in combat, so allow the potion to be fed
	}
}

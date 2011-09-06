////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ALFA Configuration File
//     Filename : acf_mod_onactivateitem.nss
//    $Revision:: 222        $ current version of the file
//        $Date:: 2007-01-20#$ date the file was created or modified
//       Author : Ronan
//
//  Local Variable Prefix = None
//
//  Description
//  This script calls the module's OnActivateItem event, and any custom code added
//  by this server. It is usually used to set up server-specific options.
//  This file should NOT be overwriten in ACR updates so as to preserve any of
//  the server's customized code they may have added.
//
//  Revision History
//  2007/01/20  Cipher  Moved ExecuteScript() item script to ACR_ModuleOnActivateItem()
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#include "acr_mod_events_i"
#include "ginc_param_const"

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


void PlayCustomAnimationWrapper(object oTarget, string sAnim, int bLoop)	//so it returns a void
{
	PlayCustomAnimation(oTarget,sAnim,bLoop);
}

void main() {
    ACR_ModuleOnActivateItem();

    // Custom code goes below this line.
	
    object oItem = GetItemActivated();
    object oTarget = GetItemActivatedTarget();
    string sItem = GetTag(oItem);
    string sName = GetName(oItem);
    location lLoc = GetItemActivatedTargetLocation();
    string sRef = GetResRef(oItem);
    object oOwner = GetItemPossessor(oItem);
    object oPC = oOwner;
	
	if (sItem == "009_it_devilweed")
	{
		effect DevilweedDMG = EffectAbilityDecrease (ABILITY_WISDOM, 2);
		effect DevilweedSTR = EffectAbilityIncrease (ABILITY_STRENGTH, 2);
	
		ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect(DevilweedDMG), oPC);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ExtraordinaryEffect(DevilweedSTR), oPC, HoursToSeconds(d3()));
		SendMessageToPC(oPC, "You feel a little stronger, though your head feels cloudy.");
	}
	else if (sItem == "abr_it_gr_oil")
	{
		if (GetDistanceBetween(oPC,oTarget) > 3.0)
			SendMessageToPC(oPC, "You spill some oil.  You need to get closer.");
		else 
			ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(1,DAMAGE_TYPE_FIRE),oTarget);
	}
	
	else if (sItem == "010_it_misc_leech")
	{
        if(GetDistanceBetween(oPC,oTarget) <= 3.0)
        {
            AssignCommand(oPC, ActionSpeakString("*applies some leeches on "+GetName(oTarget)+"*"));
            int iLeech = d100();
            if(iLeech >= 90)
            {
                AssignCommand(oPC, ActionSpeakString("They worked!"));
                effect eEffect = GetFirstEffect(oTarget);
                while (GetIsEffectValid(eEffect))
                {
                    if (GetEffectType(eEffect) == EFFECT_TYPE_DISEASE)
                        RemoveEffect(oTarget, eEffect);
                    else if (GetEffectType(eEffect) == EFFECT_TYPE_POISON)
                        RemoveEffect(oTarget, eEffect);
                    eEffect = GetNextEffect(oTarget);
                }
            }
            else
            {
	        AssignCommand(oPC, ActionSpeakString("They didn't seem to help."));
                if(iLeech <= 25)
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(1,DAMAGE_TYPE_PIERCING),oTarget);
            }
        }
        else
			SendMessageToPC(oPC, "You dropped a leech on the ground.  You need to get closer.");
	}
	else if (sItem == "010_it_misc_skit")
	{
        if(oTarget == oPC)
		SendMessageToPC(oPC, "You can't use it on yourself.");
        else if((GetDistanceBetween(oPC,oTarget) <= 3.0))
        {
            if(GetIsFriend(oPC,oTarget))
            {
            	AssignCommand(oPC, ActionSpeakString("*uses a surgical kit on "+GetName(oTarget)+"*"));
                int iCut = d100() + GetSkillRank(SKILL_HEAL,oPC);
                if(iCut <= 20)
                {
            		AssignCommand(oPC, ActionSpeakString("I cut something important!"));
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(TRUE,FALSE),oTarget);
                }
                else if(20 < iCut <= 70)
                {
            		AssignCommand(oPC, ActionSpeakString("I did something wrong . . ."));
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d10(),DAMAGE_TYPE_PIERCING),oTarget);
                }
                else if(70 < iCut <= 80)
                {
            		AssignCommand(oPC, ActionSpeakString("That helped a little."));
                    effect eEffect = GetFirstEffect(oTarget);
                    while (GetIsEffectValid(eEffect))
                    {
                        if (GetEffectType(eEffect) == EFFECT_TYPE_DISEASE)
                            RemoveEffect(oTarget, eEffect);
                        else if (GetEffectType(eEffect) == EFFECT_TYPE_POISON)
                            RemoveEffect(oTarget, eEffect);
                        eEffect = GetNextEffect(oTarget);
                    }
                }
                else if(80 < iCut <= 95)
                {
            		AssignCommand(oPC, ActionSpeakString("It worked, I think."));
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(d10()),oTarget);
                    effect eEffect = GetFirstEffect(oTarget);
                    while (GetIsEffectValid(eEffect))
                    {
                        if (GetEffectType(eEffect) == EFFECT_TYPE_DISEASE)
                            RemoveEffect(oTarget, eEffect);
                        else if (GetEffectType(eEffect) == EFFECT_TYPE_POISON)
                            RemoveEffect(oTarget, eEffect);
                        eEffect = GetNextEffect(oTarget);
                    }
                }
                else if(iCut > 95)
                {
            		AssignCommand(oPC, ActionSpeakString("Outstanding!"));
                    effect eEffect = GetFirstEffect(oTarget);
                    while (GetIsEffectValid(eEffect))
                    {
                        if (GetEffectType(eEffect) == EFFECT_TYPE_DISEASE)
                            RemoveEffect(oTarget, eEffect);
                        else if (GetEffectType(eEffect) == EFFECT_TYPE_POISON)
                            RemoveEffect(oTarget, eEffect);
                        eEffect = GetNextEffect(oTarget);
                    }
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oTarget)-GetCurrentHitPoints(oTarget)),oTarget);
                }
            }
            else
		SendMessageToPC(oPC, "You can only use it on a willing target.");
        }
        else
		SendMessageToPC(oPC, "You're too far away.");
	}
	else if (sItem == "010_it_misc_cdrill")
	{
        if(oTarget == oPC)
            FloatingTextStringOnCreature("You can't use it on yourself.",oPC,FALSE);
        else if(GetDistanceBetween(oPC,oTarget) < 3.0)
        {
            if(GetIsFriend(oPC,oTarget))
            {
                int iDrill = d100() + GetSkillRank(SKILL_HEAL,oPC);
                if(iDrill <= 10)
                {
            		AssignCommand(oPC, ActionSpeakString("I drilled too far!"));
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(TRUE,FALSE),oTarget);
                }
                else if((iDrill > 10) && (iDrill <= 40))
                {
            		AssignCommand(oPC, ActionSpeakString("Oh no!  I caused brain damage!"));
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectAbilityDecrease(ABILITY_INTELLIGENCE,2),oTarget);
                }
                else if((iDrill > 40) && (iDrill <= 70))
                {
            		AssignCommand(oPC, ActionSpeakString("Oh no!  I caused brain damage!"));
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectAbilityDecrease(ABILITY_INTELLIGENCE,1),oTarget);
                }
                else if((iDrill > 70) && (iDrill <= 95))
                {
            		AssignCommand(oPC, ActionSpeakString("That didn't seem to help."));
                }
                else if(iDrill > 95)
                {
            		AssignCommand(oPC, ActionSpeakString("It worked!"));
                    effect eEffect = GetFirstEffect(oTarget);
                    while (GetIsEffectValid(eEffect))
                    {
                        if (GetEffectType(eEffect) == EFFECT_TYPE_CONFUSED)
                            RemoveEffect(oTarget, eEffect);
                        else if (GetEffectType(eEffect) == EFFECT_TYPE_CHARMED)
                            RemoveEffect(oTarget, eEffect);
                        else if (GetEffectType(eEffect) == EFFECT_TYPE_DOMINATED)
                            RemoveEffect(oTarget, eEffect);
                        else if (GetEffectType(eEffect) == EFFECT_TYPE_FRIGHTENED)
                            RemoveEffect(oTarget, eEffect);
                        eEffect = GetNextEffect(oTarget);
                    }
                }
            }
            else
		SendMessageToPC(oPC, "You can only use it on a willing target.");
        }
        else
		SendMessageToPC(oPC, "You're too far away.");
	}
	else if (sItem == "abr_it_msc_bagpipes")
	{
		DelayCommand(0.1f,PlayCustomAnimationWrapper(oPC,"bagpipes",1));
	}
}
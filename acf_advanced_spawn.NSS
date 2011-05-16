/*
This script handles set up for an NPC using smart AI.
It borrows heavily from gb_comp_spawn.nss and the gb_xxx associate scripts.
Sandermann - 03/06/2010
*/
#include "x0_i0_assoc"

void main()
{
//DEBUG variable, if 1 will send debug message to first PC in module
int DEBUG=0;
object TESTER=GetFirstPC();
string NAME=GetFirstName(OBJECT_SELF);

if (DEBUG==1){AssignCommand(OBJECT_SELF,ActionSpeakString(NAME+" Using advanced AI"));}

//Should we set our self to use ranged combat tactics?
//If we have a ranged weapon and our Dex bonus is higher than strength, and we do not have weapon finesse
//If we have weapon focus in one or more ranged weapons (assumption is the builder has given the NPC
//the correct weapon)
//If the above are true, then set ourself to use ranged combat tactics. -Note that switching back to
//melee should circumstances prove unfavourable is handled in the combat round determination scripts
//so the NPC may still choose to fight in melee
//if X4_L_AI_COMBAT_RANGED is already set, skip this part of set up.

if (!GetLocalInt(OBJECT_SELF,"X4_L_AI_COMBAT_RANGED"))
	{
	if 	((GetWeaponRanged(GetItemInSlot(4)))&&
			((GetAbilityModifier(1))>(GetAbilityModifier(0))))
			{SetLocalInt(OBJECT_SELF,"X4_L_AI_COMBAT_RANGED",1);
			if (DEBUG==1){AssignCommand(OBJECT_SELF,ActionSpeakString(NAME+" RANGED TACTICS"));}}
	else if ((GetHasFeat(92))||//Hv XBow
			(GetHasFeat(93))||//Lt XBow
			(GetHasFeat(101))||//LongBow
			(GetHasFeat(102))||//ShortXBow
			(GetHasFeat(91))||//Dart
			(GetHasFeat(109))||//Throw Axe
			(GetHasFeat(120))||//Shuriken
			(GetHasFeat(99)))//Sling
			{SetLocalInt(OBJECT_SELF,"X4_L_AI_COMBAT_RANGED",1);
			if (DEBUG==1){AssignCommand(OBJECT_SELF,ActionSpeakString(NAME+" RANGED TACTICS"));}}
	
		
			
	}

//Should we use Stealth tactics?
//Base chance is (Hide+MS)*5
//Do we have HiPs
//-Note we ignore Invis and Greater invis here as these are looked for in combat round determination
//-We skip this if X4_L_AI_COMBAT_AMBUSH is already set on the creature
if (!GetLocalInt(OBJECT_SELF,"X4_L_AI_COMBAT_AMBUSH"))
	{
	int nHide=GetSkillRank(5);
	int nMS=GetSkillRank(8);
	int iChance=((nHide+nMS)*5);
	if (GetHasFeat(433))
		{SetLocalInt(OBJECT_SELF,"X4_L_AI_COMBAT_AMBUSH",1);
		if (DEBUG==1){AssignCommand(OBJECT_SELF,ActionSpeakString(NAME+" STEALTH TACTICS"));}}
	else if ((d100())<iChance)
		{SetLocalInt(OBJECT_SELF,"X4_L_AI_COMBAT_AMBUSH",1);
		if (DEBUG==1){AssignCommand(OBJECT_SELF,ActionSpeakString(NAME+" STEALTH TACTICS"));}}
	
	} 	

//Should we assist allies (buffs but mainly with healing spells)?
//This is directly linked to how evil we are, evil creatures will
//avoid helping allies, thereby using the combat round to focus on
//attacking enemies - Note even with not set the NPC may still choose to aid allies if
//it makes sense to do so.
//Skip if X2_L_BEH_COMPASSION is already set on the creature
int iGoodEvil=GetGoodEvilValue(OBJECT_SELF);
SetLocalInt(OBJECT_SELF,"X2_L_BEH_COMPASSION",iGoodEvil);
if (DEBUG==1){AssignCommand(OBJECT_SELF,ActionSpeakString(NAME+" = COMPASSION VALUE :" +IntToString(iGoodEvil)));}	

//should we use defensive feats if we have them?
//Currently set to always true - testing seems to indicate the NPC will only use these feats if it makes sense
//to do so, this variable does not force their use
SetLocalInt(OBJECT_SELF,"X4_L_AI_COMBAT_DEFENSE",1);
if (DEBUG==1){AssignCommand(OBJECT_SELF,ActionSpeakString(NAME+" DEFENSE TACTICS"));}

//should we use offensive feats if we have them?
//same as above, no harm setting this to on by default
SetLocalInt(OBJECT_SELF,"X2_L_BEH_OFFENSE",1);
if (DEBUG==1){AssignCommand(OBJECT_SELF,ActionSpeakString(NAME+" OFFENSE TACTICS"));}
	
//Should we call for help if we are attacked?
//This will be heard by all allied NPCs in range - wether they respond or not is dependant on the
//X4_L_ASSIST_ALLIES being set.
//Currentyl default to on, theres no harm in calling for help if we need it.
SetLocalInt(OBJECT_SELF,"X4_L_SHOUT_WARNING",1);
if (DEBUG==1){AssignCommand(OBJECT_SELF,ActionSpeakString(NAME+" SHOUT WARNING"));}

//Should we respond to a call for help from an ally?
//if X4_L_ASSIST_ALLIES is not already set then this defaults to 50% + (Good-Evil/2)
//-Note this does not mean the NPC will necessarily help an ally, only thatt the option to help
//will be considered in its action queue
//-Helping could mean attacking the callers target, healing the caller, casting buffs on the caller
//so this switch is better to use for an NPC caster with minions than X2_L_BEH_COMPASSION
if (!GetLocalInt(OBJECT_SELF,"X4_L_ASSIST_ALLIES"))
	{
	int iGoodEvil=GetGoodEvilValue(OBJECT_SELF);
	int iChance=(iGoodEvil/2)+50;
	if (d100()<iChance)
		{SetLocalInt(OBJECT_SELF,"X4_L_ASSIST_ALLIES",1);
		if (DEBUG==1){AssignCommand(OBJECT_SELF,ActionSpeakString(NAME+" ASSIST ALLIES"));}}
	}

//How should we cast spells?
//Was not sure the best way to determine this, it mimicks the behaviour of Henchman in the SP campaign.
//It would make sense to have an NPC always over kill cast, but this is meta - the NPC does not know
//that the PCs are the only combats it will face before resting.
//I defaulted this to the Chaos-Law axis. The more chaotic a creature the more likely it will choose to cast 
//in overkill mode, the more lawful the more likely it will use measured casting.
int iChaosLaw=GetLawChaosValue(OBJECT_SELF);
if (d100()>iChaosLaw)
	{SetAssociateState(NW_ASC_OVERKIll_CASTING);
	if (DEBUG==1){AssignCommand(OBJECT_SELF,ActionSpeakString(NAME+" OVERKILL CASTING"));}}
else {SetAssociateState(NW_ASC_SCALED_CASTING);
	if (DEBUG==1){AssignCommand(OBJECT_SELF,ActionSpeakString(NAME+" SCALED CASTING"));}}

//this should stop and NPC casting heal spells too early
//it wont consider a healing spell until an ally is at 25% hp or less
SetAssociateState(NW_ASC_HEAL_AT_25);

//this will auto buff an NPC when enemies come close
//-this is meta but unlike PCs the NPC can not spot a threat, retreat to buff, then attack again
//-this can be exploited by PCs who trigger the buff, then fall back and wait for it to expire
//but this should not be too much of an issue. The NPC will only buff when PCs come within its perception
//range so it should also attack
SetAssociateState(NW_ASC_AGGRESSIVE_BUFF);
}
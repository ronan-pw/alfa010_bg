#include "010_drugs_i"

void main()
{
	object oPC      = GetItemActivator();
	object oItem    = GetItemActivated();

	ACR_ConsumeDrug(oPC, ACR_DRUG_VODARE, 13);
}


void drug_primary_effect(object oPC)
{
	// +2 intimidate
	// +2 saving throw vs fear
	effect eInt = EffectSkillIncrease(SKILL_INTIMIDATE, 2);
	effect eSave = EffectSavingThrowIncrease(SAVING_THROW_WILL, 2, SAVING_THROW_TYPE_FEAR);

	effect eMod = EffectLinkEffects(eInt, eSave);

	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ExtraordinaryEffect(eMod), oPC, HoursToSeconds(d4()));

	SendMessageToPC(oPC, "A feeling of power surges in you, making you nearly fearless and intimidating.");
}

void drug_secondary_effect(object oPC)
{
	// -4 dip, bluff
	effect eDip = EffectSkillDecrease(SKILL_DIPLOMACY, 4);
	effect eBlf = EffectSkillDecrease(SKILL_BLUFF, 4);
	
	effect eMod = EffectLinkEffects(eDip, eBlf);

	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ExtraordinaryEffect(eMod), oPC, HoursToSeconds(d4(2)));
}

void drug_side_effect(object oPC)
{
	SendMessageToPC(oPC, "Mild euphoria fills you along with a fierce confidence.");
}

void drug_overdose_effect(object oPC)
{
	effect eStun = EffectStunned();

	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ExtraordinaryEffect(eStun), oPC, HoursToSeconds(d4(2)));

	SendMessageToPC(oPC, "The narcotic overwhelms you entirely, leaving you stunned.");
}


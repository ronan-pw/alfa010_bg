#include "010_drugs_i"

void main()
{
	object oPC      = GetItemActivator();
	object oItem    = GetItemActivated();

	ACR_ConsumeDrug(oPC, ACR_DRUG_TERRAN, 19);
}


void drug_primary_effect(object oPC)
{
	// increase caster level +2 for 1d20+20
	effect eInt = EffectAbilityIncrease(ABILITY_INTELLIGENCE, 4);
	effect eWis = EffectAbilityIncrease(ABILITY_CHARISMA, 4);
	effect eCha = EffectAbilityIncrease(ABILITY_CHARISMA, 4);

	effect eMod = EffectLinkEffects(eInt, eCha);

	eMod = EffectLinkEffects(eMod, eWis);

	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMod, oPC, TurnsToSeconds(d20()+20));

	SendMessageToPC(oPC, "A feeling of extreme mental agility and magical power comes over you as you drink the liquid.");
}

void drug_secondary_effect(object oPC)
{
	// constitution damage
	effect eCon = EffectAbilityDecrease(ABILITY_CONSTITUTION, 2);
	
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect(eCon), oPC);
}

void drug_side_effect(object oPC)
{
}

void drug_overdose_effect(object oPC)
{
	// con damage 1
	effect eCon = EffectAbilityDecrease(ABILITY_CONSTITUTION, 1);

	ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect(eCon), oPC);
}


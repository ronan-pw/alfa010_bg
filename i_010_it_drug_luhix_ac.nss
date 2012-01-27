#include "010_drugs_i"

void main()
{
	object oPC      = GetItemActivator();
	object oItem    = GetItemActivated();

	ACR_ConsumeDrug(oPC, ACR_DRUG_LUHIX, 25, TRUE);
}


void drug_primary_effect(object oPC)
{
	// stats decrease 1
	effect eStr = EffectAbilityDecrease(ABILITY_STRENGTH, 1);
	effect eDex = EffectAbilityDecrease(ABILITY_DEXTERITY, 1);
	effect eCon = EffectAbilityDecrease(ABILITY_CONSTITUTION, 1);
	effect eWis = EffectAbilityDecrease(ABILITY_WISDOM, 1);
	effect eInt = EffectAbilityDecrease(ABILITY_INTELLIGENCE, 1);
	effect eCha = EffectAbilityDecrease(ABILITY_CHARISMA, 1);

	effect eMod = EffectLinkEffects(eStr, eDex);

	eMod = EffectLinkEffects(eMod, eCon);
	eMod = EffectLinkEffects(eMod, eWis);
	eMod = EffectLinkEffects(eMod, eInt);
	eMod = EffectLinkEffects(eMod, eCha);

	ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect(eMod), oPC);
	SendMessageToPC(oPC, "Overwhelming pain nearly overcomes you as you pour the narcotic into an open wound, nearly causing you to lapse into unconsciousness.");
}

void drug_secondary_effect(object oPC)
{
	// all stats increase +2
	effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH, 2);
	effect eDex = EffectAbilityIncrease(ABILITY_DEXTERITY, 2);
	effect eCon = EffectAbilityIncrease(ABILITY_CONSTITUTION, 2);
	effect eWis = EffectAbilityIncrease(ABILITY_WISDOM, 2);
	effect eInt = EffectAbilityIncrease(ABILITY_INTELLIGENCE, 2);
	effect eCha = EffectAbilityIncrease(ABILITY_CHARISMA, 2);

	effect eMod = EffectLinkEffects(eStr, eDex);

	eMod = EffectLinkEffects(eMod, eCon);
	eMod = EffectLinkEffects(eMod, eWis);
	eMod = EffectLinkEffects(eMod, eInt);
	eMod = EffectLinkEffects(eMod, eCha);

	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ExtraordinaryEffect(eMod), oPC, HoursToSeconds(d2()));

	SendMessageToPC(oPC, "The aching dulls and a feeling of invincibility sweeps over you, along with an immunity to all forms of pain.");
}

void drug_side_effect(object oPC)
{
	// pain immunity
}

void drug_overdose_effect(object oPC)
{
	// die
	effect sDeath = EffectDeath(1,1);

	ApplyEffectToObject(DURATION_TYPE_INSTANT, ExtraordinaryEffect(sDeath), oPC, 0.0f);

}


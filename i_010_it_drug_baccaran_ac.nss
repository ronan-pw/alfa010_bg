#include "010_drugs_i"

void main()
{
	object oPC      = GetItemActivator();
	object oItem    = GetItemActivated();

	ACR_ConsumeDrug(oPC, ACR_DRUG_BACCARAN, 15);
}


void drug_primary_effect(object oPC)
{
	// strength decrease
	effect eStr = EffectAbilityDecrease(ABILITY_STRENGTH, d4());
	
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect(eStr), oPC);
	SendMessageToPC(oPC, "Your muscles weaken somewhat as you ingest the substance.");
}

void drug_secondary_effect(object oPC)
{
	// wisdom increase
	effect eWis = EffectAbilityIncrease(ABILITY_WISDOM, d4()+1);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ExtraordinaryEffect(eWis), oPC, TurnsToSeconds(d10()+15));

	SendMessageToPC(oPC, "A slow feeling of spiritual fulfillment washes over you.");
}

void drug_side_effect(object oPC)
{
	// -4 to will save vs mind
	effect sSave = EffectSavingThrowDecrease(SAVING_THROW_WILL, 4, SAVING_THROW_TYPE_MIND_SPELLS);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ExtraordinaryEffect(sSave), oPC, HoursToSeconds(d4(2)));
}

void drug_overdose_effect(object oPC)
{
	// -8 to will save vs mind
	// 2d6 damage
	effect sSave = EffectSavingThrowDecrease(SAVING_THROW_WILL, 4, SAVING_THROW_TYPE_MIND_SPELLS);
	effect eDam = EffectDamage(d6(2)); 

	SendMessageToPC(oPC, "After consuming the paste, you feel an intense sensation of pain.");

	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ExtraordinaryEffect(sSave), oPC, HoursToSeconds(d4(2)));
	ApplyEffectToObject(DURATION_TYPE_INSTANT, ExtraordinaryEffect(eDam), oPC, 0.0f);

}


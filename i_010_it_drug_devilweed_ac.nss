#include "ginc_overland"
#include "010_drugs_i"

void main()
{
	object oPC      = GetItemActivator();
	object oItem    = GetItemActivated();

	ACR_ConsumeDrug(oPC, ACR_DRUG_DEVILWEED, 15);
}


void drug_primary_effect(object oPC)
{
	effect DevilweedDMG = EffectAbilityDecrease(ABILITY_WISDOM, 1);
	
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect(DevilweedDMG), oPC);
}

void drug_secondary_effect(object oPC)
{
	effect DevilweedSTR = EffectAbilityIncrease(ABILITY_STRENGTH, 2);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, DevilweedSTR, oPC, HoursToSeconds(d3()));

	SendMessageToPC(oPC, "A slow feeling of invigoration begins filling your muscles.");
}

void drug_side_effect(object oPC)
{
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ExtraordinaryEffect(EffectShaken()), oPC, HoursToSeconds(d3()));

	SendMessageToPC(oPC, "As you puff the smoke a feeling of anxiety overcomes you, your head increasingly cloudy.");
}

void drug_overdose_effect(object oPC)
{
	// none
}


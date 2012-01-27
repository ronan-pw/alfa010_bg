#include "010_drugs_i"

void main()
{
	object oPC      = GetItemActivator();
	object oItem    = GetItemActivated();

	ACR_ConsumeDrug(oPC, ACR_DRUG_MORDAYN, 15);
}


void drug_primary_effect(object oPC)
{
	effect eDaze = ExtraordinaryEffect(EffectDazed());

	// dazed with hallucinations
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDaze, oPC, TurnsToSeconds(d20()+10)); 

	SendMessageToPC(oPC, "Exotic visions of incredibly beauty enthrall you, leaving you somewhat dazed.");
}

void drug_secondary_effect(object oPC)
{
	// 1d4 con/wis damage
	effect eCon = EffectAbilityDecrease(ABILITY_CONSTITUTION, d4());
	effect eWis = EffectAbilityDecrease(ABILITY_WISDOM, d4());

	effect eMod = EffectLinkEffects(eCon, eWis);
	
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect(eMod), oPC);
	SendMessageToPC(oPC, "Your body feels overwhelmed by the sweet scent of the vapors.");
}

void drug_side_effect(object oPC)
{
	int i;
	string str = "Dancing lights and colours continue to overwhelm your senses.";

	// spam messages of euphoria
	for (i = 0; i <= 11; i++) {
		AssignCommand(oPC, DelayCommand(TurnsToSeconds(i), SendMessageToPC(oPC, str)));
	}

	// TODO: add compulsion at conclusion of dose
}

void drug_overdose_effect(object oPC)
{
	// 1d10 con damage
	effect eCon = EffectAbilityDecrease(ABILITY_CONSTITUTION, d10());

	ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect(eCon), oPC);
}


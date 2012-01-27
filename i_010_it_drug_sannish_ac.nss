#include "010_drugs_i"

void main()
{
	object oPC      = GetItemActivator();
	object oItem    = GetItemActivated();

	ACR_ConsumeDrug(oPC, ACR_DRUG_SANNISH, 9);
}

void drug_primary_effect(object oPC)
{
	// wisdom decrease
	effect eWis = EffectAbilityDecrease(ABILITY_WISDOM, 1);
	
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect(eWis), oPC);
	SendMessageToPC(oPC, "Your mind feels somewhat cloudy after ingesting the compound.");
}

void drug_secondary_effect(object oPC)
{
	SendMessageToPC(oPC, "A sense of invulnerability washes over you, immunte to pain for a time.");
}

void drug_side_effect(object oPC)
{
	effect eSlow = EffectMovementSpeedDecrease(15);
	int i;
	string str = "The feeling of euphoria has still not abated, leaving you a little lethargic.";

	// slow 15% to emulate -2 to initiative
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ExtraordinaryEffect(eSlow), oPC, HoursToSeconds(d4()));

	SendMessageToPC(oPC, "A feeling of euphoric sluggishness overcomes you.");

	// spam messages of euphoria
	for (i = 2; i <= 10; i += 2) {
		AssignCommand(oPC, DelayCommand(TurnsToSeconds(i), SendMessageToPC(oPC, str)));
	}
}

void drug_overdose_effect(object oPC)
{
	effect eDaze = EffectDazed();
	// Dazed 2d4 hrs
	SendMessageToPC(oPC, "You sink into a numbing stupor, unable to do much of anything.");
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ExtraordinaryEffect(eDaze), oPC, HoursToSeconds(d4(2))); 
}


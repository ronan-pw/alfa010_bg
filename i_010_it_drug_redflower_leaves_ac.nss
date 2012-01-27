#include "010_drugs_i"

void main()
{
	object oPC      = GetItemActivator();
	object oItem    = GetItemActivated();

	ACR_ConsumeDrug(oPC, ACR_DRUG_REDFLOWER, 10);
}


void drug_primary_effect(object oPC)
{
}

void drug_secondary_effect(object oPC)
{
	// ab increase +4
	// slow 50% to reflect removal of move action
	effect eAtk = EffectAttackIncrease(4);
	effect eSlow = EffectMovementSpeedDecrease(50);

	effect eMod = EffectLinkEffects(eAtk, eSlow);
	
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ExtraordinaryEffect(eMod), oPC, TurnsToSeconds(10));

	SendMessageToPC(oPC, "Your attacks begin to become far more precise, though you find yourself somewhat sluggish.");
}

void drug_side_effect(object oPC)
{
}

void drug_overdose_effect(object oPC)
{
	// nauseated 
	effect eDaze = EffectDazed();

	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ExtraordinaryEffect(eDaze), oPC, TurnsToSeconds(d4()*10));
	SendMessageToPC(oPC, "An intense bout of nausea overwhelms you.");
}


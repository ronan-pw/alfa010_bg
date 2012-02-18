#include "010_drugs_i"

void main()
{
	object oPC      = GetItemActivator();
	object oItem    = GetItemActivated();

	ACR_ConsumeDrug(oPC, ACR_DRUG_MUSHROOM, 15);
}


void drug_primary_effect(object oPC)
{
	// int/cha increase
	effect eInt = EffectAbilityIncrease(ABILITY_INTELLIGENCE, 2);
	effect eCha = EffectAbilityIncrease(ABILITY_CHARISMA, 2);

	effect eMod = EffectLinkEffects(eInt, eCha);

	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ExtraordinaryEffect(eMod), oPC, HoursToSeconds(1));

	SendMessageToPC(oPC, "A feeling of mental agility comes over you as you inhale the powder.");
}

void drug_secondary_effect(object oPC)
{
	// strength damage
	effect eStr = EffectAbilityDecrease(ABILITY_STRENGTH, 1);
	
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect(eStr), oPC);
}

void drug_side_effect(object oPC)
{
	// -2 wisdom 1d4 hrs
	// -2 con/str 2d4 hrs
	effect eWis = EffectAbilityDecrease(ABILITY_WISDOM, 2);
	effect eStr = EffectAbilityDecrease(ABILITY_STRENGTH, 2);
	effect eCon = EffectAbilityDecrease(ABILITY_CONSTITUTION, 2);

	effect eMod = EffectLinkEffects(eStr, eCon);

	SendMessageToPC(oPC, "Your muscles begin to slowly weaken.");

	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ExtraordinaryEffect(eWis), oPC, HoursToSeconds(d4(1)));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ExtraordinaryEffect(eMod), oPC, HoursToSeconds(d4(2)));
}

void drug_overdose_effect(object oPC)
{
	// 2d6 damage
	effect eDam = EffectDamage(d6(2)); 

	SendMessageToPC(oPC, "After inhaling the powder, you feel an intense sensation of pain.");

	ApplyEffectToObject(DURATION_TYPE_INSTANT, ExtraordinaryEffect(eDam), oPC, 0.0f);
}

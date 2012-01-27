#include "010_drugs_i"

void main()
{
	object oPC      = GetItemActivator();
	object oItem    = GetItemActivated();

	ACR_ConsumeDrug(oPC, ACR_DRUG_AGONY, 18, TRUE);
}


void drug_primary_effect(object oPC)
{
	effect eStun = ExtraordinaryEffect(EffectStunned());
	effect eVis = EffectVisualEffect(VFX_IMP_STUN);
	effect eDaze = ExtraordinaryEffect(EffectDazed());

	float fTime0 = RoundsToSeconds(d4()+1);
	float fTime1 = TurnsToSeconds(d6())+fTime0;

	// Stunned (2-5 rounds)
	SendMessageToPC(oPC, "As you consume the ruddy liquid a intense feeling of absolute euphoria overwhelms you:  so much so that reality slowly slips away and you remain motionless.");
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oPC, fTime0);


	// Dazed (1-6 minutes)
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDaze, oPC, fTime1); 
	AssignCommand(oPC, DelayCommand(fTime0, SendMessageToPC(oPC, "Feelings of intense pleasure course through your entire body, leaving you somewhat lethargic.")));

}

void drug_secondary_effect(object oPC)
{
	effect eChar = ExtraordinaryEffect(EffectAbilityIncrease(ABILITY_CHARISMA, 1+d4()));

	// Charisma (51-60 minutes)
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eChar, oPC, TurnsToSeconds(d10()+50)); 

	SendMessageToPC(oPC, "You find yourself a good deal more genial and talkative than usual, a peculiar radiant glow about you that puts them at ease.");
}

void drug_side_effect(object oPC)
{
	int i;
	string str = "The feeling of euphoria has still not abated, leaving you giddy.";

	SendMessageToPC(oPC, "A feeling of intense euphoria overcomes you after consuming the narcotic.");

	// spam messages of euphoria
	for (i = 5; i <= 60; i += 5) {
		AssignCommand(oPC, DelayCommand(TurnsToSeconds(i), SendMessageToPC(oPC, str)));
	}
}

void drug_overdose_effect(object oPC)
{
	// Cause unconsciousness if a fort save is failed
	SendMessageToPC(oPC, "As you consume the substance it overwhelms you and you fall unconscious.");
	ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_BLOOD_REG_RED), oPC);
	PlayCustomAnimation(oPC, "proneb", 1);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ExtraordinaryEffect(EffectSleep()), oPC, 360.0f);
	AssignCommand(oPC, DelayCommand(30.0f, SetCommandable(TRUE, oPC)));
	SetCommandable(FALSE, oPC);
}

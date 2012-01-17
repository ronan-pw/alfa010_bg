#define FLOAT_RANGE_SHORT 3.0f

void main()
{
	object oPC  = GetItemActivator();
	object oTarget = GetItemActivatedTarget();
	string sMsg;

	if (oTarget == oPC) {
		SendMessageToPC(oPC, "You can't use it on yourself.");
		return;
	}
	
	if (GetDistanceBetween(oPC,oTarget) > FLOAT_RANGE_SHORT) {
		SendMessageToPC(oPC, "You're too far away.");
		return;
	}

	if (!GetIsFriend(oPC,oTarget)) {
		SendMessageToPC(oPC, "You can only use it on a willing target.");
		return;
	}

	AssignCommand(oPC, ActionSpeakString("*begins drilling a hole into the head of "+GetName(oTarget)+"*"));

	int iDrill = d100() + GetSkillRank(SKILL_HEAL,oPC);
	if (iDrill <= 10)
	{
		sMsg = "I drilled too far!";
		ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(TRUE,FALSE),oTarget);
	}
	else if ((iDrill > 10) && (iDrill <= 40))
	{
		sMsg = "Oh no!  I caused brain damage!";
		ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectAbilityDecrease(ABILITY_INTELLIGENCE,2),oTarget);
	}
	else if ((iDrill > 40) && (iDrill <= 70))
	{
		sMsg = "Oh no!  I caused brain damage!";
		ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectAbilityDecrease(ABILITY_INTELLIGENCE,1),oTarget);
	}
	else if ((iDrill > 70) && (iDrill <= 95))
	{
		sMsg = "That didn't seem to help.";
	}
	else if (iDrill > 95)
	{
		sMsg = "It worked!";
		effect eEffect = GetFirstEffect(oTarget);

		while (GetIsEffectValid(eEffect))
		{
			if (GetEffectType(eEffect) == EFFECT_TYPE_CONFUSED)
				RemoveEffect(oTarget, eEffect);
			else if (GetEffectType(eEffect) == EFFECT_TYPE_CHARMED)
				RemoveEffect(oTarget, eEffect);
			else if (GetEffectType(eEffect) == EFFECT_TYPE_DOMINATED)
				RemoveEffect(oTarget, eEffect);
			else if (GetEffectType(eEffect) == EFFECT_TYPE_FRIGHTENED)
				RemoveEffect(oTarget, eEffect);

			eEffect = GetNextEffect(oTarget);
		}
	}

	AssignCommand(oPC, ActionSpeakString(sMsg));
}

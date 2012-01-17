#define FLOAT_RANGE_SHORT 3.0f

void main()
{
	object oPC  = GetItemActivator();
	object oTarget = GetItemActivatedTarget();
	string sMsg = "They worked!";

	if (oTarget == oPC)
	{
		SendMessageToPC(oPC, "You can't use it on yourself.");
		return;
	}

	if ((GetDistanceBetween(oPC,oTarget) > FLOAT_RANGE_SHORT))
	{
		SendMessageToPC(oPC, "You're too far away.");
		return;
	}

	if (!GetIsFriend(oPC,oTarget))
	{
		SendMessageToPC(oPC, "You can only use it on a willing target.");
		return;
	}

	AssignCommand(oPC, ActionSpeakString("*uses a surgical kit on "+GetName(oTarget)+"*"));

	int iCut = d100() + GetSkillRank(SKILL_HEAL,oPC);

	if (iCut <= 20)
	{
		sMsg = "I cut something important!";

		ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(TRUE,FALSE),oTarget);
	}
	else if (20 < iCut <= 70)
	{
		sMsg = "I did something wrong . . .";

		ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d10(),DAMAGE_TYPE_PIERCING),oTarget);
	}
	else if(70 < iCut <= 80)
	{
		sMsg = "That helped a little.";

		effect eEffect = GetFirstEffect(oTarget);

		while (GetIsEffectValid(eEffect))
		{
			if (GetEffectType(eEffect) == EFFECT_TYPE_DISEASE)
				RemoveEffect(oTarget, eEffect);
			else if (GetEffectType(eEffect) == EFFECT_TYPE_POISON)
				RemoveEffect(oTarget, eEffect);

			eEffect = GetNextEffect(oTarget);
		}
	}
	else if(80 < iCut <= 95)
	{
		sMsg = "It worked, I think.";

		ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(d10()),oTarget);
		effect eEffect = GetFirstEffect(oTarget);

		while (GetIsEffectValid(eEffect))
		{
			if (GetEffectType(eEffect) == EFFECT_TYPE_DISEASE)
				RemoveEffect(oTarget, eEffect);
			else if (GetEffectType(eEffect) == EFFECT_TYPE_POISON)
				RemoveEffect(oTarget, eEffect);

			eEffect = GetNextEffect(oTarget);
		}
	}
	else if(iCut > 95)
	{
		sMsg = "Outstanding!";
		effect eEffect = GetFirstEffect(oTarget);

		while (GetIsEffectValid(eEffect))
		{
			if (GetEffectType(eEffect) == EFFECT_TYPE_DISEASE)
				RemoveEffect(oTarget, eEffect);
			else if (GetEffectType(eEffect) == EFFECT_TYPE_POISON)
				RemoveEffect(oTarget, eEffect);

			eEffect = GetNextEffect(oTarget);
		}

		ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oTarget)-GetCurrentHitPoints(oTarget)),oTarget);
	}

	AssignCommand(oPC, ActionSpeakString(sMsg));
}

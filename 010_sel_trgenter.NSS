void main()
{
	object oPC = GetEnteringObject();
	int nSkill1 = GetLocalInt(OBJECT_SELF, "TRG_SKILL_NUMBER_1");
	int nSkill2 = GetLocalInt(OBJECT_SELF, "TRG_SKILL_NUMBER_2");
	int nSkill3 = GetLocalInt(OBJECT_SELF, "TRG_SKILL_NUMBER_3");
	int nSkill4 = GetLocalInt(OBJECT_SELF, "TRG_SKILL_NUMBER_4");
	int nSkill5 = GetLocalInt(OBJECT_SELF, "TRG_SKILL_NUMBER_5");
	int nBonus  = GetLocalInt(OBJECT_SELF, "TRG_SKILL_BONUS");
	
	if(nSkill1)
		ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectSkillIncrease(nSkill1, nBonus)), oPC);
	if(nSkill2)
		ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectSkillIncrease(nSkill2, nBonus)), oPC);
	if(nSkill3)
		ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectSkillIncrease(nSkill3, nBonus)), oPC);
	if(nSkill4)
		ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectSkillIncrease(nSkill4, nBonus)), oPC);
	if(nSkill5)
		ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectSkillIncrease(nSkill5, nBonus)), oPC);
}
void main()
{
	object o = GetPCSpeaker();
	
	int check = d20() + GetSkillRank(SKILL_SPOT, o);
	
	if (check >= 20) {
		SetGlobalInt("sinkhole_rope_bad",0);
		SetGlobalInt("sinkhole_rope_fix",1);
	}
}
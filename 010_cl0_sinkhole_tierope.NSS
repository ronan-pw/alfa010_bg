#include "acr_i"

void main()
{
	object o = GetPCSpeaker();
	
	int check = d20() + GetSkillRank(SKILL_USE_ROPE, o);
	
	SetGlobalInt("sinkhole_rope",1);
	
	if (check < 15)
		SetGlobalInt("sinkhole_rope_bad",1);
}
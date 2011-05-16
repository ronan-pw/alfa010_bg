void main(int type)
{
	object o = GetPCSpeaker();
	int check = GetSkillRank(SKILL_TUMBLE, o);
	int damage = d6(2);
	int tumbled = 0;
	
	if ((check > 0) && (d20() + check >= 15))
		tumbled = 1;
		
	switch (type) {
		case 1:
			DelayCommand(2.5,AssignCommand(o,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(damage,DAMAGE_TYPE_BLUDGEONING),o)));
			break;
		case 2:
			if (tumbled)
				damage = d6(8);
			else
				damage = d6(10);
				
			DelayCommand(2.5,AssignCommand(o,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(damage,DAMAGE_TYPE_BLUDGEONING),o)));
			break;
		case 3:
			if (tumbled)
				damage = d6(8);
			else
				damage = d6(10);
				
			DelayCommand(2.5,AssignCommand(o,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(damage,DAMAGE_TYPE_BLUDGEONING),o)));
			SetGlobalInt("sinkhole_rope",0);
			SetGlobalInt("sinkhole_rope_bad",0);
			break;
	}
	DelayCommand(0.5,AssignCommand(o,ActionJumpToObject(GetWaypointByTag("WP_SINKHOLE_BOTTOM"))));
}
void main()
{
	object PCclick;
	object resval;
	
	PCclick = GetLastUsedBy();

	if (GetSkillRank(SKILL_SPELLCRAFT, PCclick, TRUE) < 6 && GetSkillRank(SKILL_SURVIVAL, PCclick, TRUE) < 11)
	{
		SendMessageToPC(PCclick,"You peer around at the moss but find nothing worth salvaging.");
		return;
	}
	
	resval = CreateItemOnObject("pmoss",PCclick);
		
	if (!GetIsObjectValid(resval)) 
		SpeakOneLinerConversation("Fsck, invalid item");
	
	DestroyObject(OBJECT_SELF);
}
void main()
{
	object PCclick;
	object resval;
	
	PCclick = GetLastUsedBy();

	if (GetSkillRank(SKILL_HEAL, PCclick, TRUE) < 2 && GetSkillRank(SKILL_SURVIVAL, PCclick, TRUE) < 2)
	{
		SendMessageToPC(PCclick, "This mushroom's cap looks rather peculiar.  But you can't see anything worthwhile to harvest.");
		return;
	}
	
	resval = CreateItemOnObject("magmush",PCclick);
		
	if (!GetIsObjectValid(resval)) 
		SpeakOneLinerConversation("Fsck, invalid item");

	DestroyObject(OBJECT_SELF);
}
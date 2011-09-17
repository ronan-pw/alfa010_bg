void main()
{
	object PCclick;
	object resval;
	
	PCclick = GetLastUsedBy();

	if (GetSkillRank(SKILL_SPELLCRAFT, PCclick, TRUE) < 3 && GetSkillRank(SKILL_SURVIVAL, PCclick, TRUE) < 3)
	{
		SendMessageToPC(PCclick,"You reach around in the guano but find nothing worth salvaging, instead just getting a smelly hand.");
		return;
	}
	
	resval = CreateItemOnObject("batguano",PCclick);
		
	if (!GetIsObjectValid(resval)) 
		SpeakOneLinerConversation("Fsck, invalid item");
	
	DestroyObject(OBJECT_SELF);
}
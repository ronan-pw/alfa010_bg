void main()
{
	object PCclick;
	object resval;
	
	PCclick = GetLastUsedBy();

	if (GetSkillRank(SKILL_HEAL, PCclick, TRUE) < 7 && GetSkillRank(SKILL_SURVIVAL, PCclick, TRUE) < 7)
	{
		SendMessageToPC(PCclick,"This odd plant has remarkably distinctive leaves.  But you can't see anything worthwhile to harvest.");
		return;
	}
	
	resval = CreateItemOnObject("it_cassil",PCclick);
		
	if (!GetIsObjectValid(resval)) 
		SpeakOneLinerConversation("Fsck, invalid item");

	DestroyObject(OBJECT_SELF);
}
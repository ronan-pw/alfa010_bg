void main()
{
	object PCclick;
	object resval;
	
	PCclick = GetLastUsedBy();

	if (GetSkillRank(SKILL_HEAL, PCclick, TRUE) < 4 && GetSkillRank(SKILL_SURVIVAL, PCclick, TRUE) < 4)
	{
		SendMessageToPC(PCclick,"This odd plant almost feels warm to the touch.  But you can't see anything worthwhile to harvest.");
		return;
	}
	
	resval = CreateItemOnObject("firefernfrond",PCclick);
		
	if (!GetIsObjectValid(resval)) 
		SpeakOneLinerConversation("Fsck, invalid item");
		
	DestroyObject(OBJECT_SELF);
}
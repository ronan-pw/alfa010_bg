void main()
{
object PCclick;

PCclick = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);

if(GetDistanceToObject(PCclick) > 2.0) return;

if(GetSkillRank(SKILL_HEAL, PCclick, TRUE) >= 7 || GetSkillRank(SKILL_SURVIVAL, PCclick, TRUE) >= 7){
  if(CreateItemOnObject("it_cassil",PCclick) == OBJECT_INVALID) 
    SpeakOneLinerConversation("Fsck, invalid item");
  DestroyObject(OBJECT_SELF);
}
else SendMessageToPC(PCclick,"This odd plant has remarkably distinctive leaves.  But you can't see anything worthwhile to harvest.");

}
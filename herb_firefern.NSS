void main()
{
object PCclick;

PCclick = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);

if(GetDistanceToObject(PCclick) > 2.0) return;

if(GetSkillRank(SKILL_HEAL, PCclick, TRUE) >= 4 || GetSkillRank(SKILL_SURVIVAL, PCclick, TRUE) >= 4){
  if(CreateItemOnObject("firefernfrond",PCclick) == OBJECT_INVALID) 
    SpeakOneLinerConversation("Fsck, invalid item");
  DestroyObject(OBJECT_SELF);
}
else SendMessageToPC(PCclick, "This odd plant almost feels warm to the touch.  But you can't see anything worthwhile to harvest.");
//GetClickingObject()

}
void main()
{
object PCclick;

PCclick = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);

if(GetDistanceToObject(PCclick) > 2.0) return;

if(GetSkillRank(SKILL_HEAL, PCclick, TRUE) >= 2 || GetSkillRank(SKILL_SURVIVAL, PCclick, TRUE) >= 2){
  if(CreateItemOnObject("magmush",PCclick) == OBJECT_INVALID) 
    SpeakOneLinerConversation("Fsck, invalid item");
  DestroyObject(OBJECT_SELF);
}
else SendMessageToPC(PCclick, "This mushroom's cap looks rather peculiar.  But you can't see anything worthwhile to harvest.");
//GetClickingObject()

}
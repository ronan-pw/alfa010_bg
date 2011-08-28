void main()
{
object PCclick;

PCclick = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);

if(GetDistanceToObject(PCclick) > 2.0) return;

if(GetSkillRank(SKILL_SPELLCRAFT, PCclick, TRUE) >= 6 || GetSkillRank(SKILL_SURVIVAL, PCclick, TRUE) >= 11){
  if(CreateItemOnObject("pmoss",PCclick) == OBJECT_INVALID) 
    SpeakOneLinerConversation("Fsck, invalid item");
  DestroyObject(OBJECT_SELF);
}
else SendMessageToPC(PCclick,"You peer around at the moss but find nothing worth salvaging.");
//GetClickingObject()

}
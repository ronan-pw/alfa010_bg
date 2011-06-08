void main()
{
object PCclick;

PCclick = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);

if(GetDistanceToObject(PCclick) > 2.0) return;

if(GetSkillRank(SKILL_SPELLCRAFT, PCclick, TRUE) >= 8 || GetSkillRank(SKILL_SURVIVAL, PCclick, TRUE) >= 13){
  if(CreateItemOnObject("it_sulfur",PCclick) == OBJECT_INVALID) 
    SpeakOneLinerConversation("Fsck, invalid item");
  DestroyObject(OBJECT_SELF);
}
else SendMessageToPC(PCclick,"You examine the hunk of material but find nothing worth salvaging.");
//GetClickingObject()

}
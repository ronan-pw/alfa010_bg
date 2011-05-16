void main()
{
object PCclick;

PCclick = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);

if(GetDistanceToObject(PCclick) > 2.0) return;

if(GetSkillRank(SKILL_SPELLCRAFT, PCclick, TRUE) >= 5){
  if(CreateItemOnObject("batguano",PCclick) == OBJECT_INVALID) 
    SpeakOneLinerConversation("Fsck, invalid item");
  DestroyObject(OBJECT_SELF);
}
//else SpeakOneLinerConversation("This odd plant almost feels warm to the touch.");
//GetClickingObject()

}
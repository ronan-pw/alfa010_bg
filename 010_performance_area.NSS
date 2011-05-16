void main()
{
object oPC=GetEnteringObject();

if(GetIsPC(oPC) && GetHasFeat(FEAT_BARD_SONGS,oPC,FALSE)){
    ActionStartConversation(oPC,"010_perform",TRUE);

  }
  
}  
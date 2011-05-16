#include "acr_xp_i"

void main()
{
 object oPC = (GetPCSpeaker()==OBJECT_INVALID?OBJECT_SELF:GetPCSpeaker());
 int luck = d20(1);
 int scratch = 0;
 
 if(GetHitDice(oPC) > 5){
   SendMessageToPC(oPC, "You don't feel performing here is helping you grow at all.");
   return;
 }
 
 
 if(luck == 1){
   ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(1), oPC, 50.0);//do damage
   SendMessageToPC(oPC, "You really botch the performance.");
   scratch = d6(GetHitDice(oPC)) * -2;
   ACR_AwardStaticQuestXP(oPC,"Bard Loss",scratch);
 }
 else if((luck + GetSkillRank(SKILL_PERFORM,oPC,FALSE)) >= 15){
   scratch = d3(1);
   ACR_AwardStaticQuestXP(oPC,"Bard",scratch);
   GiveGoldToCreature(oPC,scratch);
 }
 
  
}  
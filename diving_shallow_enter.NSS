void main()
{
object oPC=GetEnteringObject();
object oFlag=GetObjectByTag("diveflag");
location flagloc = GetLocation(oFlag);
int randflag = 0;

effect eBlind =  EffectBlindness();


effect eDeaf = EffectDeaf();
effect eVis = EffectVisualEffect(VFX_DUR_DARKNESS);

effect eLink = EffectLinkEffects(eBlind, eDeaf);
eLink = EffectLinkEffects(eLink, eVis);
if(GetIsPC(oPC)){
  if(GetWeight(oPC)>=300) {
    SendMessageToPC(oPC, "You are carrying too much to get into the water"); 
    AssignCommand(oPC, JumpToLocation(flagloc));
  }
  else{
    if(GetTag(GetItemInSlot(INVENTORY_SLOT_HEAD,oPC))!="goggles"){
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, 50.00);
    }
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSlow(), oPC, 50.0);
  
    randflag = Random(100);

  if(randflag <= 50){
	 ;
  }
  else if ((randflag <= 55) && (randflag > 50)){
    if(GetSkillRank(SKILL_HEAL, oPC, TRUE) >= 5 || GetSkillRank(SKILL_SURVIVAL, oPC, TRUE) >= 4){
	  if(d20(1) + GetSkillRank(SKILL_SPOT,oPC,FALSE) > 10){
        SendMessageToPC(oPC, "You find some suitable seaweed.");
        if(CreateItemOnObject("seaweed",oPC) == OBJECT_INVALID) SpeakOneLinerConversation("Fsck, invalid item");
      }
	}
    
  }
  else if ((randflag <= 60) && (randflag > 55)){
    CreateObject(OBJECT_TYPE_CREATURE,"cr_dcrab",GetLocation(oPC));
	SendMessageToPC(oPC, "A crab leaps out from the bottom silt"); 
	//crab 
  }
  else if ((randflag <= 65) && (randflag > 60)){
    if(d20(1) + GetSkillRank(SKILL_SPOT,oPC,FALSE) > 15){
      if(CreateItemOnObject("it_scallop",oPC) == OBJECT_INVALID) SpeakOneLinerConversation("Fsck, invalid item");
      SendMessageToPC(oPC, "You find a scallop!");
	}
    //scallop
  }
  else if ((randflag <= 85) && (randflag > 65)){
    if(GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC))=="010_it_oceanspear"){
  
      if(ReflexSave(oPC, 12, SAVING_THROW_TYPE_NONE, GetAreaOfEffectCreator())== 0){
        SendMessageToPC(oPC, "You see a large fish, but he gets away.");
      }
	  else{
	 
	  if(CreateItemOnObject("it_fish",oPC) == OBJECT_INVALID) SpeakOneLinerConversation("Fsck, invalid item");
	  SendMessageToPC(oPC, "You spear a large fish!");
      }
	}
	else SendMessageToPC(oPC, "You see a large fish, but have no way to get him.");
	
	
  }
  else if ((randflag <= 98) && (randflag > 85)){
   if(FortitudeSave(oPC, 12, SAVING_THROW_TYPE_NONE, GetAreaOfEffectCreator())== 0){
	  ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(2), oPC, 50.0);//do damage
      SendMessageToPC(oPC, "A large wave sends you reeling;");
      }
   else SendMessageToPC(oPC, "You weather a large wave.");
  //strong wave fort save for extra damage    
  }
  else if ((randflag == 99)){
  
       switch( d10(1))
         {
                    case 1: CreateItemOnObject("cft_gem_pearl",oPC); 
					        SendMessageToPC(oPC, "You find a pearl!"); 
							break;
                    case 2: CreateObject(OBJECT_TYPE_CREATURE,"cr_croc",GetLocation(oPC));
							SendMessageToPC(oPC, "A crocomonster leaps from the sea.");
							break;
					
                    case 3: CreateObject(OBJECT_TYPE_CREATURE,"c_elmwaterlarge",GetLocation(oPC));
							SendMessageToPC(oPC, "An elemental forms from the sea.");
							break;
         } 
    //Water elemental
	//pearl cft_gem_pearl
	//Sea Monster
	//Salt Water Croc
  }
  
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(1), oPC, 50.0);//do damage
    SendMessageToPC(oPC, "The cold, motion, and swell of the water wears on you.");
  
  
  

  }
  
}  
}
#include "010_swim_i"

void main()
{
	object oPC=GetEnteringObject();
	int randflag = 0;

	if (!enter_water(oPC,1))
		return;
	
	    randflag = Random(100);
	
	  if(randflag <= 37){
		 ;
	  }
	 else if (randflag <= 40) {
		CreateItemOnObject("abr_it_gem_063",oPC); 
		SendMessageToPC(oPC, "You find a small pearl."); 
	 }
	  else if (randflag <= 50){
	    if(GetSkillRank(SKILL_HEAL, oPC, TRUE) >= 5 || GetSkillRank(SKILL_SURVIVAL, oPC, TRUE) >= 4){
		  if(d20(1) + GetSkillRank(SKILL_SPOT,oPC,FALSE) > 10){
	        SendMessageToPC(oPC, "You find some suitable seaweed.");
	        if(CreateItemOnObject("seaweed",oPC) == OBJECT_INVALID) SpeakOneLinerConversation("Fsck, invalid item");
	      }
		}
	  }
	  else if (randflag <= 60){
	    CreateObject(OBJECT_TYPE_CREATURE,"010_cr_an_dcrab",GetLocation(oPC));
		SendMessageToPC(oPC, "A crab leaps out from the bottom silt"); 
		//crab 
	  }
	  else if (randflag <= 70){
	    if(d20(1) + GetSkillRank(SKILL_SPOT,oPC,FALSE) > 15){
	      if(CreateItemOnObject("it_scallop",oPC) == OBJECT_INVALID) SpeakOneLinerConversation("Fsck, invalid item");
	      SendMessageToPC(oPC, "You find a scallop!");
		}
	  }
	  else if (randflag <= 80){
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
	  else if (randflag <= 98){
	   if(FortitudeSave(oPC, 15, SAVING_THROW_TYPE_NONE, GetAreaOfEffectCreator())== 0){
		  ACR_ApplyNonlethalDamageToCreature(oPC, d6());
	      SendMessageToPC(oPC, "A large wave sends you reeling;");
	      }
	   else SendMessageToPC(oPC, "You weather a large wave.");
	  //strong wave fort save for extra damage    
	  }
	  else if (randflag == 99){
	  
		       switch( Random(7))
		         {
			                    case 0: CreateItemOnObject("cft_gem_pearl",oPC); 
								        SendMessageToPC(oPC, "You find a magnificant pearl!"); 
										break;
			                    case 1: CreateObject(OBJECT_TYPE_CREATURE,"abr_cr_hu_kuotoa_crazed",GetLocation(oPC));
										SendMessageToPC(oPC, "A sea monster leaps upon you!");
										break;
								
			                    case 2: CreateObject(OBJECT_TYPE_CREATURE,"010_cr_elementalwater1",GetLocation(oPC));
										SendMessageToPC(oPC, "An elemental forms from the sea.");
										break;
			                    case 3:
			                    case 4:
						CreateItemOnObject("abr_it_gem_078",oPC); 
						SendMessageToPC(oPC, "You find a fine pearl!"); 
										break;
		         } 
	    //Water elemental
		//pearl cft_gem_pearl
		//Sea Monster
		//Salt Water Croc
	  }
}

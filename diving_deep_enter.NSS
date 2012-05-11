#include "010_swim_i"

void main()
{
	object oPC=GetEnteringObject();
	int randflag = 0;

	if (!enter_water(oPC,2))
		return;
	
	    randflag = Random(100);
	
	  if(randflag <= 15){
		 ;
	  }
	  else if ((randflag <= 30) && (randflag > 15)){
	    if(GetSkillRank(SKILL_HEAL, oPC, TRUE) >= 5 || GetSkillRank(SKILL_SURVIVAL, oPC, TRUE) >= 4){
		  if(d20(1) + GetSkillRank(SKILL_SPOT,oPC,FALSE) > 10){
	        SendMessageToPC(oPC, "You find some suitable seaweed.");
	        if(CreateItemOnObject("seaweed",oPC) == OBJECT_INVALID) SpeakOneLinerConversation("Fsck, invalid item");
	      }
		}
	  }
	  else if ((randflag <= 45) && (randflag > 30)){
	    CreateObject(OBJECT_TYPE_CREATURE,"010_cr_an_dcrab",GetLocation(oPC));
		SendMessageToPC(oPC, "A crab leaps out from the bottom silt"); 
		//crab 
	  }
	  else if ((randflag <= 60) && (randflag > 45)){
	    if(d20(1) + GetSkillRank(SKILL_SPOT,oPC,FALSE) > 15){
	      if(CreateItemOnObject("it_scallop",oPC) == OBJECT_INVALID) SpeakOneLinerConversation("Fsck, invalid item");
	      SendMessageToPC(oPC, "You find a scallop!");
		}
	  }
	  else if ((randflag <= 70) && (randflag > 60)){
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
	  else if ((randflag <= 98) && (randflag > 70)){
	   if(FortitudeSave(oPC, 20, SAVING_THROW_TYPE_NONE, GetAreaOfEffectCreator())== 0){
	   	  ACR_ApplyNonlethalDamageToCreature(oPC, d6());
	      SendMessageToPC(oPC, "A large wave sends you reeling;");
	      }
	   else SendMessageToPC(oPC, "You weather a large wave.");
	  //strong wave fort save for extra damage    
	  }
	  else if ((randflag == 99)){
	  
	       switch( Random(6))
	         {
			   case 0:
				CreateItemOnObject("cft_gem_pearl",oPC); 
				SendMessageToPC(oPC, "You find a magnificant pearl!"); 
								break;
	                    case 3:
	                    case 4:
								CreateItemOnObject("abr_it_gem_078",oPC); 
								SendMessageToPC(oPC, "You find a fine pearl!"); 
								break;
	                    case 2: CreateObject(OBJECT_TYPE_CREATURE,"abr_cr_gt_troll_saltwater",GetLocation(oPC));
								SendMessageToPC(oPC, "An enormous troll emerges from the depths.");
								break;
						
	                    case 3: CreateObject(OBJECT_TYPE_CREATURE,"010_cr_elementalwater1",GetLocation(oPC));
								SendMessageToPC(oPC, "An elemental forms from the sea.");
								break;
	
						case 4: CreateObject(OBJECT_TYPE_CREATURE,"abr_cr_hu_kuotoa_crazed",GetLocation(oPC));
								SendMessageToPC(oPC, "A seamonster leaps upon you!");
								break;
			} 
			 
	  }
	  
}

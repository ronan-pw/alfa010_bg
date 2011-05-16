//
// Spawn Flags
//
void SpawnFlags(object oSpawn, int nFlagTableNumber)
{
    // Initialize Values
    string sSpawnName = GetLocalString(oSpawn, "f_Flags");
    string sSpawnTag = GetLocalString(oSpawn, "f_Template");
    string sFlags, sTemplate;
	int randflag = 0;

//
// Only Make Modifications Between These Lines
// -------------------------------------------


    // Sample Complex Replacement
    // Using FT without FT00 will
    // Default to nFlagTableNumber 0
    if (nFlagTableNumber == 0)
    {
        // Old Method of using SpawnTag
        if (sSpawnTag == "myspawns")
        {
            sFlags = "SP_SN02_SA_RW";
            sTemplate = "NW_DOG";
        }

        if (sSpawnTag == "undead")
        {
            sFlags = "SP_SNO4";
            sTemplate = "NW_ZOMBIE01";
        }
    }
    //

    // Sample Simple Replacement Flag
    // Completely Replaces Flags
    // On Spawnpoints with FT01
    if (nFlagTableNumber == 1)
    {
        sFlags = "SP_SN04_RW_DOD";
        sTemplate = "NW_DOG";
    }
    //

    // Sample Template Flags
    // These Flags Get Added
    // To Spawnpoints with FT02
    if (nFlagTableNumber == 2)
    {
        sFlags = "_RW_PC05R";
    }
    //

	if (nFlagTableNumber == 3)
    {
	    //sFlags = "SP_SN03";
        sFlags = "SP_SN03_SA_SG_CD120T3_SD200_IS1D0_RS50_DS2_PC5_RW_RHD50";
        sTemplate = "mgoblins";
    }
	
	if (nFlagTableNumber == 4)  //static fun of herbs and corpses for open spaces
    {
  
	    sFlags = "SP_SN01_SA_PL3_SD200";
        randflag = Random(20);
		if(randflag <= 3)
		  sTemplate = "firefern";
        else if (randflag <= 5)
		  sTemplate = "magpiemushroom";
		else if (randflag <= 6) 
		  sTemplate = "corpse1";
	    
		
	}
	
	if (nFlagTableNumber == 5)
    {
	    //sFlags = "SP_SN03";
        sFlags = "SP_SN03_SA_SG_CD120T3_SD200_IS1D0_RS50_DS2_PC5_RW_RHD50_NOD";  //Night only spawns for road
        randflag = Random(6);
		if(randflag == 1)
		  sTemplate = "mgoblins";
		else if(randflag == 2)
		  sTemplate = "RazorClanGnolls";
		else if(randflag == 3 )
		  sTemplate = "spiders_easy";
		else if(randflag == 4 )
		  sTemplate = "wolves";
		else if(randflag == 5 )
		  sTemplate = "undead_easy";
		
		
    }	
	
	if (nFlagTableNumber == 6)
    {
	    //sFlags = "SP_SN03";
        sFlags = "SP_SN03_SA_SG_CD120T3_SD200_IS1D0_RS50_DS2_PC5_RW_RHD50";
        sTemplate = "ratsnbats";
    }

	if (nFlagTableNumber == 7)  //static fun of herbs and corpses for closed spaces
    {
  
	    sFlags = "SP_SN01_SA_PL3_SD200";
        randflag = Random(15);
		if(randflag <= 2)
		  sTemplate = "magpiemushroom";
        else if (randflag <= 4)
		  sTemplate = "magpiemushroom";
		else if (randflag <=5 ) 
		  sTemplate = "corpse1";
	    else if (randflag ==9 ) 
		  sTemplate = "batguanopile";
		
	}
	
	if (nFlagTableNumber == 8)  //static fun of herbs and corpses and chests for closed spaces
    {
  
	    //sFlags = "SP_SN01_SA_PL3T70_SD200_LT0";
		
		
        randflag = Random(15);
		if(randflag <= 2){
		  sTemplate = "magpiemushroom";
		  sFlags = "SP_SN01_SA_PL3_SD200";
		  }
        else if (randflag <= 4){
		  sTemplate = "magpiemushroom";
		  sFlags = "SP_SN01_SA_PL3_SD200";
		  }
		else if (randflag <=5 ){
		  sFlags = "SP_SN01_SA_PL3_SD200";
		  sTemplate = "corpse1";
	    }
		else if (randflag <=7 ){ 
		  sFlags = "SP_SN01_SA_PL3_SD200";
		  sTemplate = "batguanopile";
		}
		else if (randflag <=9){
		  sFlags = "SP_SN01_SA_PL3T70_SD200_LT0";
		  sTemplate = "plc_chest_low";
		}
	}
	
	if (nFlagTableNumber == 9)
    {
	    //sFlags = "SP_SN03";
 		sFlags = "SP_SN03_SA_SG_CD120T3_SD200_IS1D0_RS50_DS2_PC5_RW_RHD50";
        sTemplate = "mgoblins_med";
    }
	
	if (nFlagTableNumber == 10)
    {
	    //sFlags = "SP_SN03";
 		sFlags = "SP_SN03_SA_SG_CD120T3_SD200_IS1D0_RS50_DS2_PC5_RW_RHD50";
		
        sTemplate = "undead_easy";
    }
	
	if (nFlagTableNumber == 11)  //static fun of herbs and corpses and chests for closed spaces
    {
  
	    //sFlags = "SP_SN01_SA_PL3T70_SD200_LT0";
		
		
        randflag = Random(15);
		if(randflag <= 2){
		  sTemplate = "plc_sarc_low";
		  sFlags = "SP_SN01_SA_PL3_SD200_LT0";
		  }
        else if (randflag <= 4){
		  sTemplate = "plc_sarc_low";
		  sFlags = "SP_SN01_SA_PL3_SD200_LT0";
		  }
		else if (randflag <=5 ){
		  sFlags = "SP_SN01_SA_PL3_SD200";
		  sTemplate = "corpse1";
	    }
		else if (randflag <=7 ){ 
		  sFlags = "SP_SN01_SA_PL3_SD200";
		  sTemplate = "batguanopile";
		}
		else if (randflag <=12){
		  sFlags = "SP_SN01_SA_PL3T70_SD200_LT0";
		  sTemplate = "plc_chest_low";
		}
	}
	
	if (nFlagTableNumber == 12)
    {
	    //sFlags = "SP_SN03";
        sFlags = "SP_SN03_SA_SG_CD120T3_SD200_IS1D0_RS50_DS2_PC5_RW_RHD50";  //All time spawns for Cloakwood
        randflag = Random(8);
		if(randflag == 1)
		  sTemplate = "mgoblins";
		else if(randflag == 2)
		  sTemplate = "RazorClanGnolls";
		else if(randflag == 3 )
		  sTemplate = "spiders_easy";
		else if(randflag == 4 )
		  sTemplate = "wolves";
		else if(randflag == 5 )
		  sTemplate = "undead_easy";
		else if(randflag >= 6 )
		  sTemplate = "spiders_easy";
				
    }
	
	if (nFlagTableNumber == 13)
    {
	    //sFlags = "SP_SN03";
        sFlags = "SP_SN03_SA_SG_CD120T3_SD200_IS1D0_RS50_DS2_PC5_RW_RHD50_NOD";  //Night only spawns for cloakwood
        randflag = Random(9);
		if(randflag == 1)
		  sTemplate = "vermin";
		else if(randflag == 2)
		  sTemplate = "ogres";
		else if(randflag == 3 )
		  sTemplate = "necrotaur";
		else if(randflag == 4 )
		  sTemplate = "monk";
		else if(randflag == 5 )
		  sTemplate = "sandmurk";
		else if(randflag == 6 )
		  sTemplate = "vermin";		
		
    }
	
	
	if (nFlagTableNumber == 14)  //static fun of herbs and corpses and chest sfor closed spaces
    {
  

        randflag = Random(15);

		if(randflag <= 2){
		  sTemplate = "magpiemushroom";
		  sFlags = "SP_SN01_SA_PL3_SD200";
		  }
		else if (randflag <=5 ){
		  sFlags = "SP_SN01_SA_PL3_SD200";
		  sTemplate = "corpse1";
	    }
		else if (randflag <=9 ){ 
		  sFlags = "SP_SN01_SA_PL3_SD200";
		  sTemplate = "pmosspatch";
		}

	}
	
	if (nFlagTableNumber == 15)
    {
	    //sFlags = "SP_SN03";
        sFlags = "SP_SN01_SA_SG_CD120T3_SD200_IS1D0_RS50_DS2_PC5_RW_RHD50";
        sTemplate = "RazorClanGnolls";
    }
	
	if (nFlagTableNumber == 16)
    {
	    //sFlags = "SP_SN03";
        sFlags = "SP_SN02_SA_SG_CD120T3_SD200_IS1D0_RS50_DS2_PC5_RW_RHD50";
		randflag = Random(15);
		if(randflag <= 7){
		  sTemplate = "spiders_easy";
		}
        else sTemplate = "Doombug";
    }
	
	if (nFlagTableNumber == 17)  //static fun of herbs and corpses and chests for closed spaces
    {
  
	    //sFlags = "SP_SN01_SA_PL3T70_SD200_LT0";
		
		
        randflag = Random(15);
		if(randflag <= 2){
		  sTemplate = "magpiemushroom";
		  sFlags = "SP_SN01_SA_PL3_SD200";
		  }
        else if (randflag <= 4){
		  sTemplate = "pmosspatch";
		  sFlags = "SP_SN01_SA_PL3_SD200";
		  }
		else if (randflag <=5 ){
		  sFlags = "SP_SN01_SA_PL3_SD200";
		  sTemplate = "corpse1";
	    }
		else if (randflag <=7 ){ 
		  sFlags = "SP_SN01_SA_PL3_SD200";
		  sTemplate = "pmosspatch";
		}
		else if (randflag <=9){
		  sFlags = "SP_SN01_SA_PL3T70_SD200_LT0";
		  sTemplate = "plc_chest_low";
		}
	}
	if (nFlagTableNumber == 18)  //smugglers for Seacave
    {
  
	    //sFlags = "SP_SN01_SA_PL3T70_SD200_LT0";	
		
        sFlags = "SP_SN03_SA_SG_CD120T3_SD200_IS1D0_RS50_DS2_PC5_RW_RHD50";
        sTemplate = "smuggler";
	}
	
	if (nFlagTableNumber == 19)  //static fun of nicer herbs, components, and corpses for open spaces
    {
  
	    sFlags = "SP_SN02_SA_PL3_SD200_SR50M5";
        randflag = Random(6);
		if(randflag <= 3)
		  sTemplate = "pl_cassil";
        else if (randflag <= 5)
		  sTemplate = "pl_sulfur";
		else sTemplate = "corpse1";
	 
		
	}
		
	if (nFlagTableNumber == 20)  //static fun of baddies dragon style
    {
  
	  sFlags = "SP_SN01_SA_SG_CD120T3_SD200_IS1D0_RS50_DS2_PC5_RW_RHD50";
      sTemplate = "draco";
	 
		
	}
	
	if (nFlagTableNumber == 21)
    {
	    //sFlags = "SP_SN03";
 		sFlags = "SP_SN03_SA_SG_CD120T3_SD200_IS1D0_RS50_DS2_PC5_RW_RHD50";
		
        sTemplate = "undead_mid";
    }
	
	if (nFlagTableNumber == 22)  //static fun of herbs and corpses and chests for closed spaces
    {
  
	    //sFlags = "SP_SN01_SA_PL3T70_SD200_LT0";
		
		
        randflag = Random(15);
		if(randflag <= 2){
		  sTemplate = "plc_sarc_mid";
		  sFlags = "SP_SN01_SA_PL3_SD200_LT1";
		  }
        else if (randflag <= 4){
		  sTemplate = "plc_sarc_low";
		  sFlags = "SP_SN01_SA_PL3_SD200_LT0";
		  }
		else if (randflag <=5 ){
		  sFlags = "SP_SN01_SA_PL3_SD200";
		  sTemplate = "corpse1";
	    }
		else if (randflag <=6){
		  sFlags = "SP_SN01_SA_PL3T70_SD200_LT1";
		  sTemplate = "plc_chest_mid";
		}
	}
	
	if (nFlagTableNumber == 23)  //static outsiders
    {
  
	  sFlags = "SP_SN03_SA_SG_CD120T3_SD200_IS1D0_RS50_DS2_PC5_RW_RHD50";
      sTemplate = "out_mid";		
	}

	if (nFlagTableNumber == 24)  //static outsiders
    {
  
	  sFlags = "SP_SN03_SA_SG_CD120T3_SD200_IS1D0_RS50_DS2_PC5_RW_RHD50";
      sTemplate = "wildmenlair";		
	}
	
	if (nFlagTableNumber == 25)  //static outsiders
    {
  
	  sFlags = "SP_SN03_SA_SG_CD120T3_SD200_IS1D0_RS50_DS2_PC5_RW_RHD50";
      sTemplate = "spider_mid";		
	}
	

// -------------------------------------------
// Only Make Modifications Between These Lines
//

    // Record Values
    if (sFlags != "")
    {
        SetLocalString(oSpawn, "f_Flags", sFlags);
    }
    else
    {
        SetLocalString(oSpawn, "f_Flags", sSpawnName);
    }
    if (sTemplate != "")
    {
        SetLocalString(oSpawn, "f_Template", sTemplate);
    }
    else
    {
        SetLocalString(oSpawn, "f_Template", sSpawnTag);
    }
}
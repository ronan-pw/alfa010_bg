/*
This file is sued to define a DPSS category.
In it should be a list of creatures for the system to choose from, a list of areas to spawn into
the number of CR the population increses by per hour and the threshold CR at which point the systems
populates the next area in its list
*/

/*
DPSS CATEGORY 01 - Brokenshield Goblins
*/


//insert the area tags of the areas to be spawned here
string sAreaA="cloakwood_02_0";
string sAreaB="cloakwood_02";
string sAreaC="cloakwood_03";
string sAreaD="cloakwood_01";
string sAreaE="cloakwood_hill_01";

//insert the resrefs of the creatures to be spawned here (must be 6 entries)
string sCreatureA="dpss_goblin01";
string sCreatureB="dpss_goblin02";
string sCreatureC="dpss_goblin02";
string sCreatureD="dpss_goblin03";
string sCreatureE="dpss_goblin04";
string sCreatureF="dpss_goblin05";

//insert the threshold of the CR at which creatures will populate the next area here
int iCR_Threshold=30;

//the amount per RL hour that the CR value increases by
int iCR_Increase=1;

//the campaign database string to call
string sDataBase="DPSS_CAT01";

// Interval between successive updates
float fUpdateInterval = 3600.0;

//MAIN CODE BELOW
void main()
{
	
	//the current CR value of the category - For testing this is set at this value every server reset
	int CURRENT_CR=GetCampaignInt(sDataBase,"CURRENT_CR");
	SetLocalInt(OBJECT_SELF,"CURRENT_CR",CURRENT_CR);
	SetLocalInt(OBJECT_SELF,"MAX_CR_SPAWN",iCR_Threshold);
	SetLocalInt(OBJECT_SELF,"CR_INCREASE",iCR_Increase);
	SetLocalFloat(OBJECT_SELF,"UPDATE_INTERVAL",fUpdateInterval);
	SetLocalString(OBJECT_SELF,"DATABASE",sDataBase);
	
	
	WriteTimestampedLogEntry("Generating DPSS (database="+sDataBase+", incr="+IntToString(iCR_Increase)+", thrs="+IntToString(iCR_Threshold)+", tick="+FloatToString(fUpdateInterval)+", cur="+IntToString(CURRENT_CR)+")");
	
	//link the controller to the areas it controls and set up thresholds for CR spawning
	object AreaA=GetObjectByTag(sAreaA);
	object AreaB=GetObjectByTag(sAreaB);
	object AreaC=GetObjectByTag(sAreaC);
	object AreaD=GetObjectByTag(sAreaD);
	object AreaE=GetObjectByTag(sAreaE);
	
	//AREA_A
	SetLocalObject(OBJECT_SELF,"AREA_A",AreaA);
	SetLocalObject(AreaA,"CONTROLLER",OBJECT_SELF);
	SetLocalInt(AreaA,"DPSS_CR_THRESHOLD",1);//sanity check, dont spawn if CR pool is less than 1
	
	//AREA_B
	SetLocalObject(OBJECT_SELF,"AREA_B",AreaB);
	SetLocalObject(AreaB,"CONTROLLER",OBJECT_SELF);
	SetLocalInt(AreaB,"DPSS_CR_THRESHOLD",(iCR_Threshold));
	
	//AREA_C
	SetLocalObject(OBJECT_SELF,"AREA_C",AreaC);
	SetLocalObject(AreaC,"CONTROLLER",OBJECT_SELF);
	SetLocalInt(AreaC,"DPSS_CR_THRESHOLD",(iCR_Threshold*2));
	
	//AREA_D
	SetLocalObject(OBJECT_SELF,"AREA_D",AreaD);
	SetLocalObject(AreaD,"CONTROLLER",OBJECT_SELF);
	SetLocalInt(AreaD,"DPSS_CR_THRESHOLD",(iCR_Threshold*3));
	
	//AREA_E
	SetLocalObject(OBJECT_SELF,"AREA_E",AreaE);
	SetLocalObject(AreaE,"CONTROLLER",OBJECT_SELF);
	SetLocalInt(AreaE,"DPSS_CR_THRESHOLD",(iCR_Threshold*4));
	
	
	//set up the resref strings on the controller
	SetLocalString(OBJECT_SELF,"CREATURE_1",sCreatureA);
	SetLocalString(OBJECT_SELF,"CREATURE_2",sCreatureB);
	SetLocalString(OBJECT_SELF,"CREATURE_3",sCreatureC);
	SetLocalString(OBJECT_SELF,"CREATURE_4",sCreatureD);
	SetLocalString(OBJECT_SELF,"CREATURE_5",sCreatureE);
	SetLocalString(OBJECT_SELF,"CREATURE_6",sCreatureF);

	SetLocalString(OBJECT_SELF,"BOUNTY_ITEM","it_plot_goblin_bounty");
	SetLocalInt(OBJECT_SELF,"BOUNTY_LIMIT",200);
	
	ExecuteScript("dpss_phb",OBJECT_SELF);

}

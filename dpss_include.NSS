
#include "010_spawn_ex"

const int DEBUG=0;
const float DESPAWN_DELAY=600.0;
const float DPSS_WALK_PROB=0.3;

void DPSS_SPAWN_AREA(object oArea,object oPC);
//spawns an area defined as using DPSS

void DPSS_DESPAWN_AREA(object oArea,object oPC);
//despawns all DPSS creatures in an area when the area is empty

int GetIsAreaEmpty(object oArea);
//returns TRUE is the area has no PCs or DMs


int GetIsAreaEmpty(object oArea)
{
	object oFirst=GetFirstObjectInArea(oArea);
	while (GetIsObjectValid(oFirst))
		{
		if (GetIsPC(oFirst))
			{return FALSE;}
		oFirst=GetNextObjectInArea(oArea);	
		}
	return TRUE;
}

void internal_dpss_despawn_area(object oArea)
{
	if (!GetLocalInt(oArea,"DPSS_SPAWNED"))
		return;
		
	if (!GetLocalInt(oArea,"DPSS_DESPAWNING"))
		return;

	if (!GetIsAreaEmpty(oArea))
		return;

	if (DEBUG)
		WriteTimestampedLogEntry("DESPAWNING AREA "+GetName(oArea) + " (" + GetTag(oArea) + ")");
	
	object oBase=GetFirstObjectInArea(oArea);
	if (!GetIsObjectValid(oBase))
		WriteTimestampedLogEntry("ERROR!  Base object NOT found in "+GetName(oArea) + " (" + GetTag(oArea) + ")");
		
	if (DEBUG)
		WriteTimestampedLogEntry("Base object found in "+GetName(oArea) + " (" + GetTag(oArea) + ")");
	
	int iNth=1;
	object oLoop=GetNearestObjectByTag("DPSS_CREATURE",oBase,iNth);
    while (GetIsObjectValid(oLoop))
	{
		SetIsDestroyable(TRUE,FALSE,FALSE);
		DestroyObject(oLoop);
		iNth=iNth+1;
		oLoop=GetNearestObjectByTag("DPSS_CREATURE",oBase,iNth);
	}
	
	DeleteLocalInt(oArea,"DPSS_DESPAWNING");
	DeleteLocalInt(oArea,"DPSS_SPAWNED");
}

void DPSS_DESPAWN_AREA(object oArea,object oPC)
{
	/* not DPSS, ignore */
	if (!GetLocalInt(oArea,"DPSS_SPAWNED"))
		return;
		
	/* already despawning */
	if (!GetLocalInt(oArea,"DPSS_DESPAWNING"))
		return;

	if (DEBUG)
		WriteTimestampedLogEntry("BEGIN DESPAWNING AREA "+GetName(oArea) + " (" + GetTag(oArea) + ")");
		
	SetLocalInt(OBJECT_SELF,"DPSS_DESPAWNING",1);
	
	DelayCommand(DESPAWN_DELAY,internal_dpss_despawn_area(oArea));
}

// DPSS_CATEGORY_01

int dpss_bounty_check(string sTag)
{
	object oController = GetObjectByTag(sTag);
	int CURRENT_CR, nBountyLimit;
	CURRENT_CR = GetLocalInt(oController,"CURRENT_CR");
	nBountyLimit = GetLocalInt(oController,"BOUNTY_LIMIT");

	return (CURRENT_CR >= nBountyLimit);
}


void DPSS_SPAWN_AREA(object oArea,object oPC)
{
	/* sanity check, make sure the area is flagged as DPSS */
	if (!GetLocalInt(oArea,"DPSS_CATEGORY"))
		return;
		
	/* despawning still, don't respawn */
	if (GetLocalInt(oArea,"DPSS_DESPAWNING"))
		return;
		
	/* already spawned, return */
	if (GetLocalInt(OBJECT_SELF,"DPSS_SPAWNED"))
		return;

	SetLocalInt(OBJECT_SELF,"DPSS_SPAWNED",1);

	int DPSS_CATEGORY=GetLocalInt(oArea,"DPSS_CATEGORY");
	if (DEBUG)
		WriteTimestampedLogEntry("DPSS spawn fired in "+GetName(oArea) + " (" + GetTag(oArea) + ")");
		
	object oController=GetLocalObject(OBJECT_SELF,"CONTROLLER");
	
	if (DEBUG)
		WriteTimestampedLogEntry("DPSS CONTROLLER = "+GetName(oController));
		
	//get the current CR value of the category
	int CURRENT_CR=GetLocalInt(oController,"CURRENT_CR");
	int THRESHOLD_CR=GetLocalInt(OBJECT_SELF,"DPSS_CR_THRESHOLD");
	string sDatabase = GetLocalString(oController,"DATABASE");
	float fUpdateInterval = GetLocalFloat(oController,"UPDATE_INTERVAL");
		
	//debug reporting
	if (DEBUG) {
		WriteTimestampedLogEntry("DPSS CR Threshold="+IntToString(THRESHOLD_CR));
		WriteTimestampedLogEntry("DPSS CURRENT CR="+IntToString(CURRENT_CR));
	}
	
	// paz - throw in a check to see if incrementing didn't stall
	// note, truncate by 6 to have it entirely in seconds
	string str = NWNXGetString("TIME", "QUERY", sDatabase+"_timer", 0);
	float ts = StringToFloat(GetSubString(str, 0, GetStringLength(str) - 6));
	
	if (ts > fUpdateInterval) {
		WriteTimestampedLogEntry("ERROR, restarting timed loop, "+FloatToString(ts)+ " > " + FloatToString(fUpdateInterval));
		ExecuteScript("dpss_phb",oController);
	}
		
	//if Current CR is greater than the CR threshold to spawn the area, begin spawning
	if (CURRENT_CR <= THRESHOLD_CR)
		return;
	
	//begin spawn
	if (DEBUG)
		WriteTimestampedLogEntry("BEGING DPSS SPAWN in "+GetName(oArea) + " (" + GetTag(oArea) + ")");
			
	//definitions for loop
	int INDIVIDUAL_CR;
	int D6;
	int D10;
	string sCreatureType, sBountyType;
	object oSpawn;
	location lSpawn,l;
	object oCreature;
	object oItem;
			
	object oBase=GetFirstObjectInArea(OBJECT_SELF);
			
	//determine how many CR to spawn. If this figure is over the maximum CR for the area
	//(defined in the catergory definition script as MAX_CR_SPAWN_ then set to spawn only
	//the max number of CR
	int CR_TO_SPAWN=(CURRENT_CR-THRESHOLD_CR);
	int MAX_CR_SPAWN=GetLocalInt(oController,"MAX_CR_SPAWN");
	if (CR_TO_SPAWN>MAX_CR_SPAWN)
		{CR_TO_SPAWN=MAX_CR_SPAWN;} 
				
	if (DEBUG)
		WriteTimestampedLogEntry("CR TO SPAWN="+IntToString(CR_TO_SPAWN));
	int SPAWNED_CR=0;
			
			
	while (SPAWNED_CR<CR_TO_SPAWN)
	{
		//determine creature to spawn
		D6=d6(1);

		sCreatureType=GetLocalString(oController,"CREATURE_"+IntToString(D6));
		sBountyType=GetLocalString(oController,"BOUNTY_ITEM");

		if (DEBUG)
			WriteTimestampedLogEntry("Spawning resref "+sCreatureType);
		//determine waypoint to spawn at
		D10=d10(1);
		oSpawn=GetNearestObjectByTag("DPSS_SPAWN",oBase,D10);
		lSpawn=GetLocation(oSpawn);
		
		// spawn creature and set up link to controller
		WriteTimestampedLogEntry("DPSS: "+sCreatureType+" in "+GetName(oArea) + " ("+GetTag(oArea)+")");
		l = randomize_location(lSpawn);
		oCreature = CreateObject(OBJECT_TYPE_CREATURE,sCreatureType,l,FALSE,"DPSS_CREATURE");

		// Create a bounty item if we're overpopulated
		if (dpss_bounty_check(GetTag(oController))) {
			oItem = CreateObject(OBJECT_TYPE_ITEM,sBountyType,l);
			CopyObject(oItem, l, oCreature);
			DestroyObject(oItem);
		}
		
		SetLocalObject(oCreature,"CONTROLLER",oController);
		SetLocalInt(oCreature,"DPSS_CREATURE",1);
		
		SetLocalInt(oCreature, "X2_L_SPAWN_USE_AMBIENT_IMMOBILE", 1);
		SetLocalInt(oCreature, "X2_L_SPAWN_USE_AMBIENT", 1);
		
		if (ACR_RandomFloat() <= DPSS_WALK_PROB) {
			SetLocalInt(oCreature, "X2_L_SPAWN_USE_AMBIENT", 0);
			SetLocalInt(oCreature, "ACR_FLOCKING", 1);
		}
		
		if (ACR_RandomFloat() <= DPSS_WALK_PROB) {
			SetActionMode(oCreature, ACTION_MODE_STEALTH, 1);
		}
		
		ChangeToStandardFaction(oCreature,STANDARD_FACTION_HOSTILE);
		
		INDIVIDUAL_CR=FloatToInt(GetChallengeRating(oCreature));
		SPAWNED_CR=SPAWNED_CR+INDIVIDUAL_CR;
		if (DEBUG)
			WriteTimestampedLogEntry("SPAWNED_CR="+IntToString(SPAWNED_CR));
				
	}
}


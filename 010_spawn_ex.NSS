#include "010_area_ex"
#include "acr_tools_i"
#include "acr_spawn_i"

const string A010_CRE_CWBAATEZU_OROG = "010_cwbaatezu_orog_hum3";
const string A010_CRE_CWBAATEZU_OROG_BAR1 = "010_cwbaatezu_orog_bar1";
const string A010_CRE_CWBAATEZU_OROG_BAR2FTR2 = "010_cwbaatezu_orog_barb2ftr2";
const string A010_CRE_CWBAATEZU_OROG_FTR1 = "010_cwbaatezu_orog_ftr1";
const string A010_CRE_CWBAATEZU_OROG_ROG1 = "010_cwbaatezu_orog_rog1";
const string A010_CRE_CWBAATEZU_OROG_SOR6 = "010_cwbaatezu_orog_sor6";
const string A010_CRE_CWBAATEZU_OROG_SOR8 = "010_cwbaatezu_orog_sor8";
const string A010_CRE_CWBAATEZU_OROG_WRK8 = "010_cwbaatezu_orog_wrk8";

const string A010_CRE_OUTSIDER_HELLHOUND = "abr_cr_ou_hellhound";
const string A010_CRE_OUTSIDER_NESSIANWARHOUND = "abr_cr_ou_nessianwarhound";
const string A010_CRE_OUTSIDER_IMP = "abr_cr_ou_imp";

string GetLowCROrog() {
	switch(Random(4)) {
		case 0: return A010_CRE_CWBAATEZU_OROG_BAR1;
		case 1: return A010_CRE_CWBAATEZU_OROG_FTR1;
		case 2: return A010_CRE_CWBAATEZU_OROG_ROG1;
	}
	return A010_CRE_CWBAATEZU_OROG;
}

object SpawnInvisibleImp() {
	object oSpawned = ACR_SpawnObject(A010_CRE_OUTSIDER_IMP, OBJECT_TYPE_CREATURE);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectInvisibility(INVISIBILITY_TYPE_NORMAL), oSpawned);
	SetActionMode(oSpawned, ACTION_MODE_STEALTH, 1);
	return oSpawned;
}

void SpawnRandomNumber(int nMin, int nMax, string sResource, int nObjectType = OBJECT_TYPE_CREATURE) {
	int nNum = nMin + Random(1+nMax-nMin);
	
	int i;
	for(i=0; i<nNum; i++) ACR_SpawnObject(sResource, nObjectType);
}

int GetHasEffectType(object oObject, int iEffectType) {
	effect eEff = GetFirstEffect(oObject);
	while(GetIsEffectValid(eEff)) {
		if(GetEffectType(eEff) == iEffectType) return TRUE;
		eEff = GetNextEffect(oObject);
	}
	return FALSE;
}

int CanSee(int nSpot, int nListen, object oTarget) {

	if(GetHasEffectType(oTarget, EFFECT_TYPE_INVISIBILITY) || GetHasEffectType(oTarget, EFFECT_TYPE_GREATERINVISIBILITY))
		return FALSE;
	
	return GetStealthMode(oTarget) == STEALTH_MODE_DISABLED ||
		!GetIsSkillSuccessful(oTarget, SKILL_HIDE, d20() + nSpot, TRUE);
}

void PerformPerceptionChecks(location lLoc, int nSpotDC, int nListenDC, string sFailMessage, string sSuccessMessage, int bDisplayRolls = TRUE) {
	object oPC = GetFirstPC();
	while(GetIsObjectValid(oPC)) {
		float fDistance = GetDistanceBetweenLocations(lLoc, GetLocation(oPC));
		
		if(fDistance >= 0.0 && fDistance < 50.0) {
			int nDCMod = FloatToInt(fDistance * 3.0)/10 + GetIsInCombat(oPC) ? 5 : 0;
			
			if(GetIsSkillSuccessful(oPC, SKILL_SPOT, nSpotDC + nDCMod, bDisplayRolls))
				FloatingTextStringOnCreature(sSuccessMessage, oPC, FALSE, 6.0);
			else if(GetIsSkillSuccessful(oPC, SKILL_LISTEN, nListenDC + nDCMod, bDisplayRolls))
				FloatingTextStringOnCreature(sSuccessMessage, oPC, FALSE, 6.0);
			else FloatingTextStringOnCreature(sFailMessage, oPC, FALSE, 6.0);
		}
	
		oPC = GetNextPC();
	}
}

location randomize_location(location l, float dist=3.0)
{
    float dir,range,x,y,face;
    vector v;
	
    dir = 180.0 * ACR_RandomFloat();
    face = 360.0 * ACR_RandomFloat();
    range = ACR_RandomNormal(0.0f,dist);
	
    v = GetPositionFromLocation(l);
	
    x = sin(dir) * range;
    y = cos(dir) * range;
	
    v = Vector(v.x+x, v.y+y, v.z);

    return Location(GetAreaFromLocation(l), v, face);
}

object spawn_npc_internal(string resref, float prob, float prob_walk, int use_ambient)
{
	float calc;
	object o = OBJECT_INVALID;
	location loc = ACR_GetSpawnLocation();
	
	// Randomize location
	calc = ACR_RandomFloat();
	
	loc = randomize_location(loc,5.0);
	
	if (calc <= prob) {
		o = ACR_SpawnObjectAtLocation(resref, OBJECT_TYPE_CREATURE, loc);


		if (use_ambient > 0) 
			SetLocalInt(o, "X2_L_SPAWN_USE_AMBIENT_IMMOBILE", 1);
		
		SetLocalInt(o, "X2_L_SPAWN_USE_AMBIENT", 0);
		
		calc = ACR_RandomFloat();
		if (calc <= prob_walk) 
			SetLocalInt(o, "X2_L_SPAWN_USE_AMBIENT", 1);
		
	}
	return o;
}

object spawn_npc(string resref, float prob=1.0, float prob_walk=0.2)
{
	object o;
	o = GetArea(OBJECT_SELF);
	return spawn_npc_internal(resref, prob, prob_walk, 1);
}

object spawn_friendly_npc(string resref, float prob=1.0, float prob_walk=0.2)
{
	object o = spawn_npc(resref, prob, prob_walk);
	ChangeToStandardFaction(o,STANDARD_FACTION_DEFENDER);
	return o;
}

object spawn_hostile_npc(string resref, float prob=1.0, float prob_walk=0.2)
{
	object o = spawn_npc(resref, prob, prob_walk);
	ChangeToStandardFaction(o,STANDARD_FACTION_HOSTILE);
	return o;
}

object spawn_hostile(string resref, float prob=1.0, float prob_walk=0.2)
{
	return spawn_hostile_npc(resref, prob, prob_walk);
}

object spawn_nonambient_npc(string resref, float prob=1.0, float prob_walk=0.2)
{
	return spawn_npc_internal(resref, prob, prob_walk, 0);
}

void spawn_group(string resref, float prob=1.0)
{
	float f = ACR_RandomFloat();
	object o = OBJECT_INVALID;
	
	if (f <= prob) {
		ACR_SpawnGroup(resref);
	}
}

/*void spawn_placeable_internal(string resref, object o)
{
	location loc = GetLocation(o);
	SetImmortal(o,FALSE);
	DestroyObject(o);
	
	SendMessageToAllDMs("destroying factionpig");
	
	ACR_SpawnObjectAtLocation(resref, OBJECT_TYPE_PLACEABLE, loc);
}*/

void spawn_placeable(string resref, float prob=1.0, float deg=0.0, float deg2=180.0, float dist = 6.0)
{
	float f = (Random(1000)*1.0)/1000;
	object o = OBJECT_INVALID;
	location loc;
		
	if (f <= prob) {
		loc = ACR_GetSpawnLocationFromDirectionAndFacing(deg,dist,deg2+deg);
		
		o = CreateObject(OBJECT_TYPE_CREATURE, "c_faction_pig", loc);
		
		loc = GetLocation(o);
		
		DestroyObject(o);
		
		o = ACR_SpawnObjectAtLocation(resref, OBJECT_TYPE_PLACEABLE, loc);
		
		/* Generic placeables with inventories (chests), lock them */
		if (GetHasInventory(o) && (FindSubString(GetTag(o),"phat_lewt") == -1)) {
			SetEventHandler(o, SCRIPT_PLACEABLE_ON_OPEN, "acf_plc_onopen");
			SetPlotFlag(o,1);
			SetLocked(o,1);
			SetLockUnlockDC(o, 20+Random(11));
			SetLocalInt(o,"ACR_SPAWN_JUNK",1);
		}
	}
}
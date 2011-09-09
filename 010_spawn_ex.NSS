#include "010_area_ex"

object spawn_npc_internal(string resref, float prob, float prob_walk, int use_ambient)
{
	float f = (Random(1000)*1.0)/1000;
	object o = OBJECT_INVALID;
	
	if (f <= prob) {
		o = ACR_SpawnObject(resref, OBJECT_TYPE_CREATURE);

		if (use_ambient > 0) {
			SetLocalInt(o, "X2_L_SPAWN_USE_AMBIENT_IMMOBILE", 1);
		}
		SetLocalInt(o, "X2_L_SPAWN_USE_AMBIENT", 0);
		
		f = (Random(1000)*1.0)/1000;
		if (f <= prob_walk) {
			SetLocalInt(o, "X2_L_SPAWN_USE_AMBIENT", 1);
		}
	}
	return o;
}

object spawn_npc(string resref, float prob=1.0, float prob_walk=0.2)
{
	object o;
	o = GetArea(OBJECT_SELF);
	WriteTimestampedLogEntry("ACR_Spawn: spawn_npc "+resref+" in "+GetName(o) + " (" + GetTag(o) + ")");
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

object spawn_nonambient_npc(string resref, float prob=1.0, float prob_walk=0.2)
{
	return spawn_npc_internal(resref, prob, prob_walk, 0);
}

void spawn_group(string resref, float prob=1.0)
{
	float f = (Random(1000)*1.0)/1000;
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
		SetFirstName(o,"[BUG]");
		SetLastName(o,"Report me!");
		
		loc = GetLocation(o);
		
		SetImmortal(o,FALSE);
		DestroyObject(o);
		
		o = ACR_SpawnObjectAtLocation(resref, OBJECT_TYPE_PLACEABLE, loc);
		
		if (FindSubString(GetTag(o),"phat_lewt") == -1) {
			SetLocked(o,1);
			SetLockLockDC(o,100);
			SetPlotFlag(o,1);
		}
	}
}
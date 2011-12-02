#include "010_randomnpc_i"


void main()
{
	string sResRef;

	sResRef = RandomNPCResref(GetRacialType(OBJECT_SELF));

	DelayCommand(0.1,DestroyObject(OBJECT_SELF));

	if (sResRef == "")
		return;
		
	object oSpawned=CreateObject(OBJECT_TYPE_CREATURE,sResRef,GetLocation(OBJECT_SELF),FALSE,GetTag(OBJECT_SELF));	
	
	SetLocalInt(oSpawned, "X2_L_SPAWN_USE_AMBIENT_IMMOBILE", 1);
	
	if (Random(100) > 80)
		SetLocalInt(oSpawned, "X2_L_SPAWN_USE_AMBIENT", 1);

}

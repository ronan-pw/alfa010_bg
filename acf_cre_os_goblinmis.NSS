#include "acr_creature_i_advanced"

void main()
{
    ACR_CreatureOnSpawnIn();
	
	/*
	///RANDOM SCALE///
	int riX=d10(1);
	int riY=d10(1);
	int riZ=d10(1);
	float rfX=(IntToFloat(riX)/100);
	float rfY=(IntToFloat(riY)/100);
	float rfZ=(IntToFloat(riZ)/100);
	rfX=0.92+rfX;rfY=0.92+rfY;rfZ=0.92+rfZ;
	SetScale(OBJECT_SELF,rfX,rfY,rfZ);
	*/
	int D10a=d10(1);
	int D10b=d10(1);
	int D6d=d6(1);		
	string sArmType;
	string sHelmType;
	string sShldType;
	string sWeapType;
	switch (D10a)
		{
		case 1:sArmType="010_sand_npc_gobleather0";break;
		case 2:sArmType="010_sand_npc_gobleather1";break;
		case 3:sArmType="010_sand_npc_gobleather2";break;
		case 4:sArmType="010_sand_npc_gobleather0";break;
		case 5:sArmType="010_sand_npc_gobleather1";break;
		case 6:sArmType="010_sand_npc_gobleather2";break;
		case 7:sArmType="010_it_chain_poor";break;
		case 8:sArmType="010_it_chain_poor";break;
		case 9:sArmType="010_it_chain_poor";break;
		case 10:sArmType="010_it_chain_poor";break;
		}
	switch (D10b)
		{
		case 1:sHelmType="010_it_helm_humanoid1";break;
		case 2:sHelmType="010_it_helm_humanoid0";break;
		case 3:sHelmType="010_it_helm_humanoid2";break;
		case 4:sHelmType="010_it_helm_humanoid01";break;
		case 5:sHelmType="010_it_helm_humanoid02";break;
		case 6:sHelmType="010_it_helm_humanoid03";break;
		case 7:sHelmType="010_it_helm_humanoid04";break;
		case 8:sHelmType="010_it_helm_chain";break;
		case 9:sHelmType="010_it_helm_kettle";break;
		case 10:sHelmType="010_it_helm_nasal";break;
		}
	switch (D6d)
		{
		case 1:sWeapType="010_it_dagger_humanoid";break;
		case 2:sWeapType="010_it_axe_humanoid";break;
		case 3:sWeapType="010_it_mornstar_humanoid0";break;
		case 4:sWeapType="010_it_ssword_humanoid";break;
		case 5:sWeapType="010_it_spear_humanoid1";break;
		case 6:sWeapType="abr_it_wpn_club_1";break;
		}
	object oArmour=CreateItemOnObject(sArmType);
	object oHelmet=CreateItemOnObject(sHelmType);
	object oWeapon=CreateItemOnObject(sWeapType);
	AssignCommand(OBJECT_SELF,ActionEquipItem(oArmour,1));
	AssignCommand(OBJECT_SELF,ActionEquipItem(oHelmet,0));
	//AssignCommand(OBJECT_SELF,ActionEquipItem(oWeapon,4));

	float fX=(GetScale(OBJECT_SELF,SCALE_X)-0.05)+(IntToFloat(d10(1))/100);
	float fY=(GetScale(OBJECT_SELF,SCALE_Y)-0.05)+(IntToFloat(d10(1))/100);
	float fZ=(GetScale(OBJECT_SELF,SCALE_Z)-0.05)+(IntToFloat(d10(1))/100);
	SetScale(OBJECT_SELF,fX,fY,fZ);	
	
	
}
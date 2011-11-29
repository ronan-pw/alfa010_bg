#include "acr_tools_i"
#include "acr_zspawn_i"
#include "010_namegen_i"

const float _SIZE_STD_X = 0.05f;
const float _SIZE_STD_Y = 0.05f;
const float _SIZE_STD_Z = 0.05f;


void RandomizeNPCName(object oNPC)
{
	string s0="",s1="";
	int gender = GetGender(oNPC);

	switch (GetRacialType(oNPC)) {
		case RACIAL_TYPE_DWARF:
			s0 = RandomNameDwarf(gender);
			break;
		case RACIAL_TYPE_GNOME:
			s0 = RandomNameGnome(gender);
			if (!Random(4))
				s1 = RandomNameGnome(gender,1);
			break;
		default:
			s0 = RandomNameHuman(gender);
			s1 = RandomNameHuman(0);
	}

	s0 += " {Random}";

	SetFirstName(oNPC, s0);
	SetLastName(oNPC, s1);
}

void RandomizeNPCAppearance(object oNPC)
{
	ACR_RandomizeAppearance(oNPC);
}

void RandomizeNPCScale(object oNPC)
{
	float x,y,z;

	x=ACR_RandomNormal(GetScale(oNPC,SCALE_X),_SIZE_STD_X);
	y=ACR_RandomNormal(GetScale(oNPC,SCALE_Y),_SIZE_STD_Y);
	z=ACR_RandomNormal(GetScale(oNPC,SCALE_Z),_SIZE_STD_Z);

	SetScale(oNPC,x,y,z);
}

void RandomizeNPCClothing(object oNPC)
{
	string sArmType,sBootType;
	int rCloth,rBoots,gender=GetGender(oNPC);

	
	///RANDOM EQUIP/////
	rCloth=d20(1);
	rBoots=d10(1);
	
	//create clothing
	switch (rCloth)
		{
		case 1:sArmType="010_it_clothcom";break;
		case 2:sArmType="010_it_clothcom0";break;
		case 3:sArmType="010_it_clothcom1";break;
		case 4:sArmType="010_it_clothcom2";break;
		case 5:sArmType="010_it_clothcom3";break;
		case 6:sArmType="010_it_clothcomb";break;
		case 7:sArmType="010_it_clothcomb0";break;
		case 8:sArmType="010_it_clothcomb1";break;
		case 9:sArmType="010_it_clothcomb2";break;
		case 10:sArmType="010_it_clothcomb3";break;
		case 11:sArmType="010_it_clothcomb4";break;
		case 12:sArmType="010_it_clothcomb5";break;
		case 13:sArmType="010_it_clothcomc";break;
		case 14:sArmType="010_it_clothcomc0";break;
		case 15:sArmType="010_it_clothcomc1";break;
		case 16:sArmType="010_it_clothcomc2";break;
		case 17:sArmType="010_it_clothcomc3";break;
		case 18:sArmType="010_it_clothcomd";break;
		case 19:sArmType="010_it_clothcomd0";break;
		case 20:sArmType="010_it_clothcomd1";break;
		}
	object oArmour=CreateItemOnObject(sArmType);
	AssignCommand(oNPC,ActionEquipItem(oArmour,1));
	//create boots
	switch (rBoots)
		{
		case 1:sBootType="010_it_boots";break;
		case 2:sBootType="010_it_boots1";break;
		case 3:sBootType="010_it_boots2";break;
		case 4:sBootType="010_it_bootscloth";break;
		case 5:sBootType="010_it_bootscloth0";break;
		case 6:sBootType="010_it_bootscloth2";break;
		case 7:sBootType="010_it_bootscloth3";break;
		case 8:sBootType="010_it_bootscloth4";break;
		case 9:sBootType="010_it_boots0";break;
		case 10:sBootType="010_it_boots3";break;
		}
	object oBoots=CreateItemOnObject(sBootType);
	AssignCommand(oNPC,ActionEquipItem(oBoots,2)); 
}

void RandomizeNPC(object oNPC, int nEquip=1)
{
	RandomizeNPCName(oNPC);
	RandomizeNPCAppearance(oNPC);
	RandomizeNPCScale(oNPC);

	if (nEquip)
		RandomizeNPCClothing(oNPC);
}

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

	s0 += "{Random}";

	SetFirstName(oNPC, s0);
	SetLastName(oNPC, s1);
}

void RandomizeNPCAppearance(object oNPC)
{
	float f = 0.3;
	int rand = 999,skin=Random(3);


	// Give dwarves higher chance of beard
	if (GetRacialType(oNPC) == RACIAL_TYPE_DWARF)
		f = 0.8;

	ACR_RandomizeAppearance(oNPC,rand,rand,rand,rand,rand,rand,skin,rand,f);
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

string RandomNPCResref(int race=RACIAL_TYPE_HUMAN)
{
	string sResRef="";

	if (Random(10) < 2)
		return "";

	switch (race) {
		case RACIAL_TYPE_DWARF:
			switch (Random(8)) {
				case 0:
					switch (Random(6)) {
						case 0:
							sResRef="abr_cr_DwarfExpertM";
							break;
						case 1:
							sResRef="abr_cr_DwarfExpertF";
							break;
						case 2:
							sResRef="abr_cr_DwarfWarriorA";
							break;
						case 3:
							sResRef="abr_cr_DwarfWarriorH";
							break;
						case 4:
							sResRef="abr_cr_DwarfAdeptM";
							break;
						case 5:
							sResRef="abr_cr_DwarfAdeptF";
							break;
					}
					break;
				case 1:
					sResRef="abr_cr_dwarf_commoner1";
					break;
				case 2:
					sResRef="abr_cr_dwarf_commoner2";
					break;
				case 3:
					sResRef="abr_cr_dwarf_commoner3";
					break;
				case 4:
					sResRef="abr_cr_dwarf_commoner4";
					break;
				case 5:
					sResRef="abr_cr_dwarf_commoner5";
					break;
				case 6:
					sResRef="abr_cr_dwarf_commoner1_walk";
					break;
				case 7:
					sResRef="abr_cr_dwarf_commoner2_walk";
					break;
			}
			break;
		case RACIAL_TYPE_GNOME:
			switch (Random(5)) {
				case 0:
					switch (Random(6)) {
						case 0:
							sResRef="abr_cr_GnomeExpertM";
							break;
						case 1:
							sResRef="abr_cr_GnomeExpertF";
							break;
						case 2:
							sResRef="abr_cr_GnomeWarriorX";
							break;
						case 3:
							sResRef="abr_cr_GnomeWarriorH";
							break;
						case 4:
							sResRef="abr_cr_GnomeAdeptM";
							break;
						case 5:
							sResRef="abr_cr_GnomeAdeptF";
							break;
					}
					break;
				case 1:
					sResRef="010_cr_gnome_comm0";
					break;
				case 2:
					sResRef="010_cr_gnome_comm1";
					break;
				case 3:
					sResRef="010_cr_gnome_comm2";
					break;
				case 4:
					sResRef="010_cr_gnome_comm3";
					break;
				}
			break;
		case RACIAL_TYPE_HUMAN:
		default:
			switch (Random(24)) {
				case 0:
					sResRef="010_cr_comm_human_m1";
					break;
				case 1:
					sResRef="010_cr_comm_human";
					break;
				case 2:
					sResRef="010_cr_comm_human0";
					break;
				case 3:
					sResRef="010_cr_comm_human1";
					break;
				case 4:
					sResRef="010_cr_comm_human2";
					break;
				case 5:
					sResRef="010_cr_comm_human3";
					break;
				case 6:
					sResRef="010_cr_comm_human4";
					break;
				case 7:
					sResRef="010_cr_comm_human5";
					break;
				case 8:
					sResRef="010_cr_comm_human6";
					break;
				case 9:
					sResRef="010_cr_comm_human7";
					break;
				case 10:
					sResRef="010_cr_comm_human8";
					break;
				case 11:
					sResRef="010_cr_comm_human00";
					break;
				case 12:
					sResRef="010_cr_comm_human10";
					break;
				case 13:
					sResRef="010_cr_comm_human20";
					break;
				case 14:
					sResRef="010_cr_comm_human30";
					break;
				case 15:
					sResRef="010_cr_comm_human40";
					break;
				case 16:
					sResRef="010_cr_comm_human50";
					break;
				case 17:
					sResRef="010_cr_comm_human60";
					break;
				case 18:
					sResRef="010_cr_comm_human70";
					break;
				case 19:
					sResRef="010_cr_comm_human80";
					break;
				case 20:
					sResRef="010_cr_comm_human11";
					break;
				case 21:
					sResRef="010_cr_comm_human_f0";
					break;
				case 22:
					sResRef="010_cr_comm_human_f1";
					break;
				case 23:
					sResRef="010_cr_comm_human_m0";
					break;
		}
		break;
	}
	return sResRef;
}

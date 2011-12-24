#include "nwnx_objectattributes_include"
#include "acr_pps_i"


#define _DEBUG_ZS

const int ACR_NUM_DEFAULT_FEATURE_COLOURS	= 18;
const int ACR_FEATURE_TYPE_RANDOM		= 999;


const int ACR_APP_TYPE_HAIR_ACC			= 0x011;
const int ACR_APP_TYPE_HAIR_LO			= 0x012;
const int ACR_APP_TYPE_HAIR_HI			= 0x013;

const int ACR_APP_TYPE_HEAD_SKIN		= 0x021;
const int ACR_APP_TYPE_HEAD_EYE			= 0x022;
const int ACR_APP_TYPE_HEAD_HAIR		= 0x023;

const int ACR_APP_TYPE_BASE_SKIN		= 0x031;
const int ACR_APP_TYPE_BASE_HAIR		= 0x032;
const int ACR_APP_TYPE_BASE_EYE			= 0x033;


// This function applies a hair dye oDye to the subject oTarget, using the skill
// of oBeautician. It assumes that permission is given to oTarget, but contains
// the functionality to handle all other aspects of the effect.
void DoHairDye(object oDye, object oBeautician, object oTarget, int nRoll = FALSE);


void ResetModel(object o);
string GetNaturalHairColor(object oCharacter);

void DyeHairRaw(string sDye, object oBeautician, object oTarget, int nRoll = FALSE)
{
	struct XPObjectAttributes_Color dye,dye_ll;
	struct XPObjectAttributes_TintSet tints;
	int i,ll = 0;
	float sigma, phi, theta, psi, rho, epsilon, r,h;
	float rho_prime, theta_prime, phi_prime;
	float rho_star, theta_star, phi_star;
	vector h0, h1, l0, l1, x0, x1;
	vector x_prime, x_star;
	vector h1_star, l1_star, x1_star;

	// Special case (hack) for hair dye remover
	if (sDye == "######") {
		string sNat = GetNaturalHairColor(oTarget);
		sDye = RawHairToHairHighlight(sNat);
		dye_ll = RawAttribToTint(RawHairToHairLowlight(sNat));
		ll = 1;
	}

//=== This information lives inside of the character object-- we need NWNx4 to harvest it ===//
	tints = GetHairTintSet(oTarget);
	dye = RawAttribToTint(sDye);


	/* highlight origin */
	h0.x = tints.Tint2_r;
	h0.y = tints.Tint2_g;
	h0.z = tints.Tint2_b;

	/* lowlight origin */
	l0.x = tints.Tint1_r;
	l0.y = tints.Tint1_g;
	l0.z = tints.Tint1_b;

	/* highlight destination */
	h1.x = dye.r;
	h1.y = dye.g;
	h1.z = dye.b;

	/* when both using the same tint, make ll slightly darker */
	l1.x = 0.9*h1.x;
	l1.y = 0.9*h1.y;
	l1.z = 0.9*h1.z;
	
	/* different dye for ll */
	if (ll) {
		l1.x = dye_ll.r;
		l1.y = dye_ll.g;
		l1.z = dye_ll.b;
	}


//=== Figure out what the skill roll was. ===//	
	int nSkillRoll = 10;
	if(nRoll) nSkillRoll = d20(1);
	int nSkillMod = GetSkillRank(34, oBeautician);
	int nSkillFinal = nSkillRoll + nSkillMod;
	
//=== Let the involved parties know what the dice gods say. ===//	
	string sMessage = "<color=#8699D3>"+GetName(oBeautician)+"</color><color=#203F91> : Disguise: "+IntToString(nSkillRoll)+" + "+IntToString(nSkillMod)+" = "+IntToString(nSkillFinal)+".";
	SendMessageToPC(oBeautician, sMessage);
	SendMessageToPC(oTarget, sMessage);


	sigma = 2/(exp(sqrt(nSkillFinal * 1.0) - 4) + 1.0);
	

	// handle hl first, then ll
	for (i=0; i<2; ++i) {
		// generate in cylindrical 
		h = ACR_RandomNormal(1.0, sigma);
		r = ACR_RandomNormal(0.0, sigma * h);
		theta = ACR_RandomFloat() * 360.0;

		// reorient at (1,0,0)
		h = 1.0-h;
		r = 0.0-r;
		theta = 0.0-theta;

		// map to spherical 
		rho = sqrt(r*r + h*h);
		phi = atan2(r,h);
		theta = theta;

		if (i==0) {
			x0 = h0;
			x1 = h1;
		}
		else  {
			x0 = l0;
			x1 = l1;
		}

		x_prime = x1 - x0;

		// convert motion to spherical
		rho_prime = sqrt(x_prime.x*x_prime.x + x_prime.y*x_prime.y + x_prime.z*x_prime.z);
		phi_prime = atan2(x_prime.y, x_prime.x);
		theta_prime = atan2(sqrt(x_prime.x*x_prime.x + x_prime.y*x_prime.y), x_prime.z);

		// add a small perturbation to always vary somewhat (for cases where (x,y) -> (x,y))
		epsilon = ACR_RandomNormal(0.0, sigma/2);

		// reorient original modification to map properly to rho_prime
		rho_star = (rho_prime + epsilon) * rho;
		phi_star = phi_prime + phi;
		theta_star = theta_prime + theta;


		// convert modification in cartesean coordinates
		x_star.x = rho_star*sin(phi_star)*cos(theta_star);
		x_star.y = rho_star*sin(phi_star)*sin(theta_star);
		x_star.z = rho_star*cos(phi_star);


		// Add calculated modification to original vector
		x_star.x += x_prime.x;
		x_star.y += x_prime.y;
		x_star.z += x_prime.z;


		// Finally do additiion
		x1_star = x_star + x0;


		// limit at 4
		if (x1_star.x > 4.0)
			x1_star.x = 4.0;
		if (x1_star.y > 4.0)
			x1_star.y = 4.0;
		if (x1_star.z > 4.0)
			x1_star.z = 4.0;

		// reflect over 1
		if (x1_star.x > 1.0)
			x1_star.x = 1.0 - (x1_star.x-1.0)/3.0;
		if (x1_star.y > 1.0)
			x1_star.y = 1.0 - (x1_star.y-1.0)/3.0;
		if (x1_star.z > 1.0)
			x1_star.z = 1.0 - (x1_star.z-1.0)/3.0;

		// limit at -4
		if (x1_star.x < -3.0)
			x1_star.x = -3.0;
		if (x1_star.y < -3.0)
			x1_star.y = -3.0;
		if (x1_star.z < -3.0)
			x1_star.z = -3.0;

		// reflect over 0
		if (x1_star.x < 0.0)
			x1_star.x = fabs(x1_star.x/3.0);
		if (x1_star.y < 0.0)
			x1_star.y = fabs(x1_star.y/3.0);
		if (x1_star.z < 0.0)
			x1_star.z = fabs(x1_star.z/3.0);

		if (i==0) 
			h1_star = x1_star;
		else 
			l1_star = x1_star;
	}
	
	tints.Tint2_r = h1_star.x;
	tints.Tint2_g = h1_star.y;
	tints.Tint2_b = h1_star.z;

	tints.Tint1_r = l1_star.x;
	tints.Tint1_g = l1_star.y;
	tints.Tint1_b = l1_star.z;



//=== We need to edit the character object to make this display, which means we return to the NWNx4 ===//	
	XPObjectAttributesSetHairTint(oTarget, tints);
	ResetModel(oTarget);
}

void DoHairDye(object oDye, object oBeautician, object oTarget, int nRoll = FALSE)
{
	//=== The dye's tag contains the dye's 'true' color. ===//
	string sDye = GetStringRight(GetTag(oDye), 6);
	DyeHairRaw(sDye, oBeautician, oTarget, nRoll);
}

string GetNaturalHairColor(object oCharacter)
{

//=== We don't want to ping the database for an NPC; zspawn enables DMs to fiddle with hair colors much more cheaply. ===//
	if(!GetIsPC(oCharacter) || GetIsDMPossessed(oCharacter))
	{
		SendMessageToAllDMs("Warning : GetNaturalHairColor() has been called on an NPC. Aborting the script.");
		return "ERROR";
	}
	
//=== We don't want to ping the database for a DM; if vanity is super important to them, they can more-easily use a GFF editor ===//
	if(GetIsDM(oCharacter))
	{
		SendMessageToAllDMs("Warning : GetNaturalHairColor() has been called on a DM avatar. Aborting the script.");
		return "ERROR";
	}
	object oTool = GetItemPossessedBy(oCharacter, "dmfi_exe_pc");

//=== We would very much like to save this to the DMFI tool. It's faster. ===//
	string sHair = GetLocalString(oTool, "ACR_VANITY_NATHAIR");
	
//=== Dammit. Try the SQL. ===//
	if(sHair == "")
	{
		string sCID = IntToString(ACR_GetCharacterID(oCharacter));
		ACR_SQLQuery("SELECT NaturalHair FROM characters WHERE ID='"+sCID+"'");
		
//=== Fetch succeeded. Harvest data and copy to the data item. ===//		
		if(ACR_SQLFetch() != SQL_SUCCESS)
		{
			sHair = ACR_SQLGetData(0);
		}

//=== Fetch failed. GetData won't give us good numbers, so we update the column in the table and use current colors ===//
		if (sHair == "")
		{
			string sCurrentHair = GetRawHairTintSet(oCharacter);
			ACR_SQLQuery("UPDATE characters SET NaturalHair='"+sCurrentHair+"' WHERE ID='"+sCID+"'");
			sHair = sCurrentHair;
		}
		

		SetLocalString(oTool, "ACR_VANITY_NATHAIR", sHair);
	}

	return sHair;
}


int GetRandomHairModel(int nSubrace, int nGender=0)
{
	int res = 1;

	switch (nSubrace) {

		case RACIAL_SUBTYPE_SHIELD_DWARF:
		case RACIAL_SUBTYPE_GOLD_DWARF: 
			res = UniformRandomOverInterval("[1-19,80-82,94][1-19,73,94]", nGender);
			break;
		case RACIAL_SUBTYPE_MOON_ELF:
		case RACIAL_SUBTYPE_SUN_ELF: 
		case RACIAL_SUBTYPE_WOOD_ELF:
		case RACIAL_SUBTYPE_DROW: 
			res = UniformRandomOverInterval("[1-17,61-64,66-75,80-82,94][1-17,50-52,61-64,66-78,80-82,85-90,94]", nGender);
			break;
		case RACIAL_SUBTYPE_WILD_ELF:  
			res = UniformRandomOverInterval("[1-3,75,80,81,83]");
			break;
		case RACIAL_SUBTYPE_ROCK_GNOME:
			res = UniformRandomOverInterval("[1-17,94][1-17,50-52,73,80-82,94]", nGender);
			break;
		case RACIAL_SUBTYPE_GRAY_DWARF:
		case RACIAL_SUBTYPE_SVIRFNEBLIN:
			res = 17;
			break;
		case RACIAL_SUBTYPE_HUMAN:
		case RACIAL_SUBTYPE_HALFELF:
		case RACIAL_SUBTYPE_HALFDROW:
			res = UniformRandomOverInterval("[1-17,37,38,63,66,71-75,80-82,94][1-17,23,24,50-52,61-64,66-78,80-82,85-90,94]", nGender);
			break;
		case RACIAL_SUBTYPE_LIGHTFOOT_HALF:
		case RACIAL_SUBTYPE_GHOSTWISE_HALF:
		case RACIAL_SUBTYPE_STRONGHEART_HALF:
			res = UniformRandomOverInterval("[1-19,66,74,75,94][1-17,19,51-56,23,24,50-52,66,73-78,80,94]", nGender);
			break;
		case RACIAL_SUBTYPE_HALFORC:
		case RACIAL_SUBTYPE_GRAYORC:
			res = UniformRandomOverInterval("[1-19,94]");
			break;
		case RACIAL_SUBTYPE_YUANTI:
			res = UniformRandomOverInterval("[1-17]");
			break;
		case RACIAL_SUBTYPE_WATER_GENASI:
		case RACIAL_SUBTYPE_FIRE_GENASI:
		case RACIAL_SUBTYPE_EARTH_GENASI:
		case RACIAL_SUBTYPE_AIR_GENASI:
			res = UniformRandomOverInterval("[1-3]");
			break;
		case RACIAL_SUBTYPE_TIEFLING:
			res = UniformRandomOverInterval("[1-18,94][1-19,73,94]", nGender);
			break;
		case RACIAL_SUBTYPE_AASIMAR:
			res = UniformRandomOverInterval("[1-17,37,38,63,66,71-75,80-82,94][1-17,23,24,50-52,61-64,67-78,80-82,85-90,94]", nGender);
			break;
	}

	return res;
}

int GetRandomHeadModel(int nSubrace, int nGender=0)
{
	int res = 1;

	switch (nSubrace) {
		case RACIAL_SUBTYPE_SHIELD_DWARF:
			res = UniformRandomOverInterval("[1-6]");
			break;
		case RACIAL_SUBTYPE_GOLD_DWARF:
		case RACIAL_SUBTYPE_GRAY_DWARF:
			res = UniformRandomOverInterval("[1-3]");
			break;
		case RACIAL_SUBTYPE_MOON_ELF:
			res = UniformRandomOverInterval("[1-7,10][1-8]", nGender);
			break;
		case RACIAL_SUBTYPE_SUN_ELF: 
			res = UniformRandomOverInterval("[1-3][1-2,4-5]", nGender);
			break;
		case RACIAL_SUBTYPE_WILD_ELF:
		case RACIAL_SUBTYPE_WOOD_ELF:
			res = UniformRandomOverInterval("[1-3]");
			break;
		case RACIAL_SUBTYPE_DROW:
			res = UniformRandomOverInterval("[1-3][1-5]", nGender);
			break;
		case RACIAL_SUBTYPE_ROCK_GNOME:
			res = UniformRandomOverInterval("[1-8,10][1-4,7]", nGender);
			break;
		case RACIAL_SUBTYPE_SVIRFNEBLIN:
			res = UniformRandomOverInterval("[1-5][1-4]", nGender);
			break;
		case RACIAL_SUBTYPE_HALFELF:
			res = UniformRandomOverInterval("[1-6]");
			break;
		case RACIAL_SUBTYPE_HALFDROW:
			res = UniformRandomOverInterval("[1-3]");
			break;
		case RACIAL_SUBTYPE_LIGHTFOOT_HALF:
		case RACIAL_SUBTYPE_GHOSTWISE_HALF:
			res = UniformRandomOverInterval("[1-6]");
			break;
		case RACIAL_SUBTYPE_STRONGHEART_HALF:
			res = UniformRandomOverInterval("[1-7][1-5]", nGender);
			break;
		case RACIAL_SUBTYPE_HALFORC:
			res = UniformRandomOverInterval("[1-6][1-7]", nGender);
			break;
		case RACIAL_SUBTYPE_HUMAN:
			res = UniformRandomOverInterval("[1-10,12-20,22-24,40-42][1-6,8-11,14,15,20,25,58-60,88,95]", nGender);
			break;
		case RACIAL_SUBTYPE_YUANTI:
		case RACIAL_SUBTYPE_GRAYORC:
		case RACIAL_SUBTYPE_WATER_GENASI:
		case RACIAL_SUBTYPE_FIRE_GENASI:
		case RACIAL_SUBTYPE_EARTH_GENASI:
		case RACIAL_SUBTYPE_AIR_GENASI:
			res = UniformRandomOverInterval("[1-3]");
			break;
		case RACIAL_SUBTYPE_AASIMAR:
		case RACIAL_SUBTYPE_TIEFLING:
			res = UniformRandomOverInterval("[1-5]");
			break;
	}

	return res;
}

// this is a superset of the random listing
string GetValidHairModels(int nSubrace, int nGender=0)
{
	string res = "#1#";

	switch (nSubrace) {

		case RACIAL_SUBTYPE_SHIELD_DWARF:
		case RACIAL_SUBTYPE_GOLD_DWARF: 
			res = IntervalToList("[1-19,80-82,94][1-19,73,94]", nGender);
			break;
		case RACIAL_SUBTYPE_MOON_ELF:
		case RACIAL_SUBTYPE_SUN_ELF: 
		case RACIAL_SUBTYPE_WOOD_ELF:
		case RACIAL_SUBTYPE_DROW: 
			res = IntervalToList("[1-17,61-64,66-75,80-82,94][1-17,50-52,61-64,66-78,80-82,85-90,94]", nGender);
			break;
		case RACIAL_SUBTYPE_WILD_ELF:  
			res = IntervalToList("[1-3,75,80,81,83]");
			break;
		case RACIAL_SUBTYPE_ROCK_GNOME:
			res = IntervalToList("[1-17,94][1-17,50-52,73,80-82,94]", nGender);
			break;
		case RACIAL_SUBTYPE_GRAY_DWARF:
		case RACIAL_SUBTYPE_SVIRFNEBLIN:
			res = IntervalToList("[17]");
			break;
		case RACIAL_SUBTYPE_HUMAN:
		case RACIAL_SUBTYPE_HALFELF:
		case RACIAL_SUBTYPE_HALFDROW:
			res = IntervalToList("[1-17,37,38,61-63,66-75,80-82,94][1-17,23,24,50-52,61-64,66-78,80-82,85-90,94]", nGender);
			break;
		case RACIAL_SUBTYPE_LIGHTFOOT_HALF:
		case RACIAL_SUBTYPE_GHOSTWISE_HALF:
		case RACIAL_SUBTYPE_STRONGHEART_HALF:
			res = IntervalToList("[1-19,66,74,75,94][1-17,19,51-56,23,24,50-52,66,73-78,80,94]", nGender);
			break;
		case RACIAL_SUBTYPE_HALFORC:
		case RACIAL_SUBTYPE_GRAYORC:
			res = IntervalToList("[1-19,94]");
			break;
		case RACIAL_SUBTYPE_YUANTI:
			res = IntervalToList("[1-17]");
			break;
		case RACIAL_SUBTYPE_WATER_GENASI:
		case RACIAL_SUBTYPE_FIRE_GENASI:
		case RACIAL_SUBTYPE_EARTH_GENASI:
		case RACIAL_SUBTYPE_AIR_GENASI:
			res = IntervalToList("[1-3]");
			break;
		case RACIAL_SUBTYPE_TIEFLING:
			res = IntervalToList("[1-18,94][1-19,73,94]", nGender);
			break;
		case RACIAL_SUBTYPE_AASIMAR:
			res = IntervalToList("[1-17,37,38,63,66,71-75,80-82,94][1-17,23,24,50-52,61-64,67-78,80-82,85-90,94]", nGender);
			break;
	}

	return res;
}

// this is a superset of the random listing
string GetValidHeadModels(int nSubrace, int nGender=0)
{
	string res = "#1#";

	switch (nSubrace) {
		case RACIAL_SUBTYPE_SHIELD_DWARF:
			res = IntervalToList("[1-6]");
			break;
		case RACIAL_SUBTYPE_GOLD_DWARF:
		case RACIAL_SUBTYPE_GRAY_DWARF:
			res = IntervalToList("[1-3]");
			break;
		case RACIAL_SUBTYPE_MOON_ELF:
			res = IntervalToList("[1-7,10][1-8]", nGender);
			break;
		case RACIAL_SUBTYPE_SUN_ELF: 
			res = IntervalToList("[1-3][1-2,4-5]", nGender);
			break;
		case RACIAL_SUBTYPE_WILD_ELF:
		case RACIAL_SUBTYPE_WOOD_ELF:
			res = IntervalToList("[1-3]");
			break;
		case RACIAL_SUBTYPE_DROW:
			res = IntervalToList("[1-3][1-5]", nGender);
			break;
		case RACIAL_SUBTYPE_ROCK_GNOME:
			res = IntervalToList("[1-8,10][1-4,7]", nGender);
			break;
		case RACIAL_SUBTYPE_SVIRFNEBLIN:
			res = IntervalToList("[1-5][1-4]", nGender);
			break;
		case RACIAL_SUBTYPE_HALFELF:
			res = IntervalToList("[1-6]");
			break;
		case RACIAL_SUBTYPE_HALFDROW:
			res = IntervalToList("[1-3]");
			break;
		case RACIAL_SUBTYPE_LIGHTFOOT_HALF:
		case RACIAL_SUBTYPE_GHOSTWISE_HALF:
			res = IntervalToList("[1-6]");
			break;
		case RACIAL_SUBTYPE_STRONGHEART_HALF:
			res = IntervalToList("[1-7][1-5]", nGender);
			break;
		case RACIAL_SUBTYPE_HALFORC:
			res = IntervalToList("[1-6][1-7]", nGender);
			break;
		case RACIAL_SUBTYPE_HUMAN:
			res = IntervalToList("[1-10,12-20,22-24,40-42][1-6,8-11,14,15,20,25,58-60,88,95]", nGender);
			break;
		case RACIAL_SUBTYPE_YUANTI:
		case RACIAL_SUBTYPE_GRAYORC:
		case RACIAL_SUBTYPE_WATER_GENASI:
		case RACIAL_SUBTYPE_FIRE_GENASI:
		case RACIAL_SUBTYPE_EARTH_GENASI:
		case RACIAL_SUBTYPE_AIR_GENASI:
			res = IntervalToList("[1-3]");
			break;
		case RACIAL_SUBTYPE_AASIMAR:
		case RACIAL_SUBTYPE_TIEFLING:
			res = IntervalToList("[1-5]");
			break;
	}

	return res;
}

string GetRandomTint(int nSubrace, int nColumn, int nElement=ACR_FEATURE_TYPE_RANDOM)
{
	string s2DA,sRet;
	string sColumn;
	if (nElement == -1 || nElement == ACR_FEATURE_TYPE_RANDOM)
		nElement = Random(ACR_NUM_DEFAULT_FEATURE_COLOURS);
	
	switch (nSubrace) {
		case RACIAL_SUBTYPE_SHIELD_DWARF:
			s2DA = "color_shielddwarf";
			break;
		case RACIAL_SUBTYPE_GOLD_DWARF:
			s2DA = "color_golddwarf";
			break;
		case RACIAL_SUBTYPE_GRAY_DWARF:
			s2DA = "color_graydwarf";
			break;
		case RACIAL_SUBTYPE_MOON_ELF:
			s2DA = "color_moonelf";
			break;
		case RACIAL_SUBTYPE_SUN_ELF:
			s2DA = "color_sunelf";
			break;
		case RACIAL_SUBTYPE_WILD_ELF:
			s2DA = "color_wildelf";
			break;
		case RACIAL_SUBTYPE_WOOD_ELF:
			s2DA = "color_woodelf";
			break;
		case RACIAL_SUBTYPE_DROW:
			s2DA = "color_drow";
			break;
		case RACIAL_SUBTYPE_ROCK_GNOME:
			s2DA = "color_rockgnome";
			break;
		case RACIAL_SUBTYPE_SVIRFNEBLIN:
			s2DA = "color_deepgnome";
			break;
		case RACIAL_SUBTYPE_HALFELF:
			s2DA = "color_halfelf";
			break;
		case RACIAL_SUBTYPE_HALFDROW:
			s2DA = "color_halfdrow";
			break;
		case RACIAL_SUBTYPE_LIGHTFOOT_HALF:
			s2DA = "color_lightfoot";
			break;
		case RACIAL_SUBTYPE_GHOSTWISE_HALF:
			s2DA = "color_ghostwise";
			break;
		case RACIAL_SUBTYPE_STRONGHEART_HALF:
			s2DA = "color_strongheart";
			break;
		case RACIAL_SUBTYPE_HALFORC:
			s2DA = "color_halforc";
			break;
		case RACIAL_SUBTYPE_HUMAN:
			s2DA = "color_human";
			break;
		case RACIAL_SUBTYPE_AASIMAR:
			s2DA = "color_aasimar";
			break;
		case RACIAL_SUBTYPE_TIEFLING:
			s2DA = "color_tiefling";
			break;
		case RACIAL_SUBTYPE_AIR_GENASI:
			s2DA = "color_airgen";
			break;
		case RACIAL_SUBTYPE_EARTH_GENASI:
			s2DA = "color_earthgen";
			break;
		case RACIAL_SUBTYPE_FIRE_GENASI:
			s2DA = "color_firegen";
			break;
		case RACIAL_SUBTYPE_WATER_GENASI:
			s2DA = "color_watergen";
			break;
		case RACIAL_SUBTYPE_GRAYORC:
			s2DA = "color_grayorc";
			break;
		case RACIAL_SUBTYPE_YUANTI:
			s2DA = "color_yuanti";
			break;
	}
	
	switch (nColumn) {
		case 1:
			sColumn = "hair_1";
			break;
		case 2:
			sColumn = "hair_2";
			break;
		case 3:
			sColumn = "hair_acc";
			break;
		case 4:
			sColumn = "skin";
			break;
		case 5:
			sColumn = "eyes";
			break;
		case 6:
			sColumn = "body_hair";
			break;
	}
	
	sRet = Get2DAString(s2DA, sColumn, nElement);

	if (sRet == "") {
		int i = (Random(256) << 16);
		i += (Random(256) << 8);
		i += Random(256);

		sRet = GetStringRight(IntToHexString(i),6);
	}

	return sRet;
}


//! Randomize appearance of a playable creature
void ACR_RandomizeAppearance(object oSpawn,int nHead = ACR_FEATURE_TYPE_RANDOM,int nHair = ACR_FEATURE_TYPE_RANDOM,int nHair1 = ACR_FEATURE_TYPE_RANDOM,int nHair2 = ACR_FEATURE_TYPE_RANDOM,int nAHair = ACR_FEATURE_TYPE_RANDOM, int nBHair = ACR_FEATURE_TYPE_RANDOM,int nSkin = ACR_FEATURE_TYPE_RANDOM,int nEyes = ACR_FEATURE_TYPE_RANDOM,float fFHair=0.5,int bChangeApp=TRUE)
{
	int nHeadModel,nHairModel,nRandHair,nRace,nSubrace,nGender,nAppearance;

	nRace = GetRacialType(oSpawn);
	nSubrace = GetSubRace(oSpawn);
	nGender = GetGender(oSpawn);

	if (bChangeApp) {
		nAppearance = GetSubraceAppearance(nSubrace);

		if (nAppearance != APPEARANCE_TYPE_INVALID)
			SetCreatureAppearanceType(oSpawn, nAppearance);
	}
	
	
	if (nHead != ACR_FEATURE_TYPE_RANDOM && nHead != 0)
		nHeadModel = nHead;
	else
		nHeadModel = GetRandomHeadModel(nSubrace, nGender);	

	if (nHair != ACR_FEATURE_TYPE_RANDOM)
		nHairModel = nHair;
	else
		nHairModel = GetRandomHairModel(nSubrace, nGender);

	nRandHair = Random(ACR_NUM_DEFAULT_FEATURE_COLOURS);

	if (nHair1 == ACR_FEATURE_TYPE_RANDOM)
		nHair1 = nRandHair;

	if (nHair2 == ACR_FEATURE_TYPE_RANDOM)
		nHair2 = nRandHair;

	if (nBHair == ACR_FEATURE_TYPE_RANDOM)
		nBHair = nRandHair;

	string sHair1 = GetRandomTint(nSubrace, 1, nHair1);
	string sHair2 = GetRandomTint(nSubrace, 2, nHair2);
	string sAHair = GetRandomTint(nSubrace, 3, nAHair);
	string sSkin  = GetRandomTint(nSubrace, 4, nSkin);
	string sEyes  = GetRandomTint(nSubrace, 5, nEyes);
	string sBHair = GetRandomTint(nSubrace, 6, nBHair);

#ifdef _DEBUG_ZS
	PrintInt(nAppearance);
	PrintInt(nHeadModel);
	PrintInt(nHairModel);
	PrintString(sHair1);
	PrintString(sHair2);
	PrintString(sAHair);
	PrintString(sBHair);
	PrintString(sEyes);
	PrintString(sSkin);

	SetLocalInt(oSpawn, "ZS_APP_TYPE", nAppearance);
	SetLocalInt(oSpawn, "ZS_MODEL_HEAD", nHeadModel);
	SetLocalInt(oSpawn, "ZS_MODEL_HAIR", nHairModel);
	SetLocalString(oSpawn, "ZS_TINT_HAIR1", sHair1);
	SetLocalString(oSpawn, "ZS_TINT_HAIR2", sHair2);
	SetLocalString(oSpawn, "ZS_TINT_AHAIR", sAHair);
	SetLocalString(oSpawn, "ZS_TINT_BHAIR", sBHair);
	SetLocalString(oSpawn, "ZS_TINT_EYES", sEyes);
	SetLocalString(oSpawn, "ZS_TINT_SKIN", sSkin);
#endif
		
	float fHair1r = HexStringToFloat(GetStringLeft(sHair1, 2)) / 255.0f;
	float fHair1g = HexStringToFloat(GetStringLeft(GetStringRight(sHair1, 4), 2)) / 255.0f;
	float fHair1b = HexStringToFloat(GetStringRight(sHair1, 2)) / 255.0f;

	float fHair2r = HexStringToFloat(GetStringLeft(sHair2, 2)) / 255.0f;
	float fHair2g = HexStringToFloat(GetStringLeft(GetStringRight(sHair2, 4), 2)) / 255.0f;
	float fHair2b = HexStringToFloat(GetStringRight(sHair2, 2)) / 255.0f;	

	float fAHairr = HexStringToFloat(GetStringLeft(sAHair, 2)) / 255.0f;
	float fAHairg = HexStringToFloat(GetStringLeft(GetStringRight(sAHair, 4), 2)) / 255.0f;
	float fAHairb = HexStringToFloat(GetStringRight(sAHair, 2)) / 255.0f;

	float fSkinr  = HexStringToFloat(GetStringLeft(sSkin, 2)) / 255.0f;
	float fSking  = HexStringToFloat(GetStringLeft(GetStringRight(sSkin, 4), 2)) / 255.0f;
	float fSkinb  = HexStringToFloat(GetStringRight(sSkin, 2)) / 255.0f;

	float fEyesr  = HexStringToFloat(GetStringLeft(sEyes, 2)) / 255.0f;
	float fEyesg  = HexStringToFloat(GetStringLeft(GetStringRight(sEyes, 4), 2)) / 255.0f;
	float fEyesb  = HexStringToFloat(GetStringRight(sEyes, 2)) / 255.0f;	

	float fBHairr = HexStringToFloat(GetStringLeft(sEyes, 2)) / 255.0f;
	float fBHairg = HexStringToFloat(GetStringLeft(GetStringRight(sEyes, 4), 2)) / 255.0f;
	float fBHairb = HexStringToFloat(GetStringRight(sEyes, 2)) / 255.0f;

	// Models
	XPObjectAttributesSetHeadVariation(oSpawn, nHeadModel);
	XPObjectAttributesSetHairVariation(oSpawn, nHairModel);

	// Facial hair
	XPObjectAttributesSetFacialHairVariation(oSpawn, (ACR_RandomFloat() >= fFHair));

	// Hair tint
	XPObjectAttributesSetHairTint(oSpawn, 
		CreateXPObjectAttributes_TintSet(
			CreateXPObjectAttributes_Color(fAHairr, fAHairg, fAHairb, 1.0f),
			CreateXPObjectAttributes_Color(fHair1r, fHair1g, fHair1b, 1.0f),
			CreateXPObjectAttributes_Color(fHair2r, fHair2g, fHair2b, 1.0f)));

	// Head tint
	XPObjectAttributesSetHeadTint(oSpawn, 
		CreateXPObjectAttributes_TintSet(
			CreateXPObjectAttributes_Color(fSkinr,  fSking,  fSkinb, 1.0f),
			CreateXPObjectAttributes_Color(fEyesr,  fEyesg,  fEyesb, 1.0f),
			CreateXPObjectAttributes_Color(fBHairr, fBHairg, fBHairb, 1.0f)));

	// Body tint
	XPObjectAttributesSetBodyTint(oSpawn,
		CreateXPObjectAttributes_TintSet(
			CreateXPObjectAttributes_Color(fSkinr,  fSking,  fSkinb, 1.0f),
			CreateXPObjectAttributes_Color(fAHairr, fAHairg, fAHairb, 1.0f),
			CreateXPObjectAttributes_Color(fEyesr,  fEyesg,  fEyesb, 1.0f)));
}


void ResetModel(object o)
{
	effect e;
	SetScriptHidden(o,1);
	e = EffectPolymorph(POLYMORPH_TYPE_CHICKEN,1);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, e, o, 0.0f);
	DelayCommand(0.1f,SetScriptHidden(o,0));
}

void SetFacialHair(object o, int arg=1)
{
	SendMessageToPC(o,"Selected facial hair "+IntToString(arg));

	XPObjectAttributesSetFacialHairVariation(o, arg);
	ResetModel(o);
}

void SetNextValidModel(object o, int dir=1, int type=0)
{
	string lst,s_cur,s_lst_tag,s_cur_tag;
	int cur;

	switch (type) {
		// head
		case 0:
			s_lst_tag = "ACR_APP_VALID_HEADS";
			s_cur_tag = "ACR_APP_CUR_HEAD";
			break;
		// hair
		case 1:
			s_lst_tag = "ACR_APP_VALID_HAIRS";
			s_cur_tag = "ACR_APP_CUR_HAIR";
			break;
		// wing
		case 2:
			s_lst_tag = "ACR_APP_VALID_WINGS";
			s_cur_tag = "ACR_APP_CUR_WING";
			break;
		// tail
		case 3:
			s_lst_tag = "ACR_APP_VALID_TAILS";
			s_cur_tag = "ACR_APP_CUR_TAIL";
			break;
	}

	lst = GetLocalString(o, s_lst_tag);
	s_cur = GetLocalString(o, s_cur_tag);

	// set initial
	if (lst == "") {

		switch (type) {
			case 0:
				lst = GetValidHeadModels(GetSubRace(o), GetGender(o));
				break;
			case 1:
				lst = GetValidHairModels(GetSubRace(o), GetGender(o));
				break;
			case 2:
				lst = IntervalToList("[0-26]");
				break;
			case 3:
				lst = IntervalToList("[0-11]");
				break;
		}

		SetLocalString(o, s_lst_tag, lst);
	}

	if (s_cur == "")
		cur = 1;
	else
		cur = StringToInt(s_cur);

	// dir=1 forward, else reverse
	if (dir)
		cur = GetNextEntryInStringList(lst, cur);
	else
		cur = GetPreviousEntryInStringList(lst, cur);

	SetLocalString(o, s_cur_tag, IntToString(cur));

	switch (type) {
		case 0:
			XPObjectAttributesSetHeadVariation(o, cur);
			break;
		case 1:
			XPObjectAttributesSetHairVariation(o, cur);
			break;
		case 2:
			XPObjectAttributesSetWingVariation(o, cur);
			break;
		case 3:
			XPObjectAttributesSetTailVariation(o, cur);
			break;
	}

	ResetModel(o);

	DelayCommand(0.1f, SendMessageToPC(o,"Selected model "+IntToString(cur)));
}

void SetNextValidHeadModel(object o, int dir=1)
{
	SetNextValidModel(o,dir,0);
}

void SetNextValidHairModel(object o, int dir=1)
{
	SetNextValidModel(o,dir,1);
}

void SetNextValidWingModel(object o, int dir=1)
{
	SetNextValidModel(o,dir,2);
}

void SetNextValidTailModel(object o, int dir=1)
{
	SetNextValidModel(o,dir,3);
}

void ApplyTintToType(object o)
{
	struct XPObjectAttributes_TintSet tints;
	float r,g,b,a;

	switch (GetLocalInt(o, "ACR_APP_TYPE")) {
		case ACR_APP_TYPE_HAIR_ACC:
		case ACR_APP_TYPE_HAIR_LO:
		case ACR_APP_TYPE_HAIR_HI:
			tints = GetHairTintSet(o);
			break;
		case ACR_APP_TYPE_HEAD_SKIN:
		case ACR_APP_TYPE_HEAD_EYE:
		case ACR_APP_TYPE_HEAD_HAIR:
			tints = GetSkinTintSet(o);
			break;
		case ACR_APP_TYPE_BASE_SKIN:
		case ACR_APP_TYPE_BASE_HAIR:
		case ACR_APP_TYPE_BASE_EYE:
			tints = GetBaseTintSet(o);
			break;
	}

	r = GetLocalInt(o, "ACR_APP_TINT_R") / 255.0f;
	g = GetLocalInt(o, "ACR_APP_TINT_G") / 255.0f;
	b = GetLocalInt(o, "ACR_APP_TINT_B") / 255.0f;
	a = GetLocalInt(o, "ACR_APP_TINT_A") / 255.0f;


	switch (GetLocalInt(o, "ACR_APP_TYPE")) {
		case ACR_APP_TYPE_HAIR_ACC:
		case ACR_APP_TYPE_HEAD_SKIN:
		case ACR_APP_TYPE_BASE_SKIN:
			tints.Tint0_r = r;
			tints.Tint0_g = g;
			tints.Tint0_b = b;
			tints.Tint0_a = a;
			break;
		case ACR_APP_TYPE_HAIR_LO:
		case ACR_APP_TYPE_HEAD_EYE:
		case ACR_APP_TYPE_BASE_HAIR:
			tints.Tint1_r = r;
			tints.Tint1_g = g;
			tints.Tint1_b = b;
			tints.Tint1_a = a;
			break;
		case ACR_APP_TYPE_HAIR_HI:
		case ACR_APP_TYPE_HEAD_HAIR:
		case ACR_APP_TYPE_BASE_EYE:
			tints.Tint2_r = r;
			tints.Tint2_g = g;
			tints.Tint2_b = b;
			tints.Tint2_a = a;
			break;
	}


	switch (GetLocalInt(o, "ACR_APP_TYPE")) {
		case ACR_APP_TYPE_HAIR_ACC:
		case ACR_APP_TYPE_HAIR_LO:
		case ACR_APP_TYPE_HAIR_HI:
			XPObjectAttributesSetHairTint(o, tints);
			break;
		case ACR_APP_TYPE_HEAD_SKIN:
		case ACR_APP_TYPE_HEAD_EYE:
		case ACR_APP_TYPE_HEAD_HAIR:
			XPObjectAttributesSetHeadTint(o, tints);
			break;
		case ACR_APP_TYPE_BASE_SKIN:
		case ACR_APP_TYPE_BASE_HAIR:
		case ACR_APP_TYPE_BASE_EYE:
			XPObjectAttributesSetBodyTint(o, tints);
			break;
	}

	ResetModel(o);
}


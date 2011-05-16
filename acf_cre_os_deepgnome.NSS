////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_cre_onspawnin
//    $Revision:: 280        $ current version of the file
//        $Date:: 2007-03-20#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnSpawnIn event handler for creatures
//  and any custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_creature_i"

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Variables ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

///////FLOCKING CODE REMOVED - SAND////////////////


void main()
{
    ACR_CreatureOnSpawnIn();
	
	///RANDOM SCALE///
	float fX=(GetScale(OBJECT_SELF,SCALE_X)-0.05)+(IntToFloat(d10(1))/100);
	float fY=(GetScale(OBJECT_SELF,SCALE_Y)-0.05)+(IntToFloat(d10(1))/100);
	float fZ=(GetScale(OBJECT_SELF,SCALE_Z)-0.05)+(IntToFloat(d10(1))/100);
	SetScale(OBJECT_SELF,fX,fY,fZ);
	
	
	///RANDOM EQUIP/////
	int rCloth=d20(1);
	string sArmType;
	int rBoots=d10(1);
	string sBootType;
	
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
	AssignCommand(OBJECT_SELF,ActionEquipItem(oArmour,1));
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
	AssignCommand(OBJECT_SELF,ActionEquipItem(oBoots,2)); 

}
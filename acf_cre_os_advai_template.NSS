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

/*
This is a template for custom on spawn scripts utilising
the advanced AI system.

You can enter random equipment and scale vaules in the relevant sections
The NPC will then utilise this information to equip itself from your palette.

The advanced AI system will adjust the creatures AI to match its random loadout.
To ensure correct loadout for the creature ensure that any weapons are equipped to it.

REFER TO README FILE FOR INSTRUCTIONS
*/


////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_creature_i_advanced"

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

//what is the percentage chance the creature will use a spell, special ability or active feat
//in any given round. Note setting this at 100 does not mean the creature will definately
//use such an ability, just that the chance of it being considered as an option in each round
//is 100%.
int USE_SPECIAL_ABILITY=75;

//do you want the creature to spawn with its main weapon equipped or in inventory?
int EQUIP_WEAPON=TRUE;

//The percentage chance the NPC will spawn with its alternate weapon, this is designed to allow the creature
//to be spawned as an archer. If this is the case then the Lhand and Rhand items will not be equipped
//but will be kept in inventory. If you spawn a missile weapon make sure the NPC has ammo as well
int ALT_WEAPON=0;

//sets the amount of random scale variation the creature can have.
//To prevent bizarre appearance this should not be over 0.15.
//x,y,z dimension are each calculated separatley
float VARIANCE=0.05;

//strings for random equipment
//five entries are provided for each category
//if you want one item to appear more than others, simple enter it multiple time in the list
//if you leave a string empty then that will result in a chane that the creature has no item
//generated for that slot.
//the string must be the resref of the item you wish to equip to the creature.
//setting the first variable in each category to FALSE will mean the craeture does not generate
//any items for that slot.

//ARMOUR
int GENERATE_ARMOUR=TRUE;
string ARM_1="";
string ARM_2="";
string ARM_3="";
string ARM_4="";
string ARM_5="";
string ARM_6="";
string ARM_7="";
string ARM_8="";
string ARM_9="";
string ARM_10="";

//HEAD
int GENERATE_HEAD=TRUE;
string HEAD_1="";
string HEAD_2="";
string HEAD_3="";
string HEAD_4="";
string HEAD_5="";

//GLOVES
int GENERATE_GLOVES=TRUE;
string GLOVES_1="";
string GLOVES_2="";
string GLOVES_3="";
string GLOVES_4="";
string GLOVES_5="";

//BOOTS
int GENERATE_BOOTS=TRUE;
string BOOTS_1="";
string BOOTS_2="";
string BOOTS_3="";
string BOOTS_4="";
string BOOTS_5="";

//LEFT HAND - shields mainly, creature will not equip an off hand weapon if it doesnt have a primary weapon
//and will unequip a shield if it equips a two handed weapon and does not have "monkey grip" feat
int GENERATE_LHAND=TRUE;
string LHAND_1="";
string LHAND_2="";
string LHAND_3="";
string LHAND_4="";
string LHAND_5="";

//RIGHT HAND - Weapons
int GENERATE_RHAND=TRUE;
string RHAND_1="";
string RHAND_2="";
string RHAND_3="";
string RHAND_4="";
string RHAND_5="";

//ALT WEAPON
string ALT1="";
string ALT2="";
string ALT3="";
string ALT4="";
string ALT5="";

//CLOAK
int GENERATE_CLOAK=TRUE;
string CLOAK_1="";
string CLOAK_2="";
string CLOAK_3="";
string CLOAK_4="";
string CLOAK_5="";

//AMMO
int GENERATE_AMMO=TRUE;
string AMMO_1="";
string AMMO_2="";
string AMMO_3="";
string AMMO_4="";
string AMMO_5="";



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

void main()
{
    ///RANDOM SCALE///
	float fX=(GetScale(OBJECT_SELF,SCALE_X)-VARIANCE)+(IntToFloat(d10(1))/100);
	float fY=(GetScale(OBJECT_SELF,SCALE_Y)-VARIANCE)+(IntToFloat(d10(1))/100);
	float fZ=(GetScale(OBJECT_SELF,SCALE_Z)-VARIANCE)+(IntToFloat(d10(1))/100);
	SetScale(OBJECT_SELF,fX,fY,fZ);
	
	//RANDOM EQUIP//
	int iARM=Random(10)+1;string sARM;
	int iHEAD=Random(5)+1;string sHEAD;
	int iGLOVES=Random(5)+1;string sGLOVES;
	int iBOOTS=Random(5)+1;string sBOOTS;
	int iLHAND=Random(5)+1;string sLHAND;
	int iRHAND=Random(5)+1;string sRHAND;
	int iCLOAK=Random(5)+1;string sCLOAK;
	int iAMMO=Random(5)+1;string sAMMO;
	int iALT=Random(5)+1;string sALT;
	int ALT_CHANCE;
	
if (ALT_WEAPON>0)
	{
	ALT_CHANCE=d100(1);
	}	
			
if (GENERATE_ARMOUR==1){switch (iARM){
		case 1:sARM=ARM_1;break;case 2:sARM=ARM_2;break;case 3:sARM=ARM_3;break;case 4:sARM=ARM_4;break;
		case 5:sARM=ARM_5;break;case 6:sARM=ARM_6;break;case 7:sARM=ARM_7;break;case 8:sARM=ARM_8;break;
		case 9:sARM=ARM_9;break;case 10:sARM=ARM_10;break;}
	object oARM=CreateItemOnObject(sARM);
	AssignCommand(OBJECT_SELF,ActionEquipItem(oARM,1));}

if (GENERATE_HEAD==1){switch (iHEAD){
		case 1:sHEAD=HEAD_1;break;case 2:sHEAD=HEAD_2;break;case 3:sHEAD=HEAD_3;break;
		case 4:sHEAD=HEAD_4;break;case 5:sHEAD=HEAD_5;break;}
	object oHEAD=CreateItemOnObject(sHEAD);
	AssignCommand(OBJECT_SELF,ActionEquipItem(oHEAD,0));}
	
if (GENERATE_GLOVES==1){switch (iGLOVES){
		case 1:sGLOVES=GLOVES_1;break;case 2:sGLOVES=GLOVES_2;break;case 3:sGLOVES=GLOVES_3;break;
		case 4:sGLOVES=GLOVES_4;break;case 5:sGLOVES=GLOVES_5;break;}
	object oGLOVES=CreateItemOnObject(sGLOVES);
	AssignCommand(OBJECT_SELF,ActionEquipItem(oGLOVES,3));}
	
if (GENERATE_BOOTS==1){switch (iBOOTS){
		case 1:sBOOTS=BOOTS_1;break;case 2:sBOOTS=BOOTS_2;break;case 3:sBOOTS=BOOTS_3;break;
		case 4:sBOOTS=BOOTS_4;break;case 5:sBOOTS=BOOTS_5;break;}
	object oBOOTS=CreateItemOnObject(sBOOTS);
	AssignCommand(OBJECT_SELF,ActionEquipItem(oBOOTS,2));}
	
if (GENERATE_LHAND==1){switch (iLHAND){
		case 1:sLHAND=LHAND_1;break;case 2:sLHAND=LHAND_2;break;case 3:sLHAND=LHAND_3;break;
		case 4:sLHAND=LHAND_4;break;case 5:sLHAND=LHAND_5;break;}
	object oLHAND=CreateItemOnObject(sLHAND);
	
	if (ALT_CHANCE>=ALT_WEAPON)
		{
		AssignCommand(OBJECT_SELF,ActionEquipItem(oLHAND,5));
		}
	}
	
if (GENERATE_RHAND==1){switch (iRHAND){
		case 1:sRHAND=RHAND_1;break;case 2:sRHAND=RHAND_2;break;case 3:sRHAND=RHAND_3;break;
		case 4:sRHAND=RHAND_4;break;case 5:sRHAND=RHAND_5;break;}
	object oRHAND=CreateItemOnObject(sRHAND);
	
	if((EQUIP_WEAPON==TRUE)&&(ALT_CHANCE>=ALT_WEAPON))
	{
	AssignCommand(OBJECT_SELF,ActionEquipItem(oRHAND,4));
	}
	}
	
if (ALT_CHANCE<ALT_WEAPON)
	{
	switch (iALT)
		{
		case 1:sALT=ALT1;break;
		case 2:sALT=ALT2;break;
		case 3:sALT=ALT3;break;
		case 4:sALT=ALT4;break;
		case 5:sALT=ALT5;break;
		}
	object oALT=CreateItemOnObject(sALT);
	
	if(EQUIP_WEAPON==TRUE)
		{	
		AssignCommand(OBJECT_SELF,ActionEquipItem(oALT,4));
		}
	SetLocalInt(OBJECT_SELF,"X4_L_AI_COMBAT_RANGED",1);
	}	

if (GENERATE_CLOAK==1){switch (iCLOAK){
		case 1:sCLOAK=CLOAK_1;break;case 2:sCLOAK=CLOAK_2;break;case 3:sCLOAK=CLOAK_3;break;
		case 4:sCLOAK=CLOAK_4;break;case 5:sCLOAK=CLOAK_5;break;}
	object oCLOAK=CreateItemOnObject(sCLOAK);
	AssignCommand(OBJECT_SELF,ActionEquipItem(oCLOAK,6));}
	
if (GENERATE_AMMO==1){switch (iAMMO){
		case 1:sAMMO=AMMO_1;break;case 2:sAMMO=AMMO_2;break;case 3:sAMMO=AMMO_3;break;
		case 4:sAMMO=AMMO_4;break;case 5:sAMMO=AMMO_5;break;}
	object oAMMO=CreateItemOnObject(sAMMO);
	AssignCommand(OBJECT_SELF,ActionEquipItem(oAMMO,11));}	

SetLocalInt(OBJECT_SELF,"X2_L_BEH_MAGIC",USE_SPECIAL_ABILITY);	
				
	ACR_CreatureOnSpawnIn();
}
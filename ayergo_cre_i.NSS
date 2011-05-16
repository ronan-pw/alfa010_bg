////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_cre_ondeath
//    $Revision:: 280        $ current version of the file
//        $Date:: 2007-03-20#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnDeath event handler for creatures and
//  any custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

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

void ayergo1()
{

    int i = 0;
	int loot = 0;
    for(i=0;i<Random(2);i++){
	loot = Random(8);
	if(loot == 0) CreateItemOnObject("nw_it_gold001",OBJECT_SELF);
	else if(loot == 1) CreateItemOnObject("abr_it_wpn_dagger_1",OBJECT_SELF);
    else if(loot == 2) CreateItemOnObject("nw_it_gold001",OBJECT_SELF);
	else if(loot == 3) CreateItemOnObject("nw_it_gold001",OBJECT_SELF);
	else if(loot == 4) CreateItemOnObject("abr_it_wpn_dagger_1",OBJECT_SELF);
	else if(loot == 5) CreateItemOnObject("nw_wblcl001",OBJECT_SELF);
	else if(loot == 6) CreateItemOnObject("nw_it_gem003",OBJECT_SELF);
	else if(loot == 7) CreateItemOnObject("nw_it_gem001",OBJECT_SELF);
	}
	
	if(Random(100) >= 92) CreateItemOnObject("abr_it_mpotion01",OBJECT_SELF);
	if(Random(100) >= 92) CreateItemOnObject("nw_it_mring021",OBJECT_SELF);

    // Custom code goes here.
}

void ayergo2()
{
    int i = 0;
	int loot = 0;
	for(i=0;i<(Random(3)+1);i++){
	loot = Random(10);
	if(loot == 0) CreateItemOnObject("nw_it_gold001",OBJECT_SELF);
	else if(loot == 1) CreateItemOnObject("abr_it_mpotion_bless",OBJECT_SELF);  //bless potion
    else if(loot == 2) CreateItemOnObject("nw_it_gold001",OBJECT_SELF);
	else if(loot == 3) CreateItemOnObject("nw_it_gold001",OBJECT_SELF);
	else if(loot == 4) CreateItemOnObject("abr_it_mpotion_aid",OBJECT_SELF);  //aid potion
	else if(loot == 5) CreateItemOnObject("nw_wplhb001",OBJECT_SELF);		//halberd
	else if(loot == 6) CreateItemOnObject("nw_it_gem003",OBJECT_SELF);
	else if(loot == 7) CreateItemOnObject("nw_it_gem001",OBJECT_SELF);
	else if(loot == 8) CreateItemOnObject("nw_waxbt001",OBJECT_SELF);		//battleax
	else if(loot == 9) CreateItemOnObject("nw_aarcl010",OBJECT_SELF);
	}
	
	if(Random(100) >= 84) CreateItemOnObject("abr_it_mpotion01",OBJECT_SELF); //clw
	if(Random(100) >= 84) CreateItemOnObject("nw_it_mneck020",OBJECT_SELF);   //copper necklace

}

void crab(){
  CreateItemOnObject("it_dcrab",OBJECT_SELF);

}
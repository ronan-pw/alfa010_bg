////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_trg_onenter.nss
//    $Revision:: 236        $ current version of the file
//        $Date:: 2007-01-21#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnEnter code for triggers, and any
//  custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
//  2007/01/20  Cipher  Inception
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_creature_i"
#include "acr_spawn_i"



void main()
{
   
    // Custom code goes here.
			object oDM = OBJECT_SELF;
	        object oFlocker = GetLocalObject(oDM, "Object_Target");
			int iRadius;
			int iArea;
			if(oFlocker != OBJECT_INVALID)
				{SetLocalInt(oFlocker, "ACR_FLOCKING", 0);
				 iRadius = GetLocalInt(oDM, "iRadiusFlocking");
				 iArea = GetLocalInt(oDM, "iAreaFlocking");
				 } 
	        if(oFlocker == OBJECT_INVALID)
				{oFlocker = OBJECT_SELF;
				}		
			object oRandom1 = GetLocalObject(oFlocker, "oRandom1");
			object oRandom2 = GetLocalObject(oFlocker, "oRandom2");
			object oRandom3 = GetLocalObject(oFlocker, "oRandom3");
			object oRandom4 = GetLocalObject(oFlocker, "oRandom4");
			object oRandom5 = GetLocalObject(oFlocker, "oRandom5");
			object oRandom6 = GetLocalObject(oFlocker, "oRandom6");
			
			
			//Toggle off functions for Omega Wand
									if(GetLocalInt(oFlocker, "ACR_FLOCKING") != 1)
										{ClearAllActions(TRUE);
										 SetLocalObject(oFlocker, "oRandom1", OBJECT_INVALID);
										 SetLocalObject(oFlocker, "oRandom2", OBJECT_INVALID);
										 SetLocalObject(oFlocker, "oRandom3", OBJECT_INVALID);
										 SetLocalObject(oFlocker, "oRandom4", OBJECT_INVALID);
										 SetLocalObject(oFlocker, "oRandom5", OBJECT_INVALID);
										 SetLocalObject(oFlocker, "oRandom6", OBJECT_INVALID);
										 SetLocalInt(oFlocker, "Flocked", 0);
								 		 SendMessageToPC(oDM, GetName(oFlocker) + " flocking off");
										 if(iRadius != 0)
											{object oChild = GetFirstObjectInShape(SHAPE_SPHERE, 25.0, GetLocation(oFlocker), FALSE, OBJECT_TYPE_CREATURE); 
					 						 while(oChild != OBJECT_INVALID) 
												{if((GetIsPC(oChild) == FALSE) && (GetLocalInt(oChild, "Flocked") != 0))
													{SendMessageToPC(oDM, GetName(oChild) + " flocking off");
								 					 ClearAllActions(TRUE);
													 SetLocalObject(oChild, "oRandom1", OBJECT_INVALID);
													 SetLocalObject(oChild, "oRandom2", OBJECT_INVALID);
													 SetLocalObject(oChild, "oRandom3", OBJECT_INVALID);
													 SetLocalObject(oChild, "oRandom4", OBJECT_INVALID);
													 SetLocalObject(oChild, "oRandom5", OBJECT_INVALID);
													 SetLocalObject(oChild, "oRandom6", OBJECT_INVALID);
													 SetLocalInt(oChild, "ACR_FLOCKING", 0);
				 									 SetLocalInt(oChild, "Flocked", 0);
											 		 }
											 	oChild = GetNextObjectInShape(SHAPE_SPHERE, 25.0, GetLocation(oFlocker), FALSE, OBJECT_TYPE_CREATURE);
												}
											 SetLocalInt(oDM, "iRadiusFlocking", 0);
											 }
										else if(iArea != 0)
											{object oChild = GetFirstObjectInArea(GetArea(oFlocker)); 
					 						 while(oChild != OBJECT_INVALID) 
												{if((GetObjectType(oChild) == OBJECT_TYPE_CREATURE) && (GetIsPC(oChild) == FALSE) && (GetLocalInt(oChild, "Flocked") != 0))
													{SendMessageToPC(oDM, GetName(oChild) + " flocking off");
								 					 ClearAllActions(TRUE);
													 SetLocalObject(oChild, "oRandom1", OBJECT_INVALID);
													 SetLocalObject(oChild, "oRandom2", OBJECT_INVALID);
													 SetLocalObject(oChild, "oRandom3", OBJECT_INVALID);
													 SetLocalObject(oChild, "oRandom4", OBJECT_INVALID);
													 SetLocalObject(oChild, "oRandom5", OBJECT_INVALID);
													 SetLocalObject(oChild, "oRandom6", OBJECT_INVALID);
													 SetLocalInt(oChild, "ACR_FLOCKING", 0);
				 									 SetLocalInt(oChild, "Flocked", 0);
											 		 }
											 	oChild = GetNextObjectInArea(GetArea(oFlocker));
												}
											 SetLocalInt(oDM, "iAreaFlocking", 0);
											 }
										return;
									 	}
			
			
			
			
			//Toggle on functions for spawn event and Omega Wand
			object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oFlocker, 1);
			int iNearest = 1;
			object oStore = GetLocalObject(oPC, "ACR_STORE");
			if(IsInConversation(oFlocker) == TRUE)
				{ClearAllActions(TRUE);
			 	 }
			else if((IsInConversation(oFlocker) != TRUE) && (oStore == OBJECT_INVALID))
				{while(oPC != OBJECT_INVALID)
					{oStore = GetLocalObject(oPC, "ACR_STORE");
					 if(oStore != OBJECT_INVALID)
						{ClearAllActions(TRUE);
						 break;
						 }
					 else
					 	{iNearest++;
						 oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oFlocker, iNearest);
						}
					 }
				
				 if(oStore == OBJECT_INVALID)
				 	{int iLoop = 1;
					 while(iLoop < 2)
						{int iRep = GetLocalInt(oFlocker, "iRep");
						 object oRandom;
						 if(iRep < 7)
						 	{if(iRep == 0)
							 	{oRandom = oRandom1;
								 SetLocalInt(oFlocker, "iRep", 1);
								 }
							 else if(iRep == 1)
							 	{oRandom = oRandom2;
								 SetLocalInt(oFlocker, "iRep", 2);
								 }
							 else if(iRep == 2)
							 	{oRandom = oRandom3;
								 SetLocalInt(oFlocker, "iRep", 3);
								 }
							 else if(iRep == 3)
							 	{oRandom = oRandom4;
								 SetLocalInt(oFlocker, "iRep", 4);
								 }
							 else if(iRep == 4)
							 	{oRandom = oRandom5;
								 SetLocalInt(oFlocker, "iRep", 5);
								 }
							 else if(iRep == 5)
							 	{oRandom = oRandom6;
								 SetLocalInt(oFlocker, "iRep", 6);
								 }
							else if(iRep == 6)
							 	{iRep = 1;
								 oRandom = oRandom1;
								 SetLocalInt(oFlocker, "iRep", 1);
								 }
							
							if((GetIsInCombat(oFlocker) == FALSE) && (GetLocalInt(oFlocker, "ACR_FLOCKING") == 1))
								{ClearAllActions(FALSE);
								 ActionMoveToObject(oRandom, FALSE, 0.5);
								 DelayCommand(IntToFloat(Random(60) + 15), ExecuteScript("acf_cre_flocking", oFlocker));
								 }
							}	
						
						iLoop ++;
						}
					}
				}
	
			
}
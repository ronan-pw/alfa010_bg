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

void main()
{
    ACR_CreatureOnSpawnIn();
	
	
	//create one of the two types of fist chain armour, and one of three of the relevant types of helmet
	//an equip them to the NPC
	int D2=d2(1);
	int D3=d3(1);
	string sArmType;
	string sHelmType;
	switch (D2)
		{
		case 1:sArmType="010_it_ffchain01";break;
		case 2:sArmType="010_it_ffchain02";break;
		}
	switch (D3)
		{
		case 1:sHelmType="010_it_helm_kettle";break;
		case 2:sHelmType="010_it_helm_chain";break;
		case 3:sHelmType="010_it_helm_nasal";break;
		}
	object oArmour=CreateItemOnObject(sArmType);
	object oHelmet=CreateItemOnObject(sHelmType);
	AssignCommand(OBJECT_SELF,ActionEquipItem(oArmour,1));
	AssignCommand(OBJECT_SELF,ActionEquipItem(oHelmet,0));
	
	
	

    // Custom code goes here.
			object oDM = OBJECT_SELF;
	        object oFlocker = GetLocalObject(oDM, "Object_Target");
			int iRadius;
			int iArea;
			if(oFlocker != OBJECT_INVALID)
				{SetLocalInt(oFlocker, "ACR_FLOCKING", 1);
				 iRadius = GetLocalInt(oDM, "iRadiusFlocking");
				 iArea = GetLocalInt(oDM, "iAreaFlocking");
				 }
	        if(oFlocker == OBJECT_INVALID)
				{oFlocker = OBJECT_SELF;
				}		
				 
	
	
	if(GetLocalInt(oFlocker, "ACR_FLOCKING") == 1) 
		{object oMobDestination = GetNearestObject(OBJECT_TYPE_ALL, oFlocker, 1);
		 string sArea = GetName(GetArea(oFlocker));
		 //Set the flocking destinations and execute the flocking script	
		 int iRep = 1;
		 object oRandom1 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 2);
		 if((FindSubString(GetName(oRandom1), "Sky") != -1) || (FindSubString(GetName(oRandom1), "Walkmesh") != -1))
				{oRandom1 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 2);
				}
		 object oRandom2 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 2);
		 if((FindSubString(GetName(oRandom2), "Sky") != -1) || (FindSubString(GetName(oRandom2), "Walkmesh") != -1))
				{oRandom2 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 2);
		    	}
		 if(oRandom2 == oRandom1)
				{oRandom2 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 2);
				 if((FindSubString(GetName(oRandom2), "Sky") != -1) || (FindSubString(GetName(oRandom2), "Walkmesh") != -1))
						{oRandom2 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 2);
				    	}
				}
		 object oRandom3 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 3);
		 if((FindSubString(GetName(oRandom3), "Sky") != -1) || (FindSubString(GetName(oRandom3), "Walkmesh") != -1))
				{oRandom3 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 3);
				}
		 if((oRandom3 == oRandom1) || (oRandom3 == oRandom2))
				{oRandom3 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 3);
				 if((FindSubString(GetName(oRandom2), "Sky") != -1) || (FindSubString(GetName(oRandom3), "Walkmesh") != -1))
						{oRandom3 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 3);
			   			}
				}
			object oRandom4 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 4);
			if((FindSubString(GetName(oRandom4), "Sky") != -1) || (FindSubString(GetName(oRandom4), "Walkmesh") != -1))
				{oRandom4 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 4);
			   	}
			if((oRandom4 == oRandom1)  || (oRandom4 == oRandom2)|| (oRandom4 == oRandom3))
				{oRandom4 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 4);
				if((FindSubString(GetName(oRandom4), "Sky") != -1) || (FindSubString(GetName(oRandom4), "Walkmesh") != -1))
					{oRandom4 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 4);
				   	}
				}
			object oRandom5 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
			if((FindSubString(GetName(oRandom5), "Sky") != -1) || (FindSubString(GetName(oRandom5), "Walkmesh") != -1))
				{oRandom5 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
			   	}
			if((oRandom5 == oRandom1) || (oRandom5 == oRandom4)|| (oRandom5 == oRandom3)|| (oRandom5 == oRandom2))
					{oRandom5 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
					if((FindSubString(GetName(oRandom5), "Sky") != -1) || (FindSubString(GetName(oRandom5), "Walkmesh") != -1))
						{oRandom5 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
			    		}
					}
			object oRandom6 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 6);
			if((FindSubString(GetName(oRandom6), "Sky") != -1) || (FindSubString(GetName(oRandom6), "Walkmesh") != -1))
					{oRandom6 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 6);
			    	}
			if((oRandom6 == oRandom1) || (oRandom6 == oRandom5) || (oRandom6 == oRandom4)|| (oRandom6 == oRandom3)|| (oRandom6 == oRandom2))
					{oRandom6 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 6);
					if((FindSubString(GetName(oRandom6), "Sky") != -1) || (FindSubString(GetName(oRandom6), "Walkmesh") != -1))
						{oRandom6 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 6);
				    	}
					}
			if(oRandom1 == OBJECT_INVALID)
					{oRandom1 = oMobDestination;
					}
			if(oRandom2 == OBJECT_INVALID)
					{oRandom2 = oMobDestination;
						}
			if(oRandom3 == OBJECT_INVALID)
					{oRandom3 = oMobDestination;
					}
			if(oRandom4 == OBJECT_INVALID)
					{oRandom4 = oMobDestination;
					}
			if(oRandom5 == OBJECT_INVALID)
					{oRandom5 = oMobDestination;
					}
			if(oRandom6 == OBJECT_INVALID)
					{oRandom6 = oMobDestination;
					}
						
						
			SendMessageToPC(oDM, GetName(oFlocker) + " flocking");
			SetLocalObject(oFlocker, "oRandom1", oRandom1);
			SetLocalObject(oFlocker, "oRandom2", oRandom2);
			SetLocalObject(oFlocker, "oRandom3", oRandom3);
			SetLocalObject(oFlocker, "oRandom4", oRandom4);
			SetLocalObject(oFlocker, "oRandom5", oRandom5);
			SetLocalObject(oFlocker, "oRandom6", oRandom6);
			SetLocalInt(oFlocker, "Flocked", 1);
			SetLocalInt(oFlocker, "ACR_FLOCKING", 1);
			DelayCommand(5.0, ExecuteScript("acf_cre_flocking", oFlocker));
						 
			object oChild = GetFirstObjectInShape(SHAPE_SPHERE, 25.0, GetLocation(oFlocker), FALSE, OBJECT_TYPE_CREATURE); 
		    if(iRadius != 0)
				{while(oChild != OBJECT_INVALID) 
					{if((GetIsPC(oChild) == FALSE) && (GetLocalInt(oChild, "Flocked") != 1))
						{SendMessageToPC(oDM, GetName(oChild) + " flocking");
						 SetLocalObject(oChild, "oRandom1", oRandom1);
						 SetLocalObject(oChild, "oRandom2", oRandom2);
						 SetLocalObject(oChild, "oRandom3", oRandom3);
						 SetLocalObject(oChild, "oRandom4", oRandom4);
						 SetLocalObject(oChild, "oRandom5", oRandom5);
						 SetLocalObject(oChild, "oRandom6", oRandom6);
						 SetLocalInt(oChild, "Flocked", 1);
						 SetLocalInt(oChild, "ACR_FLOCKING", 1);
				 		 DelayCommand(5.0, ExecuteScript("acf_cre_flocking", oChild));
						 }
					 oChild = GetNextObjectInShape(SHAPE_SPHERE, 25.0, GetLocation(oFlocker), FALSE, OBJECT_TYPE_CREATURE);
					}
					
					SetLocalInt(oDM, "iRadiusFlocking", 0);
				}
				if(iArea != 0)
								{object oChild = GetFirstObjectInArea(GetArea(oFlocker)); 
		 						 while(oChild != OBJECT_INVALID) 
									{if((GetObjectType(oChild) == OBJECT_TYPE_CREATURE) && (GetIsPC(oChild) == FALSE) && (GetLocalInt(oChild, "Flocked") == 0))
										{SendMessageToPC(oDM, GetName(oChild) + " flocking");
						 				 oRandom1 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oChild, Random(10));
										 if((FindSubString(GetName(oRandom1), "Sky") != -1) || (FindSubString(GetName(oRandom1), "Walkmesh") != -1))
												{oRandom1 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oChild, Random(10));
												}
										  oRandom2 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oChild, Random(10));
										 if((FindSubString(GetName(oRandom2), "Sky") != -1) || (FindSubString(GetName(oRandom2), "Walkmesh") != -1))
												{oRandom2 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oChild, Random(10));
										    	}
										 if(oRandom2 == oRandom1)
												{oRandom2 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oChild, Random(10));
												 if((FindSubString(GetName(oRandom2), "Sky") != -1) || (FindSubString(GetName(oRandom2), "Walkmesh") != -1))
														{oRandom2 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oChild, Random(10));
												    	}
												}
										  oRandom3 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oChild, Random(10));
										 if((FindSubString(GetName(oRandom3), "Sky") != -1) || (FindSubString(GetName(oRandom3), "Walkmesh") != -1))
												{oRandom3 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oChild, Random(10));
												}
										 if((oRandom3 == oRandom1) || (oRandom3 == oRandom2))
												{oRandom3 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oChild, Random(10));
												 if((FindSubString(GetName(oRandom2), "Sky") != -1) || (FindSubString(GetName(oRandom3), "Walkmesh") != -1))
														{oRandom3 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oChild, Random(10));
											   			}
												}
											 oRandom4 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oChild, Random(10));
											if((FindSubString(GetName(oRandom4), "Sky") != -1) || (FindSubString(GetName(oRandom4), "Walkmesh") != -1))
												{oRandom4 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oChild, Random(10));
											   	}
											if((oRandom4 == oRandom1)  || (oRandom4 == oRandom2)|| (oRandom4 == oRandom3))
												{oRandom4 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oChild, Random(10));
												if((FindSubString(GetName(oRandom4), "Sky") != -1) || (FindSubString(GetName(oRandom4), "Walkmesh") != -1))
													{oRandom4 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oChild, Random(10));
												   	}
												}
											 oRandom5 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oChild, Random(10));
											if((FindSubString(GetName(oRandom5), "Sky") != -1) || (FindSubString(GetName(oRandom5), "Walkmesh") != -1))
												{oRandom5 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oChild, Random(10));
											   	}
											if((oRandom5 == oRandom1) || (oRandom5 == oRandom4)|| (oRandom5 == oRandom3)|| (oRandom5 == oRandom2))
													{oRandom5 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oChild, Random(10));
													if((FindSubString(GetName(oRandom5), "Sky") != -1) || (FindSubString(GetName(oRandom5), "Walkmesh") != -1))
														{oRandom5 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oChild, Random(10));
											    		}
													}
											 oRandom6 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oChild, Random(10));
											if((FindSubString(GetName(oRandom6), "Sky") != -1) || (FindSubString(GetName(oRandom6), "Walkmesh") != -1))
													{oRandom6 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oChild, Random(10));
											    	}
											if((oRandom6 == oRandom1) || (oRandom6 == oRandom5) || (oRandom6 == oRandom4)|| (oRandom6 == oRandom3)|| (oRandom6 == oRandom2))
													{oRandom6 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oChild, Random(10));
													if((FindSubString(GetName(oRandom6), "Sky") != -1) || (FindSubString(GetName(oRandom6), "Walkmesh") != -1))
														{oRandom6 = GetNearestObject(OBJECT_TYPE_WAYPOINT |  OBJECT_TYPE_CREATURE, oChild, Random(10));
												    	}
													}
											
											 SetLocalObject(oChild, "oRandom1", oRandom1);
											 SetLocalObject(oChild, "oRandom2", oRandom2);
											 SetLocalObject(oChild, "oRandom3", oRandom3);
											 SetLocalObject(oChild, "oRandom4", oRandom4);
											 SetLocalObject(oChild, "oRandom5", oRandom5);
											 SetLocalObject(oChild, "oRandom6", oRandom6);
											 SetLocalInt(oChild, "Flocked", 1);
										 	 SetLocalInt(oChild, "ACR_FLOCKING", 1);
				 		 					 DelayCommand(5.0, ExecuteScript("acf_cre_flocking", oChild));
										 	}
								 	oChild = GetNextObjectInArea(GetArea(oFlocker));
									}
								 SetLocalInt(oDM, "iAreaFlocking", 0);
								  }
							}			 

}
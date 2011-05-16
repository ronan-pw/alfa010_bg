
 object oPC=GetExitingObject(); 
 object oCount=GetFirstItemInInventory(oPC); 
 int iCheck=GetLocalInt(oCount,"REMOVE_ON_AREA_EXIT"); 
 while (GetIsObjectValid(oCount)) 
 	{ 
 	//sCountTag=GetTag(oCount); 
 	if (iCheck==1) 
 		{ 
 		DestroyObject(oCount); 
 		} 
 	 
 	oCount=GetNextItemInInventory(oPC); 
 	iCheck=GetLocalInt(oCount,"REMOVE_ON_AREA_EXIT"); 
 	} 
  
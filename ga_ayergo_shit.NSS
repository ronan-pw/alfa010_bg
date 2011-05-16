// ga_ayergo_shit
/*

*/
// CGaw 3/10/06
// ChazM 3/15/06 - minor changes	



	
void main()
{
	object oGiver = GetObjectByTag("starting_merchant",0);//GetTarget(sGiver, TARGET_OWNER);
	object oReceiver = GetPCSpeaker();//GetTarget(sReceiver, TARGET_PC);
	//PrettyDebug ("sGiver = " + GetName(oGiver));
	//PrettyDebug ("sReceiver = " + GetName(oReceiver));

   CreateItemOnObject("ayergo_key", oReceiver);
   CreateItemOnObject("hh_orb", oReceiver);
   CreateItemOnObject("x0_waxmgr002", oReceiver);
   CreateItemOnObject("ayergo_ring", oReceiver);
   
   
   
   
}
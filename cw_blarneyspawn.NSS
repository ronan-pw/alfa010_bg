void main()
{
object oFlag=GetObjectByTag("blarneyin");
location flagloc = GetLocation(oFlag);
object oPC=GetEnteringObject();
object exist = GetObjectByTag("c_blarney");


if(exist == OBJECT_INVALID){

 if(GetTimeHour() >= 18) CreateObject(OBJECT_TYPE_CREATURE,"c_blarney",flagloc);
//SendMessageToPC(oPC, "you triggered the script."); 
}
else{
  if(GetTimeHour() < 18) DestroyObject(exist);
}


}
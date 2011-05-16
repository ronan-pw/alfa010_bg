void main()
{
object PCclick;
object oDoor=GetObjectByTag("seacave_down1"); 

PCclick = GetEnteringObject();

//if(GetDistanceToObject(PCclick) > 5.0) return;

if(GetSkillRank(SKILL_SEARCH, PCclick, TRUE) >= 5){
ActionOpenDoor(oDoor);
SendMessageToPC(PCclick, "You find a hidden lever to open a hidden door.");  
}
else
SendMessageToPC(PCclick, "You think there is a hidden door here, but you can find no way to open it."); 


}
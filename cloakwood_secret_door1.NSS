void main()
{
object PCclick;
object oDoor=GetObjectByTag("ainn_in"); 

PCclick = GetEnteringObject();

//if(GetDistanceToObject(PCclick) > 5.0) return;

if(GetTimeHour() ==23 ){
ActionOpenDoor(oDoor);
ActionUnlockObject(oDoor);
SendMessageToPC(PCclick, "The door flies open.  Unnatural sounds come from within");

ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_DUR_SPELL_BESTOW_CURSE),oDoor);  
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_SPELL_DUR_CALL_LIGHTNING),oDoor);  
PlaySound("al_en_thunder_dist_02");
}
//else
//SendMessageToPC(PCclick, "You think there is a hidden door here, but you can find no way to open it."); 


}
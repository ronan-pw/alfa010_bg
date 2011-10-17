void main()
{
object oPC=GetEnteringObject();
if (GetIsObjectValid(GetItemPossessedBy(oPC,"PORTAL_TOKEN_UDA4_C")))
	{
	object oWP1=GetWaypointByTag("WP_PORTAL_UDA4_C");
	object oWP2=GetWaypointByTag("WP_PORTAL_UDA4_C_PORTAL");
	object oWP3=GetWaypointByTag("WP_PORTAL_UDX1_A");
	object oWP4=GetWaypointByTag("WP_PORTAL_UDX1_A_PORTAL");
	object oATa=CreateObject(OBJECT_TYPE_PLACEABLE,"portal_at7",GetLocation(oWP1));
	object oATb=CreateObject(OBJECT_TYPE_PLACEABLE,"portal_at9",GetLocation(oWP3));
	object oEFa=CreateObject(1024,"fx_songportal_-xy",GetLocation(oWP2));
	object oEFb=CreateObject(1024,"fx_songportal_y",GetLocation(oWP4));
	ApplyEffectAtLocation(0,EffectVisualEffect(33),GetLocation(oWP1));
	ApplyEffectAtLocation(0,EffectVisualEffect(33),GetLocation(oWP3));
	DelayCommand(360.0,DestroyObject(oATa));
	DelayCommand(360.0,DestroyObject(oATb));
	DelayCommand(360.0,DestroyObject(oEFa));
	DelayCommand(360.0,DestroyObject(oEFb));
	
	}
}
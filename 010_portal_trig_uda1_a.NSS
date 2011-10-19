void main()
{
object oPC=GetEnteringObject();

if (GetIsNight())
	{
	object oPortalWP=GetWaypointByTag("WP_UDA1_PORTALA_SPAWN");
	object oATWP=GetWaypointByTag("WP_UDA1_PORTALA");
	object oPortalAT=CreateObject(64,"portal_at0",GetLocation(oATWP));
	object oPortalVFX=CreateObject(1024,"fx_songportal_-xy",GetLocation(oPortalWP));
	ApplyEffectAtLocation(0,EffectVisualEffect(33),GetLocation(oPortalWP));
	SetLocalObject(oPortalAT,"PORTAL_VFX",oPortalVFX);
	DelayCommand(300.0,DestroyObject(oPortalAT));
	DelayCommand(301.0,DestroyObject(oPortalVFX));
	}
}
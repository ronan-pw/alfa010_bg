void main()
{
int iValue;
int iTotal=0;
object oLoop=GetFirstItemInInventory(OBJECT_SELF);
while (GetIsObjectValid(oLoop))
	{
	iValue=GetGoldPieceValue(oLoop);
	iTotal=iTotal+iValue;
	oLoop=GetNextItemInInventory(OBJECT_SELF);
	}

if ((iTotal<100)||(GetLocalInt(OBJECT_SELF,"ACTIVE")))
	{
	object oBrazier=OBJECT_SELF;
	AssignCommand(oBrazier,SpeakString("A thousand stars shine like gold"));
	DelayCommand(4.0,AssignCommand(oBrazier,SpeakString("But what good is gold to I")));
	DelayCommand(8.0,AssignCommand(oBrazier,SpeakString("Feed me goods to the sum of a ton")));
	DelayCommand(12.0,AssignCommand(oBrazier,SpeakString("Else tarry here to die")));	
	}

else
	{
	SetLocalInt(OBJECT_SELF,"ACTIVE",1);
	oLoop=GetFirstItemInInventory(OBJECT_SELF);
	while(GetIsObjectValid(oLoop))
		{
		DestroyObject(oLoop);
		oLoop=GetNextItemInInventory();
		}
	object oPortal=CreateObject(64,"portal_at4",GetLocation(GetWaypointByTag("WP_PORTAL_UDA3_B")));
	object oPortalVFX=CreateObject(1024,"fx_songportal_y",GetLocation(GetWaypointByTag("WP_PORTAL_UDA3_B_VFX")));	
	ApplyEffectAtLocation(0,EffectVisualEffect(33),GetLocation(GetWaypointByTag("WP_PORTAL_UDA3_B_VFX")));
	object oBrazierVFX=CreateObject(1024,"fx_nshore_bonfire",GetLocation(GetWaypointByTag("WP_PORTAL_UDA3_B_BRAZIER")));
	DelayCommand(30.0,DestroyObject(oPortal));
	DelayCommand(32.0,DestroyObject(oBrazierVFX));
	DelayCommand(34.0,DestroyObject(oPortalVFX));
	DelayCommand(36.0,DeleteLocalInt(OBJECT_SELF,"ACTIVE"));
	}
}
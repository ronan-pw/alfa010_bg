/*
Activation for Portal A, Underdrak A1
Portal Rules 	- Only active at night
				- No armour over AC3 may pass
				- Link to Portal A, Underdark A2
*/


void main()
{
int DEBUG=1;
object oPC=GetLastUsedBy();

if (DEBUG==1){SendMessageToPC(oPC,"Attempting to activate portal");}

if (!GetIsNight())
	{
	object oVFX=GetLocalObject(OBJECT_SELF,"PORTAL_VFX");
	ApplyEffectAtLocation(0,EffectVisualEffect(33),GetLocation(oVFX));
	DestroyObject(oVFX);
	DestroyObject(OBJECT_SELF);
	}

else
	{
	object oItemLoop=GetFirstItemInInventory(oPC);
	int iPortalFail=0;
	while (GetIsObjectValid(oItemLoop))
		{
		if (GetItemACValue(oItemLoop)>3)
			{
			iPortalFail=iPortalFail+1;
			if (DEBUG==1){SendMessageToPC(oPC,"AC3+ Armour Found");}
			}
		oItemLoop=GetNextItemInInventory(oPC);
		}	
	if (iPortalFail>0)
		{
		SpeakString("No coat of steel shall pass");
		AssignCommand(oPC,ClearAllActions());
		AssignCommand(oPC,ActionJumpToObject(GetWaypointByTag("WP_UDA1_PORTALA_REBOUND"),FALSE));
		DelayCommand(0.25,ApplyEffectToObject(1,EffectKnockdown(),oPC,6.0));
		DelayCommand(0.5,SetCommandable(FALSE,oPC));
		ApplyEffectToObject(0,EffectVisualEffect(183),oPC);
		DelayCommand(6.0,SetCommandable(TRUE,oPC));
		if (DEBUG==1){SendMessageToPC(oPC,"Jumping to rebound waypoint");}
		}
	else
		{
		ApplyEffectAtLocation(0,EffectVisualEffect(33),GetLocation(oPC));
		DelayCommand(0.5,AssignCommand(oPC,ActionJumpToObject(GetWaypointByTag("WP_PORTAL_UDA2_A"))));
		}	
	}
}
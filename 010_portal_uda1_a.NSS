/*
Activation for Portal A, Underdrak A1
Portal Rules 	- Only active at night
				- No armour over AC3 may pass
				- Link to Portal A, Underdark A2
*/

#include "wand_inc_misc"



int check_metal_armor(object o)
{
	int nType = GetArmorType(o);

	switch (nType) {
		case ARMOR_INVALID:
		case ARMOR_CLOTH:
		case ARMOR_CLOTH_PADDED:
		case ARMOR_CLOTH_PADDED_MASTERWORK:
		case ARMOR_LEATHER:
		case ARMOR_LEATHER_MASTERWORK:
		case ARMOR_HIDE:
		case ARMOR_HIDE_MASTERWORK:
			return 0;
		default:
			break;
	}

	return 1;
}

int check_player(object oPC)
{
	object o;

	if (check_metal_armor(GetItemInSlot(INVENTORY_SLOT_CHEST, oPC)))
		return 1;

	for (	o = GetFirstItemInInventory(oPC);
		GetIsObjectValid(o);
		o = GetNextItemInInventory(oPC) ) {

		if (check_metal_armor(o))
			return 1;
	}

	return 0;
}

void main()
{
	int nDebug=0;
	object oPC=GetLastUsedBy();

	if (nDebug)
		SendMessageToPC(oPC,"Attempting to activate portal");

	if (!GetIsNight()) {

		object oVFX=GetLocalObject(OBJECT_SELF,"PORTAL_VFX");
		ApplyEffectAtLocation(0,EffectVisualEffect(33),GetLocation(oVFX));
		DestroyObject(oVFX);
		DestroyObject(OBJECT_SELF);
		return;
	}

	if (check_player(oPC)) {
		SpeakString("No coat of steel shall pass");
		AssignCommand(oPC,ClearAllActions());
		AssignCommand(oPC,ActionJumpToObject(GetWaypointByTag("WP_UDA1_PORTALA_REBOUND"),FALSE));
		DelayCommand(0.25,ApplyEffectToObject(1,EffectKnockdown(),oPC,6.0));
		DelayCommand(0.5,SetCommandable(FALSE,oPC));
		ApplyEffectToObject(0,EffectVisualEffect(183),oPC);
		DelayCommand(6.0,SetCommandable(TRUE,oPC));

		if (nDebug)
			SendMessageToPC(oPC,"Jumping to rebound waypoint");

		return;
	}

	ApplyEffectAtLocation(0,EffectVisualEffect(33),GetLocation(oPC));
	DelayCommand(0.5,AssignCommand(oPC,ActionJumpToObject(GetWaypointByTag("WP_PORTAL_UDA2_A"))));
}

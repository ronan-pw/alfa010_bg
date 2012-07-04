#include "acr_array_i"

void PortToLocation(location lLoc) {
	object oPC = GetLastUsedBy();
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(33), GetLocation(oPC));
	DelayCommand(0.5, AssignCommand(oPC, ActionJumpToLocation(lLoc)));
}

void ChargePortal(object oPortal) {
	int nCharges = GetLocalInt(oPortal, "010_PORTAL_CHARGES") + 1;
	nCharges = (nCharges > 5) ? 5 : nCharges;
	SetLocalInt(oPortal, "010_PORTAL_CHARGES", nCharges);
	DelayCommand(HoursToSeconds(1), ChargePortal(oPortal));
}

void main() {

	if(!GetLocalInt(OBJECT_SELF, "010_PORTAL_INITIALIZED")) {
		SetLocalInt(OBJECT_SELF, "010_PORTAL_CHARGES", 5);
		DelayCommand(HoursToSeconds(1), ChargePortal(OBJECT_SELF));
		SetLocalInt(OBJECT_SELF, "010_PORTAL_INITIALIZED", 1);
	}

	int nCharges = GetLocalInt(OBJECT_SELF, "010_PORTAL_CHARGES");
	object oUser = GetLastUsedBy();
	string sDest = (GetAlignmentGoodEvil(oUser) == ALIGNMENT_GOOD) ? GetLocalString(OBJECT_SELF, "010_PORTAL_ALT_DEST") : GetLocalString(OBJECT_SELF, "010_PORTAL_DEST");
	object oDest = GetObjectByTag(sDest);
	
	if(GetLocalInt(oDest, "010_PORTAL_BLOCKED"))
		SpeakString("*<i>Nothing happens.</i>*");
	else if((oDest != OBJECT_INVALID && nCharges) || GetIsDM(oUser)) {
		PortToLocation(GetLocation(oDest));
		SetLocalInt(OBJECT_SELF, "010_PORTAL_CHARGES", nCharges-1);
	} else {
		SpeakString("*<i>Nothing happens.</i>*");
	}
}
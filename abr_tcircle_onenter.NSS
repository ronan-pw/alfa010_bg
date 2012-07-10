void main() {
	object oDest = GetObjectByTag(GetLocalString(OBJECT_SELF, "ACR_TCIRCLE_DEST"));
	object oPC = GetEnteringObject();
	if(GetArea(oDest) != OBJECT_INVALID) {
		ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(33), GetLocation(oPC));
		DelayCommand(3.0, AssignCommand(oPC, ActionJumpToLocation(GetLocation(oDest))));
	}
}
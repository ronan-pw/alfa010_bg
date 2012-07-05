#include "010_throrgar_spire_i"

void main() {
	object oDM = GetItemActivator();
	
	if(!GetIsDM(oDM)) {
		DestroyObject(OBJECT_SELF);
		return;
	}
	
	object oArea = GetArea(oDM);
	int bDisabled = GetLocalInt(oArea, WIND_EFFECTS_DISABLED_LI);
	if(bDisabled)
		SendMessageToPC(oDM, "Activating winds in area.");
	else SendMessageToPC(oDM, "Disabling winds in area.");
	
	SetLocalInt(oArea, WIND_EFFECTS_DISABLED_LI, !bDisabled);
}
void main() {
	location wpLoc = GetLocation(GetNearestObjectByTag("010_wp_portal_opened"));
	object oUser = GetLastUsedBy();
	object outletWp = GetNearestObjectByTag("010_portal_cloakwood13_dest");
	
	if(GetLocation(OBJECT_SELF) == wpLoc) {
		// Portal is open. Block it.
		AssignCommand(oUser, SpeakString("*<i>You roll the cart in front of the portal.</i>*"));
		location portalLoc = GetLocation(GetNearestObjectByTag("PORTAL_AT"));
		CreateObject(OBJECT_TYPE_PLACEABLE, "010_pl_portal_blocker", portalLoc);
		DestroyObject(OBJECT_SELF);
		SetLocalInt(outletWp, "010_PORTAL_BLOCKED", 1);
	} else {
		// Portal is closed. Open it.
		AssignCommand(oUser, SpeakString("*<i>You roll the cart away from the potral.</i>*"));
		CreateObject(OBJECT_TYPE_PLACEABLE, "010_pl_portal_blocker", wpLoc);
		DestroyObject(OBJECT_SELF);
		SetLocalInt(outletWp, "010_PORTAL_BLOCKED", 0);
	}
}
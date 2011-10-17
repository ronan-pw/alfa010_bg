#include "acr_array_i"

void DoNothing() {
	SpeakString("*<i>Nothing happens.</i>*");
}

void PortToLocation(location lLoc) {
	object oPC = GetLastUsedBy();
	ApplyEffectAtLocation(0, EffectVisualEffect(33), GetLocation(oPC));
	DelayCommand(0.5, AssignCommand(oPC, ActionJumpToLocation(lLoc)));
}

void ChangeDestination() {

	DelayCommand(HoursToSeconds(1), ChangeDestination());
	
	location lDest;
	
	int nWorks = d10(1);
	if(nWorks <= 2) {
		// Portal works, take PC to the Underdark.
	} else if(nWorks <= 4) {
		// Portal doesn't work, take PC to another random portal.
		int nRandomPortal = Random(10);
		string sDest;
		switch(nRandomPortal) {
			case 0: sDest = "WP_PORTAL_UDA4_A";
			case 1: sDest = "WP_PORTAL_UDA4_B";
			case 2: sDest = "WP_PORTAL_UDA4_C";
			case 3: sDest = "WP_PORTAL_UDA4_D";
			case 4: sDest = "WP_PORTAL_UDA3_B";
			case 5: sDest = "WP_PORTAL_UDA3_A";
			case 6: sDest = "WP_PORTAL_UDA2_A";
			case 7: sDest = "WP_PORTAL_UDA5_A";
			case 8: sDest = "WP_PORTAL_UDA5_C";
			case 9: sDest = "WP_PORTAL_UDX1_A";
			case 10: sDest = "WP_PORTAL_UDA6_A";
		}
		lDest = GetLocation(GetObjectByTag(sDest));
	} else if(nWorks <= 8) {
		// Take PC to some random place on the server.
		int nRandomDests = GetLocalInt(OBJECT_SELF, "010_PORTAL_RANDOM_DEST_COUNT");
		if(!nRandomDests) {
			object oDest;
			while(TRUE) {
				oDest = GetObjectByTag("010_CLOAKWOOD02_CAVE2_PORTAL_RANDOM_DEST", nRandomDests);
				if(oDest == OBJECT_INVALID) break;
				nRandomDests++;
			}
			SetLocalInt(OBJECT_SELF, "010_PORTAL_RANDOM_DEST_COUNT", nRandomDests);
		}
		lDest = GetLocation(GetObjectByTag("010_CLOAKWOOD02_CAVE2_PORTAL_RANDOM_DEST", Random(nRandomDests)));
	} else {
		// Nothing happens.
		lDest = GetStartingLocation();
	}
	
	SetLocalLocation(OBJECT_SELF, "010_PORTAL_DESTINATION", lDest);
}

void main() {

	if(GetLocalInt(OBJECT_SELF, "010_PORTAL_RECHARGING")) {
		DoNothing();
		return;
	}
	
	location lDest = GetLocalLocation(OBJECT_SELF, "010_PORTAL_DESTINATION");
	if(!GetIsLocationValid(lDest)) {
		ChangeDestination();
		lDest = GetLocalLocation(OBJECT_SELF, "010_PORTAL_DESTINATION");
	}	
	
	if(lDest == GetStartingLocation() || !GetIsLocationValid(lDest)) {
		DoNothing();
		return;
	}
	
	PortToLocation(lDest);
	
	if(!Random(6) && !GetIsDM(GetLastUsedBy())) {
		// Portal must recharge every 1 out of 6 uses.
		SetLocalInt(OBJECT_SELF, "010_PORTAL_RECHARGING", 1);
		float fRechargeTime = HoursToSeconds(Random(2));
		DelayCommand(fRechargeTime, SetLocalInt(OBJECT_SELF, "010_PORTAL_RECHARGING", 0));
	}
}
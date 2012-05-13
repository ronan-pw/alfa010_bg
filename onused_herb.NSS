void main()
{
	object oPC, resval;
	int nHeal, nSurv, nSpell, bHealCheck, bSurvCheck, bSpellCheck;
	string sMsg, sRef, sTag;
	
	oPC = GetLastUsedBy();

	// Prevent re-rolls
	if (GetLocalInt(OBJECT_SELF, "HERB_" + ObjectToString(oPC))) {
		SendMessageToPC(oPC, "You see nothing worth harvesting.");
		return;
	}

	sTag = GetTag(OBJECT_SELF);
	
	if (sTag == "010_herb_shroom0") {
		nHeal = 2;
		nSurv = 2;
		sMsg = "This mushroom's cap looks rather peculiar.  But you can't see anything worthwhile to harvest.";
		sRef = "magmush";
	}
	else if (sTag == "010_herb_shroom1") {
		// 1/2 probability of no check 1/2 of simple check
		nHeal = (Random(2)*2)-1;
		nSurv = (Random(2)*2)-1;
		sMsg = "This mushroom looks useful, but it seems to delicate to harvest.";
		sRef = "it_garnishcap";
	}
	else if (sTag == "010_herb_shroom2") {
		nSpell = 4;
		nSurv = 8;
		sMsg = "This mushroom's cap gives off an odd glow, though it looks far too fragile to pick.";
		sRef = "it_gloomshroom";
	}
	else if (sTag == "010_herb_spell0") {
		nSpell = 3;
		nSurv = 4;
		sMsg = "You reach around in the guano but find nothing worth salvaging, instead just getting a smelly hand.";
		sRef = "batguano";
	}
	else if (sTag == "010_herb_spell1") {
		nSpell = 6;
		nSurv = 11;
		sMsg = "You peer around at the moss but find nothing worth salvaging.";
		sRef = "pmoss";
	}
	else if (sTag == "010_herb_spell2") {
		nSpell = 6;
		nSurv = 11;
		sMsg = "You examine the hunk of pungent material but find nothing worth salvaging.";
		sRef = "it_sulfur";
	}
	else if (sTag == "010_herb_spell3") {
		nSpell = 5;
		nSurv = 9;
		sMsg = "You look over the plant but aren't certain what to gather.";
		sRef = "it_flashwort";
	}
	else if (sTag == "010_herb_herb0") {
		nHeal = 4;
		nSurv = 4;
		sMsg = "This odd plant almost feels warm to the touch.  But you can't see anything worthwhile to harvest.";
		sRef = "firefernfrond";
	}
	else if (sTag == "010_herb_herb1") {
		nHeal = 7;
		nSurv = 8;
		sMsg = "This odd plant has remarkably distinctive leaves.  But you can't see anything worthwhile to harvest.";
		sRef = "it_cassil";
	}
	else if (sTag == "010_herb_herb2") {
		nHeal = 2;
		nSurv = 3;
		sMsg = "This shrub has a few bright yellow flowers but none look worth harvesting.";
		sRef = "it_garclive";
	}
	else if (sTag == "010_herb_herb3") {
		nHeal = 3;
		nSurv = 2;
		sMsg = "This friendly-looking plant seems to have a few berries, though unfortunately they look not quite yet ripe.";
		sRef = "it_elderberry";
	}
	else if (sTag == "010_herb_herb4") {
		nHeal = 7;
		nSurv = 9;
		sMsg = "This inconspicuous plant appears to have nothing worthwhile to harvest.";
		sRef = "it_henbane";
	}
	else if (sTag == "010_herb_herb5") {
		nHeal = 9;
		nSurv = 7;
		sMsg = "This herb has leaves of a peculiar sheen, but none look good enough for harvesting.";
		sRef = "it_skullcap";
	}

	bHealCheck = GetSkillRank(SKILL_HEAL, oPC, TRUE) >= nHeal;
	bSurvCheck = GetSkillRank(SKILL_SURVIVAL, oPC, TRUE) >= nSurv;
	bSpellCheck = GetSkillRank(SKILL_SPELLCRAFT, oPC, TRUE) >= nSpell;

	// If any of the required checks fail, return
	if (	(!bHealCheck || !nHeal) &&
		(!bSurvCheck || !nSurv) &&
		(!bSpellCheck || !nSpell))
	{
		SendMessageToPC(oPC, sMsg);
		SetLocalInt(OBJECT_SELF, "HERB_" + ObjectToString(oPC), 1);
		return;
	}
	
	resval = CreateItemOnObject(sRef, oPC);
		
	if (!GetIsObjectValid(resval)) 
		SpeakOneLinerConversation("Fsck, invalid item");

	DestroyObject(OBJECT_SELF);
}

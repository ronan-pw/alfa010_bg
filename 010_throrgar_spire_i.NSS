#include "acr_effects_i"

const int WIND_FORCE_MODERATE = 1;
const int WIND_FORCE_STRONG = 2;
const int WIND_FORCE_SEVERE = 3;
const int WIND_FORCE_STORM = 4;
const int WIND_FORCE_HURRICANE = 5;

const float WIND_FORCE_CHANGE_DELAY = 360.0;
const float WIND_FORCE_WARNING_DELAY = 18.0; // Warning time between wind-force changes, so PCs can get to safety.

const string WIND_FORCE_LI = "010_AREA_WIND";
const string WIND_EFFECTS_DISABLED_LI = "010_AREA_WIND_DISABLED";

const string BLOWN_AWAY_DESTINATION = "010_THRORGAR_BLOWN_AWAY_DEST";

int GetWindForce(object oArea = OBJECT_SELF) {
	return GetLocalInt(OBJECT_SELF, WIND_FORCE_LI);
}

string WindDescription(int nForce) {
	switch(nForce) {
		case WIND_FORCE_MODERATE: return "Howling winds encircle the spire, seemingly carrying speach and sound off with them into the darkness.";
		case WIND_FORCE_STRONG: return "Strong winds shriek in your ears, making both speach and ranged weapons less reliable.";
		case WIND_FORCE_SEVERE: return "Severe winds whip at the spire, threatening the balance of smaller creatures, slowing larger ones and making speach and ranged weapons unreliable.";
		case WIND_FORCE_STORM: return "Storm-force winds surround the spire, threatening to blow smaller creatures off into the gloom, and the balance and speed of larger ones. Speech and ranged weapons are useless!";
		case WIND_FORCE_HURRICANE: return "Hurricane-force winds blast you off balance, seemingly at the worse possible moments. Medium and smaller creatures could be blown away completely! Speech and ranged weapons are useless.";
	}
	return "Error! Please report this to the BG team.";
}

void DescribeWinds(object oPC, int nForce) {
	FloatingTextStringOnCreature(WindDescription(nForce), oPC, FALSE);
}

void WindForceHeartbeat(object oArea) {
	int nForce = GetWindForce(oArea);
	switch(Random(3)) {
		case 0: nForce--; break;
		case 2: nForce++; break;
	}
	
	if(nForce < 0) nForce = 0;
	else if(nForce > 4) nForce = 4;
	DelayCommand(WIND_FORCE_WARNING_DELAY, SetLocalInt(oArea, WIND_FORCE_LI, nForce));
	DelayCommand(WIND_FORCE_CHANGE_DELAY, WindForceHeartbeat(oArea));
	
	object oPC = GetFirstPC();
	while(oPC != OBJECT_INVALID) {
		if(GetArea(oPC) == oArea)
			DescribeWinds(oPC, nForce);
		oPC = GetNextPC();
	}
}

void InitializeThrorgarSpire(object oArea = OBJECT_SELF) {
	if(GetWindForce(oArea)) return;
	
	SetLocalInt(OBJECT_SELF, WIND_FORCE_LI, WIND_FORCE_MODERATE);
	WindForceHeartbeat(oArea);
	
	// Find the number of "blown away" waypoints on the server:
	int nRandomDests;
	object oDest;
	while(TRUE) {
		oDest = GetObjectByTag(BLOWN_AWAY_DESTINATION, nRandomDests);
		if(oDest == OBJECT_INVALID) break;
		nRandomDests++;
	}
	SetLocalInt(oArea, BLOWN_AWAY_DESTINATION, nRandomDests);
}

int PredictCreatureSize(object oCreature) {
	int nSize = GetCreatureSize(oCreature);
	
	if(GetHasSpellEffect(SPELL_ENLARGE_PERSON, oCreature)) nSize++;
	if(GetHasSpellEffect(SPELL_IRON_BODY, oCreature)) nSize++;
	if(GetHasSpellEffect(SPELL_STONE_BODY, oCreature)) nSize++;
	if(GetHasSpellEffect(SPELL_REDUCE_PERSON, oCreature)) nSize--;
	if(GetHasSpellEffect(SPELL_REDUCE_PERSON_MASS, oCreature)) nSize--;
	if(GetHasSpellEffect(SPELL_REDUCE_PERSON_GREATER, oCreature)) nSize--;
	
	if(nSize < 1) nSize = 1;
	else if(nSize > 5) nSize = 5;
	
	return nSize;
}

void AttemptTeleport(object oCreature) {
	string sTag = GetTag(oCreature);
	if(sTag == "abr_cr_ou_demon_babau" || sTag == "abr_cr_ou_demon_hezrou") {
		ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(33), GetLocation(oCreature));
		DestroyObject(oCreature, 6.0);
	}
}

void AttemptConfusion(object oCreature, int nDC) {
	if(!WillSave(oCreature, nDC, SAVING_THROW_TYPE_CHAOS)) {
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectConfused(), oCreature, RoundsToSeconds(d4(1) + 1));
		if(!GetIsImmune(oCreature, IMMUNITY_TYPE_CONFUSED))
			FloatingTextStringOnCreature("The wind howls, and carries sounds with it... Enemies approach!", oCreature, FALSE);
	}
}

void AttemptCheck(object oCreature, int nDC) {
	if(!FortitudeSave(oCreature, nDC, SAVING_THROW_TYPE_CHAOS)) {
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSlow(), oCreature, 6.0);
		if(!GetIsImmune(oCreature, IMMUNITY_TYPE_SLOW))
			AssignCommand(oCreature, SpeakString("*<i>has difficulty moving with the harsh winds</i>*"));
	}
}

void AttemptKnockDown(object oCreature, int nDC) {
	if(!FortitudeSave(oCreature, nDC, SAVING_THROW_TYPE_CHAOS)) {
		ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectKnockdown(), oCreature);
		if(!GetIsImmune(oCreature, IMMUNITY_TYPE_KNOCKDOWN))
			AssignCommand(oCreature, SpeakString("*<i>is knocked down by the harsh winds</i>*"));
	}
}

void AttemptBlowAway(object oArea, object oCreature, int nDC) {
	AssignCommand(oCreature, SpeakString("*<i>is swept up by the shrieking winds and carried off into the darkness</i>*"));
	
	if(!GetIsPC(oCreature)) {
		DestroyObject(oCreature);
		return;
	}
	
	float fHeight = GetPosition(oCreature).z;
	// No "slow fall" or damage cap help here, since the PC is not falling as much as being dashed against rocks.
	// The higher they are, the the more winds toss them around.
	int i, nDamage;
	for(; i<10; i++) {
		if(!Random(3)) break;
		else {
			SendMessageToPC(oCreature, "Bathed only in darkness, the harsh winds dash you against jagged outcroppings and unseen rock faces.");
			nDamage += d10(4);
			fHeight += 10;
		}
	}
	
	// Find the destination.
	int nRandomDests = GetLocalInt(oArea, BLOWN_AWAY_DESTINATION);
	location lDest = GetLocation(GetObjectByTag(BLOWN_AWAY_DESTINATION, Random(nRandomDests)));
	
	AssignCommand(oCreature, SpeakString("*<i>is slammed against the cliff face.</i>*"));
	ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nDamage + d6(FloatToInt(fHeight * 3.048 / 10.0)), DAMAGE_TYPE_BLUDGEONING), oCreature);
	AssignCommand(oCreature, ActionJumpToLocation(lDest));
}

void WindHeartbeat(object oArea = OBJECT_SELF) {

	if(GetLocalInt(oArea, WIND_EFFECTS_DISABLED_LI)) return;

	// Spire code
	object oCreature = GetFirstObjectInArea(OBJECT_SELF);
	int nWindForce = GetWindForce();
	effect eff;
	while(oCreature != OBJECT_INVALID) {
		if(GetObjectType(oCreature) == OBJECT_TYPE_CREATURE) {
		int nSize = PredictCreatureSize(oCreature);		
		
			switch(nWindForce) {
				case WIND_FORCE_MODERATE:
					// Listening here is harder than in normal storms, because of the influence of pandemonium.
					eff = EffectSkillDecrease(SKILL_LISTEN, 2);
					break;
				case WIND_FORCE_STRONG:
					eff = EffectSkillDecrease(SKILL_LISTEN, 4);
					if(nSize == CREATURE_SIZE_TINY)
						AttemptKnockDown(oCreature, 10);
					break;
				case WIND_FORCE_SEVERE:
					eff = EffectSkillDecrease(SKILL_LISTEN, 8);
					if(nSize == CREATURE_SIZE_TINY)
						AttemptBlowAway(oArea, oCreature, 15);
					else if(nSize == CREATURE_SIZE_SMALL)
						AttemptKnockDown(oCreature, 15);
					else if(nSize == CREATURE_SIZE_MEDIUM)
						AttemptCheck(oCreature, 15);
					if(!Random(20)) AttemptConfusion(oCreature, 15);
					break;
				case WIND_FORCE_STORM:
					AttemptTeleport(oCreature);
					eff = EffectSkillDecrease(SKILL_LISTEN, 50);
					if(nSize <= CREATURE_SIZE_SMALL)
						AttemptBlowAway(oArea, oCreature, 18);
					else if(nSize == CREATURE_SIZE_MEDIUM)
						AttemptKnockDown(oCreature, 18);
					else if(nSize <= CREATURE_SIZE_HUGE)
						AttemptCheck(oCreature, 18);
					if(!Random(10)) AttemptConfusion(oCreature, 18);
					break;
				case WIND_FORCE_HURRICANE:
					AttemptTeleport(oCreature);
					eff = EffectSkillDecrease(SKILL_LISTEN, 50);
					if(nSize <= CREATURE_SIZE_LARGE)
						AttemptBlowAway(oArea, oCreature, 20);
					else if(nSize == CREATURE_SIZE_HUGE)
						AttemptKnockDown(oCreature, 20);
					else AttemptCheck(oCreature, 20);
					if(!Random(5)) AttemptConfusion(oCreature, 20);
					break;
			}
			RemoveAllEffectsFromSource(oCreature, 10100);
			ApplyEffectFromSource(10100, DURATION_TYPE_TEMPORARY, eff, oCreature, 9.0);
		}
	}
}
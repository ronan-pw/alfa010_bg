#include "acr_language_i"
#include "acr_i"

void main() {
	object oPC = GetEnteringObject();
	int nDC = 35;
	
	//if(_IsLanguageKnown(oPC, "Seldruin"))
	// Seldruin is not in our DMFI languages.
	
	if(!_IsLanguageKnown(oPC, "elven")) nDC += 100;
	
	if(GetHasFeat(FEAT_REGION_ELF_MOON, oPC) || GetHasFeat(FEAT_REGION_ELF_SUN, oPC))
		nDC -= 5;
	else if(GetHasFeat(FEAT_REGION_EVERMEET))
		nDC -= 10;
	
	int nRoll = d20(1);
	
	int nArcana = GetSkillRank(SKILL_KNOWLEDGE_ARCANA, oPC) + nRoll;
	int nHistory = GetSkillRank(SKILL_KNOWLEDGE_ARCANA, oPC) + nRoll;
	
	if(nArcana >= nDC || nHistory >= nDC)
		SendMessageToPC(oPC, "The flowing runes in front of you appear to be written in Hammerfae, the script of elvish high magic.");
	else SendMessageToPC(oPC, "The flowing, elegant runes in front of you are not written in any alphabet you've encountered before.");
}
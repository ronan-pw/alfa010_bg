#include "acr_quest_i"
#include "acr_skills_i"

void main()
{
	object oPC=GetEnteringObject();

	if (ACR_RetrieveQuestState("bg_raid_1", oPC) == 1) {
		if (ACR_SkillCheck(12,oPC,17))
			SendMessageToPC(oPC,"You hear the snap of a twig up ahead.");
	}
}
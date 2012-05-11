#include "acr_nonlethal_i"
#include "acr_skills_i"

const string SWIM_GOGGLE_TAG = "goggles";
const int SWIM_MAX_WEIGHT = 300;
const float SWIM_EFFECT_TIME = 50.0f;

int enter_water(object o, int depth=0, int flowing=1)
{
	effect eBlind,eDeaf,eVis;
	int damage,dc;

	if (!GetIsPC(o)) 
		return 0;

	if (GetWeight(o) >= SWIM_MAX_WEIGHT) {
		SendMessageToPC(o, "You are carrying too much to move well in the deep water and it saps your strength."); 
		ACR_ApplyNonlethalDamageToCreature(o,d8());
	}

	if (GetTag(GetItemInSlot(INVENTORY_SLOT_HEAD,o)) != SWIM_GOGGLE_TAG) {
		eBlind =  EffectBlindness();
		eDeaf = EffectDeaf();
		eVis = EffectVisualEffect(VFX_DUR_DARKNESS);
		eBlind = EffectLinkEffects(eBlind, eDeaf);
		eBlind = EffectLinkEffects(eBlind, eVis);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlind, o, SWIM_EFFECT_TIME);
		SendMessageToPC(o, "The waves lap over you, severly restricting your hearing and visibility.");
	}

	/*ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSlow(), o, SWIM_EFFECT_TIME);

	switch (depth) {
		case 0:
			damage=1;
			break;
		case 1:
			damage=d2();
			break;
		case 2:
			damage=d6();
			break;
	}

	if (flowing)
		dc = 15;
	else
		dc = 10;

	if (!ACR_SkillCheck(SKILL_SWIM, o, dc)) {  
		ACR_ApplyNonlethalDamageToCreature(o, damage);

		SendMessageToPC(o, "The cold, motion, and swell of the water wears on you.");
	}*/

	return 1;
}

#include "acr_skills_i"
#include "acr_time_i"

void drug_primary_effect(object oPC);
void drug_secondary_effect(object oPC);
void drug_overdose_effect(object oPC);
void drug_side_effect(object oPC);

#pragma default_function(drug_primary_effect)
#pragma default_function(drug_secondary_effect)
#pragma default_function(drug_overdose_effect)
#pragma default_function(drug_side_effect)

#define TIME_COMPRESSION_RATIO 7

const int ACR_DRUG_AGONY		= 1;
const int ACR_DRUG_BACCARAN		= 2;
const int ACR_DRUG_DEVILWEED		= 3;
const int ACR_DRUG_LUHIX		= 4;
const int ACR_DRUG_MORDAYN		= 5;
const int ACR_DRUG_MUSHROOM		= 6;
const int ACR_DRUG_REDFLOWER		= 7;
const int ACR_DRUG_SANNISH		= 8;
const int ACR_DRUG_TERRAN		= 9;
const int ACR_DRUG_VODARE		= 10;


const int ACR_EFFECT_SOURCE_ADDICT_OFFSET = 400;


const string ACR_DRUG_TAG_AGONY		= "agony";
const string ACR_DRUG_TAG_BACCARAN	= "baccaran";
const string ACR_DRUG_TAG_DEVILWEED	= "devilweed";
const string ACR_DRUG_TAG_LUHIX		= "luhix";
const string ACR_DRUG_TAG_MORDAYN	= "mordayn";
const string ACR_DRUG_TAG_MUSHROOM	= "mushroom";
const string ACR_DRUG_TAG_REDFLOWER	= "redfower";
const string ACR_DRUG_TAG_SANNISH	= "sannish";
const string ACR_DRUG_TAG_TERRAN	= "terran";
const string ACR_DRUG_TAG_VODARE	= "vodare";


const int ACR_DRUG_ADDICTION_NEGLIGIBLE	= 0;
const int ACR_DRUG_ADDICTION_LOW	= 1;
const int ACR_DRUG_ADDICTION_MEDIUM	= 2;
const int ACR_DRUG_ADDICTION_HIGH	= 3;
const int ACR_DRUG_ADDICTION_EXTREME	= 4;
const int ACR_DRUG_ADDICTION_VICIOUS	= 5;


const int ACR_DRUG_DC_NEGLIGIBLE	= 4;
const int ACR_DRUG_DC_LOW		= 6;
const int ACR_DRUG_DC_MEDIUM		= 10;
const int ACR_DRUG_DC_HIGH		= 14;
const int ACR_DRUG_DC_EXTREME		= 25;
const int ACR_DRUG_DC_VICIOUS		= 36;


const int ACR_DRUG_SAT_TIME_NEGLIGIBLE	= 1;
const int ACR_DRUG_SAT_TIME_LOW		= 10;
const int ACR_DRUG_SAT_TIME_MEDIUM	= 5;
const int ACR_DRUG_SAT_TIME_HIGH	= 2;
const int ACR_DRUG_SAT_TIME_EXTREME	= 1;
const int ACR_DRUG_SAT_TIME_VICIOUS	= 1;


string _get_drug_tag(int nDrug)
{
	switch (nDrug) {
		case ACR_DRUG_AGONY:
			return ACR_DRUG_TAG_AGONY;
		case ACR_DRUG_BACCARAN:
			return ACR_DRUG_TAG_BACCARAN;
		case ACR_DRUG_DEVILWEED:
			return ACR_DRUG_TAG_DEVILWEED;
		case ACR_DRUG_LUHIX:
			return ACR_DRUG_TAG_LUHIX;
		case ACR_DRUG_MORDAYN:
			return ACR_DRUG_TAG_MORDAYN;
		case ACR_DRUG_MUSHROOM:
			return ACR_DRUG_TAG_MUSHROOM;
		case ACR_DRUG_REDFLOWER:
			return ACR_DRUG_TAG_REDFLOWER;
		case ACR_DRUG_SANNISH:
			return ACR_DRUG_TAG_SANNISH;
		case ACR_DRUG_TERRAN:
			return ACR_DRUG_TAG_TERRAN;
		case ACR_DRUG_VODARE:
			return ACR_DRUG_TAG_VODARE;
	}

	return "";
}


// lookup to get appropriate type
int _get_drug_type(int nDrug)
{
	switch (nDrug) {
		case ACR_DRUG_BACCARAN:
		case ACR_DRUG_DEVILWEED:
		case ACR_DRUG_REDFLOWER:
		case ACR_DRUG_TERRAN:
			return ACR_DRUG_ADDICTION_LOW;
		case ACR_DRUG_MUSHROOM:
		case ACR_DRUG_SANNISH:
			return ACR_DRUG_ADDICTION_MEDIUM;
		case ACR_DRUG_MORDAYN:
		case ACR_DRUG_VODARE:
			return ACR_DRUG_ADDICTION_HIGH;
		case ACR_DRUG_AGONY:
			return ACR_DRUG_ADDICTION_EXTREME;
		case ACR_DRUG_LUHIX:
			return ACR_DRUG_ADDICTION_VICIOUS;
	}

	return ACR_DRUG_ADDICTION_NEGLIGIBLE;
}

int _get_addiction_dc(int type)
{
	switch (type) {
		case ACR_DRUG_ADDICTION_LOW:
			return ACR_DRUG_DC_LOW;
		case ACR_DRUG_ADDICTION_MEDIUM:
			return ACR_DRUG_DC_MEDIUM;
		case ACR_DRUG_ADDICTION_HIGH:
			return ACR_DRUG_DC_HIGH;
		case ACR_DRUG_ADDICTION_EXTREME:
			return ACR_DRUG_DC_EXTREME;
		case ACR_DRUG_ADDICTION_VICIOUS:
			return ACR_DRUG_DC_VICIOUS;
	}

	return ACR_DRUG_DC_NEGLIGIBLE;
}

int _get_addiction_time(int type)
{
	switch (type) {
		case ACR_DRUG_ADDICTION_LOW:
			return ACR_DRUG_SAT_TIME_LOW;
		case ACR_DRUG_ADDICTION_MEDIUM:
			return ACR_DRUG_SAT_TIME_MEDIUM;
		case ACR_DRUG_ADDICTION_HIGH:
			return ACR_DRUG_SAT_TIME_HIGH;
		case ACR_DRUG_ADDICTION_EXTREME:
			return ACR_DRUG_SAT_TIME_EXTREME;
		case ACR_DRUG_ADDICTION_VICIOUS:
			return ACR_DRUG_SAT_TIME_VICIOUS;
	}

	return ACR_DRUG_SAT_TIME_NEGLIGIBLE;
}


effect EffectAddiction(int type)
{
	effect ePenalty, eDex, eWis, eCon, eStr;

	switch (type) {
		case ACR_DRUG_ADDICTION_LOW:
			eDex = ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_DEXTERITY, d3()));
			ePenalty = eDex;
			break;
		case ACR_DRUG_ADDICTION_MEDIUM:
			eDex = ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_DEXTERITY, d4()));
			eWis = ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_WISDOM, d4()));
			ePenalty = EffectLinkEffects(eWis, eDex);
			break;
		case ACR_DRUG_ADDICTION_HIGH:
			eDex = ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_DEXTERITY, d6()));
			eWis = ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_WISDOM, d6()));
			eCon = ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION, d2()));
			ePenalty = EffectLinkEffects(eWis, eDex);
			ePenalty = EffectLinkEffects(ePenalty, eCon);
			break;
		case ACR_DRUG_ADDICTION_EXTREME:
			eDex = ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_DEXTERITY, d6()));
			eWis = ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_WISDOM, d6()));
			eCon = ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION, d6()));
			ePenalty = EffectLinkEffects(eWis, eDex);
			ePenalty = EffectLinkEffects(ePenalty, eCon);
			break;
		case ACR_DRUG_ADDICTION_VICIOUS:
			eDex = ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_DEXTERITY, d6()));
			eWis = ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_WISDOM, d6()));
			eCon = ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION, d6()));
			eStr = ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION, d6()));
			ePenalty = EffectLinkEffects(eWis, eDex);
			ePenalty = EffectLinkEffects(ePenalty, eCon);
			ePenalty = EffectLinkEffects(ePenalty, eStr);
			break;
		case ACR_DRUG_ADDICTION_NEGLIGIBLE:
		default:
			if ((d3() - 2) > 0) {
				eDex = EffectAbilityDecrease(ABILITY_DEXTERITY, 1);
				ePenalty = eDex;
			}
			break;
	}

	return ExtraordinaryEffect(ePenalty);
}

int _check_effective(object oPC, int nDC)
{
	return !ACR_SaveCheck(SAVING_THROW_FORT, oPC, nDC, TRUE);
}

int _check_addiction(object oPC, int type, int bSatiated=TRUE, int bDisplay=TRUE)
{
	int nDC = _get_addiction_dc(type);

	if (!bSatiated)
		nDC += 5;

	return ACR_SaveCheck(SAVING_THROW_FORT, oPC, nDC, bDisplay);
}

int _check_overdose(object oPC, int nDrug, int nDC)
{
	int today, day_overdose;
	string sTag = _get_drug_tag(nDrug);

	today = ACR_GetGameDaysSinceStart();

	if (today == 0)
		return FALSE;

	day_overdose = ACR_GetPersistentInt(oPC, "drg_overdose_"+sTag);

	// OD if consumed too soon after
	if ((day_overdose > today) && _check_effective(oPC, nDC))
		return TRUE;

	ACR_SetPersistentInt(oPC, "drg_overdose_"+sTag, today+1);

	return FALSE;
}

int _check_recovery(object oPC, int type)
{
	int nDC = _get_addiction_dc(type);

	return ACR_SaveCheck(SAVING_THROW_WILL, oPC, nDC, TRUE);
}

void _remove_addiction(object oPC, int nDrug)
{
	string sTag;

	sTag = _get_drug_tag(nDrug);
	ACR_SetPersistentInt(oPC, "drg_addicted_"+sTag, 0);
}

int _get_addiction(object oPC, int nDrug)
{
	string sTag;

	sTag = _get_drug_tag(nDrug);
	return ACR_GetPersistentInt(oPC, "drg_addicted_"+sTag);
}

void _add_addiction(object oPC, int nDrug)
{
	string sTag;
	sTag = _get_drug_tag(nDrug);

	ACR_SetPersistentInt(oPC, "drg_addicted_"+sTag, 1);
}

void _satiate_addiction(object oPC, int nDrug)
{
	string sTag;
	int type, time_satiated, day_withdrawl, day_satiate, today;

	type = _get_drug_type(nDrug);
	sTag = _get_drug_tag(nDrug);

	// mark consumption for X days
	today = ACR_GetGameDaysSinceStart();
	day_withdrawl = today + _get_addiction_time(type) * TIME_COMPRESSION_RATIO;
	day_satiate = today + (TIME_COMPRESSION_RATIO*2)/3;

	// mark consumption for X days
	ACR_SetPersistentInt(oPC, "drg_withdrawl_"+sTag, day_withdrawl);
	ACR_SetPersistentInt(oPC, "drg_satiate_"+sTag, day_satiate);

	// remove any addiction effects from this narcotic
	RemoveAllEffectsFromSource(oPC, nDrug + ACR_EFFECT_SOURCE_ADDICT_OFFSET);
}

// fire this daily
void _apply_withdrawl_effect(object oPC, int nDrug)
{
	int type, today, day_withdrawl, day_satiate, nRecover, bWithdrawl = TRUE;
	string sTag;
	effect e;

	type = _get_drug_type(nDrug);
	sTag = _get_drug_tag(nDrug);
	e = EffectAddiction(type);

	day_withdrawl = ACR_GetPersistentInt(oPC, "drg_withdrawl_"+sTag);
	day_satiate = ACR_GetPersistentInt(oPC, "drg_satiate_"+sTag);
	today = ACR_GetGameDaysSinceStart();

	// still satiated, ignore
	if (day_satiate > today)
		return;

	// withdrawl effects get more serious
	if (today > day_withdrawl) 
		bWithdrawl = FALSE;
	
	if (_check_addiction(oPC, type, bWithdrawl)) {
		nRecover = ACR_GetPersistentInt(oPC, "drg_recovering_"+sTag);

		// possibly remove addiction
		if ((nRecover > 0) && _check_recovery(oPC, type)) {
			_remove_addiction(oPC, nDrug);
			WriteTimestampedLogEntry("010_drugs_i: " + GetName(oPC) + " has addiction removed from "+_get_drug_tag(nDrug));
		}
		
		ACR_SetPersistentInt(oPC, "drg_recovering_"+sTag, nRecover + 1);
	}
	else {
		ACR_SetPersistentInt(oPC, "drg_recovering_"+sTag, 0);
		ApplyEffectFromSource(nDrug + ACR_EFFECT_SOURCE_ADDICT_OFFSET, DURATION_TYPE_PERMANENT, e, oPC);
		SendMessageToPC(oPC, "A bout of nausea overwhelms you, along with a strange craving.");
		WriteTimestampedLogEntry("010_drugs_i: " + GetName(oPC) + " has withdrawl symptoms from "+_get_drug_tag(nDrug));
	}
}

// initial effect, done at consumption
int _check_drug_primary(object oPC, int nDC)
{
	// TODO: allow for un-willing taking of the narcotic
#if 0
	return _check_effective(oPC, nDC);
#else
	return TRUE;
#endif
}

// this is done 60 seconds later
int _check_drug_secondary(object oPC, int nDC)
{
	// TODO: allow for un-willing taking of the narcotic
#if 0
	return _check_effective(oPC, nDC);
#else
	return TRUE;
#endif
}

// this does the addiction checks at consumption
int _check_drug_addiction(object oPC, int nDrug)
{
	int b, type;

	type = _get_drug_type(nDrug);
	b =_check_addiction(oPC, type, TRUE, FALSE);

	// cause addiction to be present
	if (b) {
		_add_addiction(oPC, nDrug);
		WriteTimestampedLogEntry("010_drugs_i: " + GetName(oPC) + " has new addiction from "+_get_drug_tag(nDrug));
	}
	

	// satiate the addiction (remove any negative effects)
	_satiate_addiction(oPC, nDrug);

	return b;
}

void _delayed_check(object oPC, int nDC)
{
	if (_check_drug_secondary(oPC, nDC))
		drug_secondary_effect(oPC);
}

void _delayed_side_effect(object oPC)
{
	drug_side_effect(oPC);
}

// daily addiction check
void ACR_ApplyDrugAddictionEffects(object oPC)
{
	int i;

	// cycle through all possible drugs
	for (i=1; i<11; ++i) {
		if (_get_addiction(oPC, i))
			_apply_withdrawl_effect(oPC, i);
	}
}

void ACR_ConsumeDrug(object oPC, int nDrug, int nDC, int bOverdoseOnly = FALSE)
{
	_check_drug_addiction(oPC, nDrug);

	if (_check_overdose(oPC, nDrug, nDC)) {
		drug_overdose_effect(oPC);

		if (bOverdoseOnly)
			return;
	}

	AssignCommand(oPC, DelayCommand(TurnsToSeconds(1), _delayed_check(oPC, nDC)));
	AssignCommand(oPC, DelayCommand(RoundsToSeconds(1), _delayed_side_effect(oPC)));


	if (_check_drug_primary(oPC, nDC))
		drug_primary_effect(oPC);

}

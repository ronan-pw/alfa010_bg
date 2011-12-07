const int _WILD_MAGIC_NORMAL	= 0;
const int _WILD_MAGIC_MAX	= 1;
const int _WILD_MAGIC_NOEX	= 2;
const int _WILD_MAGIC_FAIL	= 3;
const int _WILD_MAGIC_FAIL_NOEX	= 4;
const int _WILD_MAGIC_REBOUND	= 5;
const int _WILD_MAGIC_RANDOM	= 6;
const int _WILD_MAGIC_RAIN	= 7;
const int _WILD_MAGIC_DARK	= 8;
const int _WILD_MAGIC_HEAL	= 9;
const int _WILD_MAGIC_RGRAV	= 10;
const int _WILD_MAGIC_GLITTER	= 11;
const int _WILD_MAGIC_PIT	= 12;


const float _WILD_MAGIC_TEMP_DUR	= 30.0f;
const float _WILD_MAGIC_SHORT_DUR	= 6.0f;

const float _WILD_MAGIC_TARGET_SEARCH_RADIUS = 15.0f;
const float _WILD_MAGIC_PIT_RADIUS	= 7.5f;
const float _WILD_MAGIC_EFFECT_RADIUS	= 30.0f;
const float _WILD_MAGIC_RANDOM_STD	= 10.0f;

#include "acr_effects_i"

void ACR_EffectInRadius(object oCaster, float fRadius, effect eff, string sMsg, int nEffectType=DURATION_TYPE_INSTANT, float fDuration = 0.0f)
{
	location loc = GetLocation(oCaster);
	object o;

	for (ObjectToInt(o = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, loc)); GetIsObjectValid(o); ObjectToInt(o = GetNextObjectInShape(SHAPE_SPHERE, fRadius, loc))) {
		SendMessageToPC(o, sMsg);
		ApplyEffectToObject(nEffectType, eff, o, fDuration);
	}
}

void ACR_RemoveInvisInRadius(object oCaster, float fRadius)
{
	location loc = GetLocation(oCaster);
	object o;

	for (ObjectToInt(o = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, loc)); GetIsObjectValid(o); ObjectToInt(o = GetNextObjectInShape(SHAPE_SPHERE, fRadius, loc))) {
		RemoveAllEffectsFromSource(o, INVISIBILITY_TYPE_IMPROVED);
		RemoveAllEffectsFromSource(o, INVISIBILITY_TYPE_NORMAL);
		RemoveAllEffectsFromSource(o, SPELL_I_WALK_UNSEEN);
	}
}

void ACR_DamageInRadius(object oCaster, float fRadius, int nMagnitude, string sMsg)
{
	effect eff;
	location loc = GetLocation(oCaster);
	object o;

	for (ObjectToInt(o = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, loc)); GetIsObjectValid(o); ObjectToInt(o = GetNextObjectInShape(SHAPE_SPHERE, fRadius, loc))) {
		SendMessageToPC(o, sMsg);
		eff = EffectDamage(d6()*nMagnitude, DAMAGE_TYPE_BLUDGEONING);
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eff, o, 0.0f);
	}
}


object ACR_PickRandomTargetInRadius(object oCaster, float fRadius)
{
	location loc = GetLocation(oCaster);
	object o;
	int n=0;

	for (ObjectToInt(o = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, loc)); GetIsObjectValid(o); ObjectToInt(o = GetNextObjectInShape(SHAPE_SPHERE, fRadius, loc))) {
		++n;
	}

	n = Random(n);

	for (ObjectToInt(o = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, loc)); GetIsObjectValid(o); ObjectToInt(o = GetNextObjectInShape(SHAPE_SPHERE, fRadius, loc))) {
		if (--n < 0)
			return o;
	}

	return OBJECT_INVALID;
}

location ACR_PickRandomLocation(object oCaster)
{
	vector v = GetPosition(oCaster);
	float dir,range,x,y,face;
	location l;
	
	dir = 180.0 * ACR_RandomFloat();
	face = 360.0 * ACR_RandomFloat();
	range = ACR_RandomNormal(0.0f, _WILD_MAGIC_RANDOM_STD);
	
	x = sin(dir) * range;
	y = cos(dir) * range;
	
	v = Vector(v.x+x, v.y+y, v.z);
	
		
	l = Location(GetArea(oCaster), v, face);
	l = CalcSafeLocation(oCaster, l,  _WILD_MAGIC_TARGET_SEARCH_RADIUS, FALSE, FALSE);

	return l;
}


int ACR_DetermineWildMagic()
{
	int n = Random(100)+1;

	// rebounds
	if (n < 20) {
		return _WILD_MAGIC_REBOUND;
	}
	// fails, 7.5 radius pit, 10/cl
	else if (n < 24) {
		return _WILD_MAGIC_PIT;
	}
	// fails, target pelted with objects (blinded 1 round)
	else if (n < 28) {
		return _WILD_MAGIC_RAIN;
	}
	// random target
	else if (n < 32) {
		return _WILD_MAGIC_RANDOM;
	}
	// charge/components not used
	else if (n < 36) {
		return _WILD_MAGIC_NOEX;
	}
	// fails, 30 radius heal spell
	else if (n < 40) {
		return _WILD_MAGIC_HEAL;
	}
	// fails, 30 radius darkness spell (2d4 rounds)
	else if (n < 44) {
		return _WILD_MAGIC_DARK;
	}
	// fails, 30 radius reverse gravity (1 round)
	else if (n < 48) {
		return _WILD_MAGIC_RGRAV;
	}
	// glitterdust 1d4 rounds
	else if (n < 52) {
		return _WILD_MAGIC_GLITTER;
	}
	// fails, components used
	else if (n < 60) {
		return _WILD_MAGIC_FAIL;
	}
	// fails, components not used
	else if (n < 72) {
		return _WILD_MAGIC_FAIL_NOEX;
	}
	// normal
	else if (n < 99) {
	}
	// maximized, +2 to DC
	else {
		return _WILD_MAGIC_MAX;
	}

	return _WILD_MAGIC_NORMAL;	
}


void ACR_CastSpellAt(object oCaster, int nSpellId, object oTarget, location lTarget, int bCastOnLocation, int nMetamagic, int nModifyDC = 0)
{
	object oNewCaster = CopyObject(oCaster, GetLocation(oCaster));
	
	SetScriptHidden(oNewCaster, TRUE);
	SetPlotFlag(oNewCaster, 1);
	
	SetBaseAbilityScore(oNewCaster, ABILITY_INTELLIGENCE, GetAbilityScore(oCaster, ABILITY_INTELLIGENCE, TRUE) + nModifyDC*2);
	SetBaseAbilityScore(oNewCaster, ABILITY_WISDOM, GetAbilityScore(oCaster, ABILITY_WISDOM, TRUE) + nModifyDC*2);
	SetBaseAbilityScore(oNewCaster, ABILITY_CHARISMA, GetAbilityScore(oCaster, ABILITY_CHARISMA, TRUE) + nModifyDC*2);
	
	SetLocalInt(oNewCaster, "_IGNORE_WILD_MAGIC", 1);
	
	if (bCastOnLocation)
		AssignCommand(oNewCaster, ActionCastSpellAtLocation(nSpellId, lTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
	else
		AssignCommand(oNewCaster, ActionCastSpellAtObject(nSpellId, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
		
	AssignCommand(oNewCaster, DestroyObject(oNewCaster, _WILD_MAGIC_TEMP_DUR));
}

int ACR_HandleWildMagic(object oCaster, object oTarget, location lTarget, int nSpellId, object oItem)
{
	int nRes,bCastOnLocation = !GetIsObjectValid(oTarget);
	string sItem;

	nRes = ACR_DetermineWildMagic();

	WriteTimestampedLogEntry("WILD_MAGIC: ("+GetName(oCaster)+","+IntToString(nSpellId)+","+IntToString(nRes)+")");
	
	if (GetLocalInt(oCaster, "_IGNORE_WILD_MAGIC"))
		return nRes;

	if (nRes == _WILD_MAGIC_NORMAL)
		return nRes;

	SendMessageToPC(oCaster,"You feel oddly disorented and something goes awry!");
	SetModuleOverrideSpellScriptFinished();
	
	// Rebounding when original target = self
	if (nRes == _WILD_MAGIC_REBOUND && oCaster == oTarget)
		nRes = _WILD_MAGIC_RANDOM;

	switch (nRes) {
		case _WILD_MAGIC_REBOUND:
			oTarget = oCaster;
			lTarget = GetLocation(oCaster);
			
			ACR_CastSpellAt(oCaster, nSpellId, oTarget, lTarget, METAMAGIC_ANY, bCastOnLocation);

			SendMessageToPC(oCaster,"The magical effect vanishes and rebounds upon you!");
			break;
				
		case _WILD_MAGIC_RANDOM:
			oTarget =  ACR_PickRandomTargetInRadius(oCaster, _WILD_MAGIC_EFFECT_RADIUS);
			lTarget = ACR_PickRandomLocation(oCaster);
			
			ACR_CastSpellAt(oCaster, nSpellId, oTarget, lTarget, METAMAGIC_ANY, bCastOnLocation);

			SendMessageToPC(oCaster,"The magical effect vanishes and rebounds elsewhere!");
			break;

		case _WILD_MAGIC_RGRAV:
			ACR_EffectInRadius(oCaster, _WILD_MAGIC_EFFECT_RADIUS, EffectVisualEffect(VFX_SPELL_HIT_EARTHQUAKE), "You feel an intense sense of vertigo!", DURATION_TYPE_INSTANT);
			
			SendChatMessage(oCaster, oCaster, CHAT_MODE_TALK, "<i>*Suddenly everything around "+GetName(oCaster)+" begins floating up -- then shortly after slams down back into the ground.*");
			
			ACR_DamageInRadius(oCaster, _WILD_MAGIC_EFFECT_RADIUS, 2, "For a moment you float into the air, then you slam down back onto the ground painfully."); 
			break;

		case _WILD_MAGIC_PIT:
			ACR_EffectInRadius(oCaster, _WILD_MAGIC_EFFECT_RADIUS, EffectVisualEffect(VFX_SPELL_HIT_EARTHQUAKE), "The earth shakes about you.", DURATION_TYPE_INSTANT);
			
			SendChatMessage(oCaster, oCaster, CHAT_MODE_TALK, "<i>*A gaping pit opens under "+GetName(oCaster)+", causing the person to tumble down within and slam painfully into the bottom.  Almost as soon as it appears it vanishes, leaving everything as it was before.*");
			
			ACR_DamageInRadius(oCaster, _WILD_MAGIC_PIT_RADIUS, GetCasterLevel(oCaster), "A gaping hole opens underneath you and you slam into the ground, causing a great deal of pain."); 
			break;

		case _WILD_MAGIC_FAIL:
		case _WILD_MAGIC_FAIL_NOEX:
			SendMessageToPC(oCaster,"The magical effect fizzles into nothingness.");
			break;
			
		case _WILD_MAGIC_RAIN:
			switch (Random(5)) {
				case 0:
					sItem = "frogs";
					break;
				case 1:
					sItem = "flowers";
					break;
				case 2:
					sItem = "hot coals";
					break;
				case 3:
					sItem = "leaves";
					break;
				default:
					sItem = "rotten fruit";
			}
					
			SendChatMessage(oCaster, oCaster, CHAT_MODE_TALK, "<i>*Suddenly a storm of falling "+sItem+" begins raining down on the area, vanshing almost as soon as it appeared.*");
			ACR_EffectInRadius(oCaster, _WILD_MAGIC_EFFECT_RADIUS, EffectLinkEffects(EffectVisualEffect(VFX_DUR_DARKNESS), EffectBlindness()), "The hailstorm blinds you!", DURATION_TYPE_TEMPORARY, _WILD_MAGIC_SHORT_DUR);
			
			break;

		case _WILD_MAGIC_HEAL:
			ACR_EffectInRadius(oCaster, _WILD_MAGIC_EFFECT_RADIUS, EffectLinkEffects(EffectVisualEffect(VFX_IMP_HEALING_X), EffectHeal(999)), "A surge of healing energy flows through you.", DURATION_TYPE_INSTANT);
			break;

		case _WILD_MAGIC_DARK:
			ACR_EffectInRadius(oCaster, _WILD_MAGIC_EFFECT_RADIUS, EffectLinkEffects(EffectVisualEffect(VFX_DUR_DARKNESS), EffectDarkness()), "A cloud of blackness surrounds you.", DURATION_TYPE_TEMPORARY, IntToFloat(d4()+d4())*_WILD_MAGIC_SHORT_DUR);
			break;

		case _WILD_MAGIC_GLITTER:
			ACR_EffectInRadius(oCaster, _WILD_MAGIC_EFFECT_RADIUS, EffectLinkEffects(EffectVisualEffect(VFX_DUR_GLOW_WHITE), EffectBlindness()), "Glittering lights fill the surrounding area, blinding you.", DURATION_TYPE_TEMPORARY, IntToFloat(d4())*_WILD_MAGIC_SHORT_DUR);
			ACR_RemoveInvisInRadius(oCaster, _WILD_MAGIC_EFFECT_RADIUS);
			break;

		case _WILD_MAGIC_MAX:
		case _WILD_MAGIC_NOEX:
		default:
			ACR_CastSpellAt(oCaster, nSpellId, oTarget, lTarget, METAMAGIC_MAXIMIZE, bCastOnLocation, 2);

			SendMessageToPC(oCaster,"The magical effect intensifies, visibly!");

			break;
	}

	return nRes;
}

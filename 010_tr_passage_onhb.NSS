void main() {
	object oCreature = GetFirstObjectInArea(OBJECT_SELF);
	while(oCreature != OBJECT_INVALID) {
		int nSize = GetCreatureSize(oCreature);
		if(GetHasSpellEffect(SPELL_REDUCE_PERSON, oCreature) || GetHasSpellEffect(SPELL_REDUCE_PERSON_GREATER, oCreature) || GetHasSpellEffect(SPELL_REDUCE_PERSON_MASS, oCreature)) {
			SendMessageToPC(oCreature, "Your spell helps you naviagte this narrow corridor.");
			nSize--;
		}
		
		if(GetHasSpellEffect(SPELL_ENLARGE_PERSON, oCreature))
			nSize++;
		
		if(GetCreatureSize(oCreature) > CREATURE_SIZE_SMALL && GetSubRace(oCreature) != RACIAL_SUBTYPE_OOZE) {
			SendMessageToPC(oCreature, "You're now too large to fit down this narrow passage - you get stuck in place!");
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oCreature, 6.5);
		}
		oCreature = GetNextObjectInArea(OBJECT_SELF);
	}
}
void main() {
	object oTrigger = GetNearestObject(OBJECT_TYPE_TRIGGER);
	int i = 0;
	while(oTrigger != OBJECT_INVALID) {
		if(GetLocalInt(oTrigger, "ACR_SWIM_DC")) {
			// Found a swim trigger. Damage everyone inside it.
			ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_ELECTRIC_EXPLOSION), GetLocation(OBJECT_SELF));
			
			int iDamageDice = GetLocalInt(OBJECT_SELF, "ACR_TRAP_DAMAGE");
			object oCreature = GetFirstInPersistentObject(oTrigger);
			effect eVisualEffect = EffectVisualEffect(VFX_COM_HIT_ELECTRICAL);
			while(oCreature != OBJECT_INVALID) {
				float fDistance = GetDistanceBetween(OBJECT_SELF, oCreature);
				ApplyEffectToObject(
					DURATION_TYPE_INSTANT,
					EffectLinkEffects(eVisualEffect, EffectDamage(d6(iDamageDice) * FloatToInt(pow(0.5, fDistance / 10)), DAMAGE_TYPE_ELECTRICAL)),
					oCreature);
					
				oCreature = GetNextInPersistentObject(oTrigger);
			}
			break;
		}
		i++;
		oTrigger = GetNearestObject(OBJECT_TYPE_TRIGGER, OBJECT_SELF, i);
	}
}
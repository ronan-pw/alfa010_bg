void main()
{
    object oStatue = GetNearestObject(OBJECT_TYPE_CREATURE);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,
          SupernaturalEffect(EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION)),
          oStatue);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,
          SupernaturalEffect(EffectVisualEffect(VFX_DUR_PROT_STONESKIN)),
          oStatue);
    DestroyObject(OBJECT_SELF);
}
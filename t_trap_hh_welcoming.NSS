#include "NW_I0_SPELLS"

void main()
{

    object oPC = GetEnteringObject();
    int nDamage;
    int nDC = 14;
    effect eLightning = EffectVisualEffect(VFX_IMP_LIGHTNING_M,FALSE);
    effect eDam;
    float fDelay;

    if (GetIsObjectValid (oPC) == TRUE)

    {
        if (!MyResistSpell(OBJECT_SELF, oPC))
            {
                //Roll damage for each target
                nDamage = d4(2);
                //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
                nDamage = GetReflexAdjustedDamage(nDamage, oPC, nDC, SAVING_THROW_TYPE_ELECTRICITY);
                //Set the damage effect
                eDam = EffectDamage (nDamage, DAMAGE_TYPE_ELECTRICAL);
                //Apply Damage
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oPC);

            }

     }

       ApplyEffectToObject(DURATION_TYPE_INSTANT, eLightning, oPC);



}
void main()
{
effect eDam;
object oPitvictim = GetEnteringObject(); //That's the PC who might fall
location lLoc = GetLocation(oPitvictim); //The initial place of the falling PC
object oWay = GetNearestObjectByTag("DST_PITFALL"); //That's where he is going to land
effect eRock = EffectVisualEffect(137);
effect eDust = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION);

if(GetIsPC(oPitvictim) == TRUE) {


AssignCommand (oPitvictim, PlaySound("as_na_rockfalsm4"));
ApplyEffectAtLocation( DURATION_TYPE_INSTANT, eRock, lLoc, 4.0 );
int rSave = ReflexSave(oPitvictim, 22, SAVING_THROW_TYPE_TRAP, OBJECT_SELF);

if (rSave==0)

    {
    AssignCommand(oPitvictim, ActionJumpToLocation(GetLocation(oWay)));
    FloatingTextStringOnCreature("You've fallen into a pit!", oPitvictim, FALSE);
    PlayVoiceChat(13 + d3(), oPitvictim);
    eDam = EffectDamage(d6(2), DAMAGE_TYPE_BLUDGEONING); //The damage roll
    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oPitvictim));

    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), oPitvictim);
    AssignCommand(oPitvictim, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 10.0));
//      AssignCommand(oPitvictim, SetCommandable(0));
//      DelayCommand(10.0, SetCommandable(1, oPitvictim));
    FloatingTextStringOnCreature("ouch...", oPitvictim, FALSE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDust,oPitvictim);
    AssignCommand (oPitvictim, PlaySound("as_na_rockfalsm4"));
    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), oPitvictim));
    DelayCommand(1.5, ApplyEffectToObject(DURATION_TYPE_INSTANT,eDust,oPitvictim));
    DelayCommand(2.0, AssignCommand (oPitvictim, PlaySound("as_na_rockfalsm1")));
    }

else
    {
    FloatingTextStringOnCreature("You've managed to avoid a pit!", oPitvictim, FALSE);
   DelayCommand(2.0, PlayVoiceChat(VOICE_CHAT_CUSS, oPitvictim));
    }
    }
}
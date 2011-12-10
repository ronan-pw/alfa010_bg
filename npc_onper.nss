//::///////////////////////////////////////////////
//:: Default On Perceive
//:: NW_C2_DEFAULT2
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Checks to see if the perceived target is an
    enemy and if so fires the Determine Combat
    Round function
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//:://////////////////////////////////////////////

#include "hench_i0_ai"
#include "ginc_behavior"


void npc_onper()
{
// * if not running normal or better Ai then exit for performance reasons
    // * if not running normal or better Ai then exit for performance reasons
    if (GetAILevel() == AI_LEVEL_VERY_LOW) return;

        // script hidden object shouldn't react (for cases where AI not turned off)
    if (GetScriptHidden(OBJECT_SELF)) return;

    int iFocused = GetIsFocused();


    int bSeen = GetLastPerceptionSeen();
    if ((iFocused <= FOCUSED_STANDARD) && bSeen)
    {
        if (!IsInConversation(OBJECT_SELF))
        {
                if ((GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS)
                    || GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS_AVIAN)
                    || GetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS)))
                {
                    SetAnimationCondition(NW_ANIM_FLAG_IS_ACTIVE);
                }
        }
    }
}

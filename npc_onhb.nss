#include "hench_i0_ai"

// for incredibly low cpu-use npcs

void npc_immobile()
{
    if (!GetAnimationCondition(NW_ANIM_FLAG_INITIALIZED)) {
        // If we've been set to be constant, flag us as
        // active.
        // if (GetAnimationCondition(NW_ANIM_FLAG_CONSTANT))
        SetAnimationCondition(NW_ANIM_FLAG_IS_ACTIVE);
	SetAnimationCondition(NW_ANIM_FLAG_INITIALIZED);

        // also save our starting location
        SetLocalLocation(OBJECT_SELF,
                         "ANIM_START_LOCATION",
                         GetLocation(OBJECT_SELF));
    }

    // Short-circuit everything if we're not active yet
    if (!GetAnimationCondition(NW_ANIM_FLAG_IS_ACTIVE))
        return;

    // Check if we should turn off
    if (!CheckIsAnimActive(OBJECT_SELF))
        return;

    // Check current actions so we don't interrupt something in progress
    if (CheckCurrentAction()) {
        return;
    }

    if (GetAnimationCondition(NW_ANIM_FLAG_IS_MOBILE_CLOSE_RANGE)) {
        AnimActionPlayRandomCloseRange();
    } else {
        AnimActionPlayRandomImmobile();
    }
}

void npc_mobile()
{
    if (!GetAnimationCondition(NW_ANIM_FLAG_INITIALIZED)) {
        // General initialization
        SetAnimationCondition(NW_ANIM_FLAG_INITIALIZED);

        // Mark us as mobile
        SetAnimationCondition(NW_ANIM_FLAG_IS_ACTIVE);
        SetAnimationCondition(NW_ANIM_FLAG_IS_MOBILE);
    }

    // Short-circuit everything if we're not active yet
    if (!GetAnimationCondition(NW_ANIM_FLAG_IS_ACTIVE))
        return;

    // Check if we should turn off
    if (!CheckIsAnimActive(OBJECT_SELF))
        return;

    // If we fell through or got a random number
    // less than 7, go to a stop waypoint, or random
    // walk if no stop waypoints were found.
    if (d8() == 0) {
        ClearActions(CLEAR_X0_I0_ANIMS_AnimActionPlayRandomMobile2);
        ActionRandomWalk();
        return;
    }

    npc_immobile();
}

void npc_onhb()
{
    // * if not running normal or better AI then exit for performance reasons
    if (GetAILevel() == AI_LEVEL_VERY_LOW) return;

    // If we have the 'constant' waypoints flag set, walk to the next
    // waypoint.
    if (!GetIsObjectValid(GetNearestSeenOrHeardEnemyNotDead(HENCH_MONSTER_DONT_CHECK_HEARD_MONSTER)))
    {
            SetLocalInt(OBJECT_SELF, HENCH_AI_SCRIPT_POLL, FALSE);
            if (GetWalkCondition(NW_WALK_FLAG_CONSTANT))
            {
                WalkWayPoints();
            }
            else
            {
                    if(GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS) ||
                        GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS_AVIAN))
                    {
                        npc_mobile();
                    }
                    else if(GetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS))
                    {
                        PlayImmobileAmbientAnimations();
                    }
            }
    }
}

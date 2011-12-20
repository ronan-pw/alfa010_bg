#include "hench_i0_ai"

// for incredibly low cpu-use npcs

void anim_immobile()
{
    int nRoll = Random(12);

    //SpawnScriptDebugger();


    // If we're talking, either keep going or stop.
    // Low prob of stopping, since both parties have
    // a chance and conversations are cool.
    if (GetAnimationCondition(NW_ANIM_FLAG_IS_TALKING))	
	{
        object oFriend = GetCurrentFriend();
        int nHDiff = GetHitDice(OBJECT_SELF) - GetHitDice(oFriend);

        if (nRoll == 0) {
            AnimActionStopTalking(oFriend, nHDiff);
        } else {
            AnimActionPlayRandomTalkAnimation(nHDiff);
        }
        return;
    }

    // If we're interacting with a placeable, either keep going or
    // stop. High probability of stopping, since looks silly to
    // constantly turn something on-and-off.
    if (GetAnimationCondition(NW_ANIM_FLAG_IS_INTERACTING)) {
        if (nRoll < 4) {
            AnimActionStopInteracting();
        } else {
            AnimActionPlayRandomInteractAnimation(GetCurrentInteractionTarget());
        }
        return;
    }

    // If we got here, we're not busy at the moment.

    // Clean out the action queue
    ClearActions(CLEAR_X0_I0_ANIMS_PlayRandomMobile);
    if (nRoll <=9) {
        if (AnimActionFindFriend(DISTANCE_LARGE))
            return;
    }

    if (nRoll > 9) {
        // Try and interact with a nearby placeable
        if (AnimActionFindPlaceable(DISTANCE_SHORT))
            return;
    }

    AnimActionPlayRandomAnimation();
}

void anim_close()
{
    if (GetIsBusyWithAnimation(OBJECT_SELF)) {
        // either we're already in conversation or
        // interacting with something, so continue --
        // all handled already in RandomImmobile.
        anim_immobile();
        return;
    }

    // If we got here, we're not busy

    // Clean out the action queue
    ClearActions(CLEAR_X0_I0_ANIMS_PlayRandomCloseRange1);

    // Possibly close open doors
    if (GetAnimationCondition(NW_ANIM_FLAG_CLOSE_DOORS) && AnimActionCloseRandomDoor()) {
        return;
    }

    // For the rest of these, we check for specific rolls,
    // to ensure that we don't do a lot of lookups on any one
    // given pass.

    int nRoll = Random(6);

    // Possibly start talking to a friend
    if (nRoll == 0 || nRoll == 1) {
        if (AnimActionFindFriend(DISTANCE_LARGE))
            return;
        // fall through to default
    }

    // Possibly start fiddling with a placeable
    if (nRoll == 2) {
        if (AnimActionFindPlaceable(DISTANCE_LARGE))
            return;
        // fall through if no placeable found
    }

    // Possibly sit down
    if (nRoll == 3) {
        if (AnimActionSitInChair(DISTANCE_LARGE))
            return;
    }

    // Go to a nearby stop
    if (nRoll == 4) {
        if (AnimActionGoToStop(DISTANCE_LARGE)) {
            return;
        }

        // No stops, so do a random walk and then come back
        // to our current location
        ClearActions(CLEAR_X0_I0_ANIMS_PlayRandomCloseRange2);
        location locCurr = GetLocation(OBJECT_SELF);
        ActionRandomWalk();
        ActionMoveToLocation(locCurr);
    }

    if (nRoll == 5 && !GetAnimationCondition(NW_ANIM_FLAG_IS_MOBILE)) {
        // Move back to starting point, saved at initialization
        ActionMoveToLocation(GetLocalLocation(OBJECT_SELF,
                                              "ANIM_START_LOCATION"));
        return;
    }

    // Default: do a random immobile animation
    anim_immobile();
}

void npc_immobile()
{
    // skip 3/4
    if (Random(4) != 0)
	    return;

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
        anim_close();
    } else {
        anim_immobile();
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
                        anim_immobile();
                    }
            }
    }
}

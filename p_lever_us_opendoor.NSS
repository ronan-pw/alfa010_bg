// Get nearest door tagged 'd_lock_lever' and open it onuse or close it.

void main()
{
    object oDoor = GetNearestObjectByTag("d_lock_lever");
    ActionUnlockObject(oDoor);
    PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    DelayCommand(2.0,PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));

    if (GetIsOpen(oDoor))
        ActionCloseDoor(oDoor); // door is closed, open it


    else
        ActionOpenDoor(oDoor); // door is open, close it

}


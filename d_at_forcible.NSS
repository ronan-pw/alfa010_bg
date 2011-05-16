/*
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
PURPOSE: Generic doorguard/chestguard script.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
*/
#include "inc_functions"


void main()
{


// Finds who last damaged the chest/door and sets a referance outside of the radius used later in the script
// and also some variables that are going to be updated later.
object Player1 = GetLastDamager();
float DistanceRef = 31.0;
int i;
float DistanceMin = 0.0;
object DoorGuard0;
 // Start Bash Open Script
    object oAttacker=GetLastAttacker();
    int unlockDC=GetLockUnlockDC(OBJECT_SELF)-10;
    int abilitymod=GetAbilityModifier(ABILITY_STRENGTH, oAttacker);
    int roll=d20();
    int result=roll+abilitymod;
    string sRoll=IntToString(roll);
    string sRank=IntToString(abilitymod);
    string sResult=IntToString(result);

    AssignCommand( oAttacker, SpeakString("Strength Check, Roll: "+sRoll+" Modifier: "+sRank+" = "+sResult));
    if(result > unlockDC || roll==20)   //perfect 20 will always succeed.
    {
        SetLocked(OBJECT_SELF, FALSE);
        DestroyObject(OBJECT_SELF);
      //  SpeakString("You forced the door open.");
    }
    else
    {
     //   SpeakString("You failed to force the door open.");
    }
 // End Bash Open Script



}

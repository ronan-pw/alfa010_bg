// gc_check_item
/*
    This script checks to see if the PC has memorized a spell
        nSpell - The spell to check for
*/

int StartingConditional(int nSpell)
{
object oPC = GetPCSpeaker();
if(GetHasSpell(nSpell, oPC)) return TRUE;

return FALSE;


}
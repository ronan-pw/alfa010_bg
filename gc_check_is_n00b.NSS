// gc_check_item
/*
    This script checks to see if the PC is new
*/

int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetXP(oPC) <= 15) return TRUE;

else return FALSE;


}
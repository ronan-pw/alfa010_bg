// gc_check_item
/*
    This script checks to see if the PC is new
*/

int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetPCPlayerName(oPC) == "ayergovich") return TRUE;
if(GetPCPlayerName(oPC) == "HEEGZ") return TRUE;

else return FALSE;


}
// set persistent int shell
#include "acr_db_persist_i"


void main(string plot, int val)
{
    object oPC = GetPCSpeaker();
	string name = "i_qst_"+plot;

	ACR_SetPersistentInt(oPC, name, val);
}
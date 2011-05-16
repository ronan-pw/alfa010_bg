// ga_remove spell
/*
PC Casts a spell at a target

nspell - spell to decrement	
*/
// Casting a spell at target



void main(int nSpell)
{
    object oPC = GetPCSpeaker();


	DecrementRemainingSpellUses(oPC, nSpell);
}
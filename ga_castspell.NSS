// ga_spell
/*
Casts a spell at a target	
*/
// Casting a spell at target







void main(int nSpell, int nLevel)
{
    object oPC = GetPCSpeaker();


	object oTarget = oPC;	
	ActionCastSpellAtObject(nSpell,oTarget,0,1,nLevel,0,0);
	//DoEffect(sEffect, sParams, sDuration, iVisualEffect, oTarget, sDelim);
}
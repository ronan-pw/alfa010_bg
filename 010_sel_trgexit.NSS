void main()
{
	object oPC = GetExitingObject();
	effect eEffect = GetFirstEffect(oPC);
	while(GetIsEffectValid(eEffect))
	{
		if(GetEffectCreator(eEffect) == OBJECT_SELF)
			RemoveEffect(oPC, eEffect);
		eEffect = GetNextEffect(oPC);
	}
}
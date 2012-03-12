
int StartingConditional(string sChain, int nCheck)
{
	object oPC = GetPCSpeaker();
	string sPC = GetName(oPC);
	if(GetStringLength(sPC) > 15)
		sPC = GetStringLeft(sPC, 15);
	if(sChain == "skill")
	{
		if(GetSkillRank(nCheck, oPC) > 0)
			return TRUE;	
	}
	
	if(sChain == "ssil")
	{
		if(nCheck == 1)
		{
		/* Check 1 checks if Ssil is willing to give the PC has failed a job from Ssil. */	
			int nVar = GetLocalInt(GetModule(), sPC+"SSIL_WORK");
			if(nVar == 1)
			/* The work Ssil has given is complete, but failed. */
				return TRUE;
		}
		else if(nCheck == 2)
		/* Check 2 checks if Ssil knows the PC is evil. */
		{
			int nVar = GetLocalInt(GetModule(), sPC+"SSIL_WORK");
			if(nVar == 2)
			/* Ssil remembers this PC, and knows he/she is evil. */
				return TRUE;
		}
		else if(nCheck == 3)
		/* Check 3 checks if Ssil has given the PC work. */
		{
			int nVar = GetLocalInt(GetModule(), sPC+"SSIL_WORK");
			if(nVar == 3)
			/* The work Ssil has given is already in progress. */
				return TRUE;		
		}
		else if(nCheck == 4)
		/* Check 4 checks if the work is unrewarded. */
		{
			int nVar = GetLocalInt(GetModule(), sPC+"SSIL_WORK");
			if(nVar == 4)
			/* The work Ssil has given is complete and unrewarded. */
				return TRUE;	
		}
		else if(nCheck == 5)
		/* Check 4 checks if the work is complete. */
		{
			int nVar = GetLocalInt(GetModule(), sPC+"SSIL_WORK");
			if(nVar == 5)
			/* The work Ssil has given is complete. */
				return TRUE;		
		}
	}
	return FALSE;
}
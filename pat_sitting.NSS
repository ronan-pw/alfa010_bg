//::///////////////////////////////////////////////
//:: OnUse: Sit
//:: pat_sitted
//:://////////////////////////////////////////////
/*
    Simple script to make PCs sit on a placeable
*/
//:://////////////////////////////////////////////
//:: Created By: Patcha
//:: Created On: 2006-12-08
//:: v1.76 By: Patcha
//:: v1.73 On: 2007-06-15
//:: dates: aaaa-mm-gg
//:://////////////////////////////////////////////

void ActionPlayCustomAnimation(object oObject, string sAnimationName, int nLooping, float fSpeed = 1.0f)
{
    PlayCustomAnimation(oObject, sAnimationName, nLooping, fSpeed);
}

// float GetNormalizedDirection(float fDirection):
// * This script returns a direction normalized to the range 0.0 - 360.0
// * Copyright (c) 2002 Floodgate Entertainment
// * Created By: Naomi Novik
// * Created On: 11/08/2002
float GetNormalizedDirection(float fDirection)
{
    float fNewDir = fDirection;
    while (fNewDir >= 360.0) {
        fNewDir -= 360.0;
    }
    while (fNewDir <= 0.0) {
        fNewDir += 360.0;
    }

    return fNewDir;
}

void main()
{
	object oChair = OBJECT_SELF;
	object oSitter = GetLastUsedBy();
    object oLastSitter = GetLocalObject(oChair, "lastsitted");
    string sChair = GetTag(oChair);
    string sAutofit = GetLocalString(oChair, "autofit");
	int iHeading  = GetLocalInt(oChair, "degree");
	int iPC_size  = GetLocalInt(oChair, "size");
    //Assign the heading degrees
	location lChair_o = GetLocation(oChair);
    location lChair = Location(GetArea(oChair), GetPositionFromLocation(lChair_o), GetNormalizedDirection(GetFacingFromLocation(lChair_o) + iHeading));
	
    //Check if seat is free
    if(GetDistanceBetween(oLastSitter, oChair) == 0.0f && GetArea(oLastSitter) == GetArea(oChair))
    {
        SetLocalInt(oChair, "taken", 1);
        SpeakOneLinerConversation("", OBJECT_INVALID, TALKVOLUME_WHISPER);
    }
    else //if seat is free...
    {
        SetLocalInt(oChair, "taken", 0);

    	//Check for Character Race with original Creature Size
    	switch (iPC_size)
    	{
    	case 0:
		    //Check for Character Race with original Creature Size
		    if(	((GetRacialType(oSitter) == RACIAL_TYPE_DWARF) && (GetCreatureSize(oSitter) == CREATURE_SIZE_MEDIUM)) ||
			    ((GetRacialType(oSitter) == RACIAL_TYPE_ELF) && (GetCreatureSize(oSitter) == CREATURE_SIZE_MEDIUM)) ||
    			((GetRacialType(oSitter) == RACIAL_TYPE_HALFELF) && (GetCreatureSize(oSitter) == CREATURE_SIZE_MEDIUM)) ||
			    ((GetRacialType(oSitter) == RACIAL_TYPE_HALFORC) && (GetCreatureSize(oSitter) == CREATURE_SIZE_MEDIUM)) ||
			    ((GetRacialType(oSitter) == RACIAL_TYPE_HUMAN) && (GetCreatureSize(oSitter) == CREATURE_SIZE_MEDIUM)) ||
			    ((GetSubRace(oSitter) == RACIAL_SUBTYPE_AASIMAR) && (GetCreatureSize(oSitter) == CREATURE_SIZE_MEDIUM)) ||
			    ((GetSubRace(oSitter) == RACIAL_SUBTYPE_TIEFLING) && (GetCreatureSize(oSitter) == CREATURE_SIZE_MEDIUM)))
		    {
    			if(GetIsObjectValid(oChair) && GetIsObjectValid(oSitter))
			    {
    				AssignCommand(oSitter, ActionMoveToLocation(lChair));
				    DelayCommand(1.5, AssignCommand(oSitter, SetFacing( GetNormalizedDirection(GetFacing(oChair)+180.00+GetLocalFloat(oChair,"rotate")) )));
					DelayCommand(2.5, AssignCommand(oSitter, ActionPlayCustomAnimation(OBJECT_SELF, "sitidle", 1, 1.0)));
                    SetLocalObject(oChair, "lastsitted", oSitter);
			    }
		    }
		    else
            {
                if(sAutofit != "")
                {
                    AssignCommand(oChair, SetIsDestroyable(TRUE, FALSE));
                    AssignCommand(oSitter, DestroyObject(oChair));
                    oChair = CreateObject(OBJECT_TYPE_PLACEABLE, "pat_low_" + sAutofit, lChair_o, FALSE, sChair);
                    if(!(GetIsObjectValid(oChair)))
                        oChair = CreateObject(OBJECT_TYPE_PLACEABLE, "pat_low_stool01", lChair_o, FALSE, sChair);
				    SetLocalString(oChair, "autofit", sAutofit);
	                SetLocalInt(oChair, "degree", iHeading);
	                SetLocalInt(oChair, "size", 1);
                    SetLocalObject(oChair, "lastsitted", oSitter);
                }
                else
		        SpeakOneLinerConversation("", OBJECT_INVALID, TALKVOLUME_WHISPER);
            }
		    break;

    	case 1:
		    //Check for Character Race with original Creature Size
		    if(	((GetRacialType(oSitter) == RACIAL_TYPE_DWARF) && (GetCreatureSize(oSitter) == CREATURE_SIZE_MEDIUM)) ||
			    ((GetRacialType(oSitter) == RACIAL_TYPE_GNOME) && (GetCreatureSize(oSitter) == CREATURE_SIZE_SMALL)) ||
    			((GetRacialType(oSitter) == RACIAL_TYPE_HALFLING) && (GetCreatureSize(oSitter) == CREATURE_SIZE_SMALL)))
		    {
    			if(GetIsObjectValid(oChair) && GetIsObjectValid(oSitter))
			    {
    				AssignCommand(oSitter, ActionMoveToLocation(lChair));
				    DelayCommand(1.5, AssignCommand(oSitter, SetFacing( GetNormalizedDirection(GetFacing(oChair)+180.0+GetLocalFloat(oChair,"rotate")) )));
					DelayCommand(2.5, AssignCommand(oSitter, ActionPlayCustomAnimation(OBJECT_SELF, "sitidle", 1, 1.0)));
                    SetLocalObject(oChair, "lastsitted", oSitter);
			    }
		    }
		    else
            {
                if(sAutofit != "")
                {
                    AssignCommand(oChair, SetIsDestroyable(TRUE, FALSE));
                    AssignCommand(oSitter, DestroyObject(oChair));
                    oChair = CreateObject(OBJECT_TYPE_PLACEABLE, "pat_mid_" + sAutofit, lChair_o, FALSE, sChair);
                    if(!(GetIsObjectValid(oChair)))
                        oChair = CreateObject(OBJECT_TYPE_PLACEABLE, "pat_mid_stool01", lChair_o, FALSE, sChair);
				   	SetLocalString(oChair, "autofit", sAutofit);
	                SetLocalInt(oChair, "degree", iHeading);
	                SetLocalInt(oChair, "size", 0);
                    SetLocalObject(oChair, "lastsitted", oSitter);
                }
                else
		        SpeakOneLinerConversation("", OBJECT_INVALID, TALKVOLUME_WHISPER);
            }
		    break;

	    default:
    		//Character with no original Race and/or Creature size
	        SpeakOneLinerConversation("", OBJECT_INVALID, TALKVOLUME_WHISPER);
		    break;
	    }
	}
}
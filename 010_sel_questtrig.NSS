#include "acr_quest_i"
#include "acr_notifications_i"

int GetPartyMemberHasQuest(object oPC, string sQuest)
{
	object oMember = GetFirstFactionMember(oPC);
	while(GetIsObjectValid(oMember))
	{	
		int nState = ACR_RetrieveQuestState(sQuest, oMember);
		if(nState > 0 && nState < 4 &&
		   GetLocalInt(OBJECT_SELF, IntToString(ACR_GetCharacterID(oMember))) == 0)
			return TRUE;
		oMember = GetNextFactionMember(oPC);			
	}
	return FALSE;
}

void main()
{
	string sQuest = GetLocalString(OBJECT_SELF, "QUEST_NAME");
	
	object oPC = GetEnteringObject();
	
	if(sQuest == "sel_ssil_scout_01")
	{
		// No one needs this quest to be advanced. Best return now.
		if(!GetPartyMemberHasQuest(oPC, sQuest))
			return;
		
		// Make checks to see if scouting was successful.
		int nAdvance = FALSE;		
		if(GetHasFeat(FEAT_TRACK, oPC))
			nAdvance = TRUE;
		else if(GetIsSkillSuccessful(oPC, SKILL_SURVIVAL, 10, TRUE))
			nAdvance = TRUE;
		
		if(nAdvance == TRUE)
		{
			// Loop through party members; assume that these people
			// would tell their friends.
			object oAdvancing = GetFirstFactionMember(oPC);
			while(GetIsObjectValid(oAdvancing))
			{
				int nState = ACR_RetrieveQuestState(sQuest, oAdvancing);
				
				// Make sure that the PC has the quest, but check here so they can
				// get help from people who don't have the quest.
				// Also make sure that the PC hasn't advanced from this trigger already
				// and is in the same area s the one who scouted.
				if(nState > 0 && nState < 5 &&
				   GetLocalInt(OBJECT_SELF, IntToString(ACR_GetCharacterID(oAdvancing))) == 0 &&
				   GetArea(oAdvancing) == GetArea(oPC))
				{
					nState++;

					SetLocalInt(OBJECT_SELF, IntToString(ACR_GetCharacterID(oAdvancing)), 1);					
					NotifyPlayer(oAdvancing, NOTIFY_TYPE_INFO, GetLocalString(OBJECT_SELF, "QUEST_MESSAGE_SHORT"), GetLocalString(OBJECT_SELF, "QUEST_MESSAGE"), NOTIFY_WINDOW_MESSAGE_BOX,"","","OK");
					
					// Allow for anyone who hasn't turned in the quest to learn more, 
					// even though the rewards won't change.
					if(nState != 5)
					{
				    	ACR_AddPersistentJournalQuestEntry(sQuest, nState, oPC, FALSE, FALSE, FALSE, 0);
					}
				}
				oAdvancing = GetNextFactionMember(oPC);
			}
		}
		SetLocalInt(OBJECT_SELF, IntToString(ACR_GetCharacterID(oPC)), 1);
		return;
	}
}
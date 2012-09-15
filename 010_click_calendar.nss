#include "acr_time_i"

const string MSGBOARD_XML = "msgboard.xml";
const string SCREEN_MSGBOARD = "SCREEN_MSGBRD"; 

void main()
{
	object o = GetClickingObject();

	if (o == OBJECT_INVALID)
		o = GetLastUsedBy();

	SendChatMessage(OBJECT_SELF,o,CHAT_MODE_TALK,"Today is "+ACR_FRDateToString());

	if (FindSubString(GetTag(OBJECT_SELF), "noticeboard")) {
		DisplayGuiScreen(o,SCREEN_MSGBOARD, FALSE, MSGBOARD_XML);
							
		if (!GetIsDM(o))
			SetGUIObjectDisabled(o,SCREEN_MSGBOARD,"MSGB_DELTOPIC",TRUE);
		else
			SetGUIObjectDisabled(o,SCREEN_MSGBOARD,"MSGB_DELTOPIC",FALSE);
	}
}

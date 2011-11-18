#include "acr_time_i"

void main()
{
	object o = GetClickingObject();

	if (o == OBJECT_INVALID)
		o = GetLastUsedBy();

	SendChatMessage(OBJECT_SELF,o,CHAT_MODE_TALK,"Today is "+ACR_FRDateToString());
}

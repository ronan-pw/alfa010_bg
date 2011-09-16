void main()
{
	float fUpdateInterval = GetLocalFloat(OBJECT_SELF,"UPDATE_INTERVAL");
	int iCurrent_CR=GetLocalInt(OBJECT_SELF,"CURRENT_CR");
	int iCR_Increase=GetLocalInt(OBJECT_SELF,"CR_INCREASE");
	int newcr = (iCurrent_CR+iCR_Increase);
	string sDatabase = GetLocalString(OBJECT_SELF,"DATABASE");
	string s;
	
	NWNXSetString("TIME", "START", sDatabase+"_timer", 0, "");

	SetLocalInt(OBJECT_SELF,"CURRENT_CR",newcr);
	SetCampaignInt(sDatabase,"CURRENT_CR",newcr);
	
	s = "Updating DPSS01 to "+IntToString(newcr);
	SendMessageToAllDMs(s);
	WriteTimestampedLogEntry(s);
	
	DelayCommand(fUpdateInterval,ExecuteScript("dpss_phb",OBJECT_SELF));
}
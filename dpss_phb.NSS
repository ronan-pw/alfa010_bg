void main()
{
	float fUpdateInterval = GetLocalFloat(OBJECT_SELF,"UPDATE_INTERVAL");
	int iCurrent_CR=GetLocalInt(OBJECT_SELF,"CURRENT_CR");
	int iCR_Increase=GetLocalInt(OBJECT_SELF,"CR_INCREASE");
	string sDatabase = GetLocalString(OBJECT_SELF,"DATABASE");
	
	NWNXSetString("TIME", "START", sDatabase+"_timer", 0, "");

	SetLocalInt(OBJECT_SELF,"CURRENT_CR",(iCurrent_CR+iCR_Increase));
	SetCampaignInt(sDatabase,"CURRENT_CR",(iCurrent_CR+iCR_Increase));
	
	DelayCommand(fUpdateInterval,ExecuteScript("dpss_phb",OBJECT_SELF));
}
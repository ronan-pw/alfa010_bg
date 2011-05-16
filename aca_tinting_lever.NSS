// tinting lever - test on_used script
// adapted from lostdreams' tinting plugin script

#include "nwnx_sql"
#include "acr_db_persist_i"

void main()
{
	object oPC=GetLastUsedBy();
	string sBic = GetPCPlayerName(oPC)+"!"+GetName(oPC)+".bic";
	if (ACR_GetPersistentInt(oPC, "ACR_TINT") == 0)
	{
		ACR_SetPersistentInt(oPC, "ACR_TINT", TRUE);
		DelayCommand(2.0,SetLocalString(GetModule(),"NWNX!TINT!EXEC",sBic));
		BootPC(oPC);
	} else {
	    SendMessageToPC(oPC, "Your PC has already been tinted.");
	}
}
/*
string GetCampaignStringN(string campaign, string variable, object player=OBJECT_INVALID)
{
	object o=GetModule();
	if (player!=OBJECT_INVALID) o=player;
	return GetPersistentString(o,variable,campaign);
}
int GetCampaignIntN(string campaign, string variable, object player=OBJECT_INVALID)
{
	object o=GetModule();
	if (player!=OBJECT_INVALID) o=player;
	return GetPersistentInt(o,variable,campaign);
}
void SetCampaignStringN(string campaign, string variable, string s, object player=OBJECT_INVALID)
{
	object o=GetModule();
	if (player!=OBJECT_INVALID) o=player;
	SetPersistentString(o,variable,s,0,campaign);
}
void SetCampaignIntN(string campaign, string variable, int i, object player=OBJECT_INVALID)
{
	object o=GetModule();
	if (player!=OBJECT_INVALID) o=player;
	SetPersistentInt(o,variable,i,0,campaign);
}
void DeleteCampaignVariableN(string campaign, string variable, object player=OBJECT_INVALID)
{
	object o=GetModule();
	if (player!=OBJECT_INVALID) o=player;
	DeletePersistentVariable(o,variable,campaign);
}
float GetCampaignFloatN(string campaign, string variable, object player=OBJECT_INVALID)
{
	object o=GetModule();
	if (player!=OBJECT_INVALID) o=player;
	return GetPersistentFloat(o,variable,campaign);
}
void SetCampaignFloatN(string campaign, string variable, float i, object player=OBJECT_INVALID)
{
	object o=GetModule();
	if (player!=OBJECT_INVALID) o=player;
	SetPersistentFloat(o,variable,i,0,campaign);
}
vector GetCampaignVectorN(string campaign, string variable, object player=OBJECT_INVALID)
{
	object o=GetModule();
	if (player!=OBJECT_INVALID) o=player;
	return GetPersistentVector(o,variable,campaign);
}
void SetCampaignVectorN(string campaign, string variable, vector i, object player=OBJECT_INVALID)
{
	object o=GetModule();
	if (player!=OBJECT_INVALID) o=player;
	SetPersistentVector(o,variable,i,0,campaign);
}


*/
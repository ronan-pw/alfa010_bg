
void main(int nCommand, int nArgument)
{
	object oPC = GetPCSpeaker();

	SetLocalInt(oPC, "ACR_APP_CMD", nCommand);
	SetLocalInt(oPC, "ACR_APP_ARG", nArgument);
	ExecuteScript("010_app_cmds", oPC);
}

void main(int num)
{
    object oPC = GetPCSpeaker();
	string deity = GetLocalString(OBJECT_SELF,"Deity");
	string str = GetName(oPC) + " donated " + IntToString(num) + " to "+ deity;


	SendMessageToAllDMs(str);
	WriteTimestampedLogEntry(str);
}
int StartingConditional()
{
object oSpeaker=OBJECT_SELF;
object oPC=GetPCSpeaker();

int iCurrentCR=GetLocalInt(oSpeaker,"CURRENT_CR");
string sCurrentCR=IntToString(iCurrentCR);
SetCustomToken(3001,sCurrentCR);

return 1;
}
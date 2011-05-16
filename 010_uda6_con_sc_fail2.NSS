int StartingConditional()
{
int iRet=FALSE;
if (GetLocalInt(GetArea(OBJECT_SELF),"PUZZLE_LIVES")==2)
	{
	iRet=TRUE;
	}
return iRet;
}
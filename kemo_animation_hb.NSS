#include "kemo_includes"

void QuickNormalizeHeight(object oPC)
{
	float fPCHeight = GetScale(oPC,SCALE_Z);
	float fPCNaturalHeight = GetLocalFloat(oPC,"CharacterHeight");
	float fPCX = GetScale(oPC,SCALE_X);
	float fPCY = GetScale(oPC,SCALE_Y);

	if (fPCNaturalHeight != 1.0f && fPCHeight == 1.0f && fPCNaturalHeight > 0.0f) // if the character is currently at normalized height, return to natural
	{
		SetScale(oPC,fPCX,fPCY,fPCNaturalHeight);
	}
}

void main()
{
	object oPC = GetLocalObject(OBJECT_SELF,"StoredAnimationPC");
	{
		DestroyObject(OBJECT_SELF,1.0,FALSE);
		return;
	}
	string sAnim = GetLocalString(OBJECT_SELF,"StoredAnimationIdle");
	location lSpotPC = GetLocation(oPC);
	location lSpotPoint = GetLocation(OBJECT_SELF);
	vector vSpotPC = GetPositionFromLocation(lSpotPC);
	vector vSpotPoint = GetPositionFromLocation(lSpotPoint);
	
	if (vSpotPC != vSpotPoint)
	{
		QuickNormalizeHeight(oPC);
		SetCollision(oPC,1); //turns collision back on.
		DeleteLocalObject(oPC,"AnimationPoint");
		DestroyObject(OBJECT_SELF,1.0,FALSE);
	}
	else
	{
		PlayKemoAnimation(oPC,sAnim);
	}
}
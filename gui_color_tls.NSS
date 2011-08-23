//*/////////////////////////////////////////////////////////////////////////////
//------------------------------------------------------------------------------ 
// gui_color_tls - Elechos - Script de GUI : Calcule une couleur RGB grace 
//								aux valeurs envoyé en TLS
// Scripteur:  Tyrnis
// Dernière Modification : 08 / 12 / 2007
//------------------------------------------------------------------------------
//*/////////////////////////////////////////////////////////////////////////////


#include "nwnx_craft_system"

void main (int iTeinte, int iLuminosite, int iSaturation)
{	
	XPCraft_Debug(OBJECT_SELF,"TLS : \n T = " + IntToString(iTeinte) + "\n L = " + IntToString(iLuminosite) + "\n S = " + IntToString(iSaturation));
	object oPC = OBJECT_SELF;
	int iRed,iGreen,iBlue,iAlpha,iNewColorValue;
	float T,L,S;
	float R,G,B, q1,q2;
	
	T = IntToFloat(iTeinte);
	L = (iLuminosite*1.0) / 100.0;
	S = (iSaturation*1.0) / 100.0;
	
	XPCraft_Debug(OBJECT_SELF,"T = " + FloatToString(T) + "\n L = " + FloatToString(L) + "\n T = " + FloatToString(T));
	
	if (L <= 0.5)
		q2 = L * (1.0 + S);
	else
		q2 = L + S - (L * S);
	
	q1 = (2 * L) - q2;
	
	XPCraft_Debug(OBJECT_SELF,"q1 = " + FloatToString(q1) + "\n q2 = " + FloatToString(q2) + "\n L = " + FloatToString(L));
	
	if(S == 0.0) {
		R = L;
		G = L;
		B = L;
	}
	else {
		R = XPCraft_QqhToRgb(q1,q2,T+120.0);
		G = XPCraft_QqhToRgb(q1,q2,T);
		B = XPCraft_QqhToRgb(q1,q2,T-120.0);
	}
	
	XPCraft_Debug(OBJECT_SELF,"R = " + FloatToString(R) + "\n G = " + FloatToString(G) + "\n B = " + FloatToString(B));

	iRed = FloatToInt(R*255.0);
	iGreen = FloatToInt(G*255.0);
	iBlue = FloatToInt(B*255.0);
	iAlpha = 255;
	
	iNewColorValue = XPCraft_RGBAToInt(iRed,iGreen,iBlue,iAlpha);
	
	DisplayMessageBox(oPC, 1, "Red: "+IntToString(iRed) + "\nGreen: "+IntToString(iGreen)+"\nBlue: "+IntToString(iBlue)+"\nCol:"+IntToString(iNewColorValue));
	
	
	if (GetLocalInt(oPC, "XC_ITEM_COLOR_CRAFTED")) {
		DisplayMessageBox(oPC, 1, "Exit the dialog and select tint area to modify color again.");
		return;
	}
		
	SetLocalObject(oPC, "XC_ITEM_TO_CRAFT", XPCraft_ActionChangeColor(oPC, iNewColorValue));
	
	SetLocalInt(oPC, "XC_ITEM_COLOR_CRAFTED",1);
		
}

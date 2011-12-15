#include "acr_vanity_i"

/* commands:
 *
 * change head
 * - next
 * - prev
 * change hair
 * - next
 * - prev
 * change beard
 * - on
 * - off
 * change tint
 * - tint area
 *
 */
void main()
{
	object oPC = OBJECT_SELF;
	int n, cmd, arg;

	cmd = GetLocalInt(oPC, "ACR_APP_CMD");
	arg = GetLocalInt(oPC, "ACR_APP_ARG");

	DeleteLocalInt(oPC, "ACR_APP_CMD");
	DeleteLocalInt(oPC, "ACR_APP_ARG");

	switch (cmd) {
	case 0:
		SetNextValidHeadModel(oPC, arg);
		break;
	case 1:
		SetNextValidHairModel(oPC, arg);
		break;
	case 2:
		XPObjectAttributesSetFacialHairVariation(oPC, arg);
		break;
	case 3:
		switch (arg) {
			case 0:
				n = ACR_APP_TYPE_HAIR_HI;
				break;
			case 1:
				n = ACR_APP_TYPE_HAIR_LO;
				break;
			case 2:
				n = ACR_APP_TYPE_HAIR_ACC;
				break;
			case 3:
				n = ACR_APP_TYPE_HEAD_SKIN;
				break;
			case 4:
				n = ACR_APP_TYPE_HEAD_EYE;
				break;
			case 5:
				n = ACR_APP_TYPE_HEAD_HAIR;
				break;
			case 6:
				n = ACR_APP_TYPE_BASE_SKIN;
				break;
			case 7:
				n = ACR_APP_TYPE_BASE_HAIR;
				break;
			case 8:
				n = ACR_APP_TYPE_BASE_EYE;
				break;
		}
		SetLocalInt(oPC, "ACR_APP_TYPE", n);

		DisplayGuiScreen(oPC,"SCREEN_COLOR_TLS",TRUE,"elechos_colortls.xml");
	}
}

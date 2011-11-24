const int _WILD_MAGIC_NORMAL	= 0;
const int _WILD_MAGIC_MAX	= 1;
const int _WILD_MAGIC_NOEX	= 2;
const int _WILD_MAGIC_FAIL	= 3;
const int _WILD_MAGIC_FAIL_NOEX	= 4;
const int _WILD_MAGIC_REBOUND	= 5;
const int _WILD_MAGIC_RANDOM	= 6;
const int _WILD_MAGIC_RAIN	= 7;
const int _WILD_MAGIC_DARK	= 8;
const int _WILD_MAGIC_HEAL	= 9;
const int _WILD_MAGIC_RGRAV	= 10;
const int _WILD_MAGIC_GLITTER	= 11;
const int _WILD_MAGIC_PIT	= 12;

int ACR_DetermineWildMagic(object oCaster, object oTarget, int nSpellId, object oItem)
{
	int n = Random(100)+1;

	// rebounds
	if (n < 20) {
		return _WILD_MAGIC_REBOUND;
	}
	// fails, 7.5 radius pit, 10/cl
	else if (n < 24) {
		return _WILD_MAGIC_PIT;
	}
	// fails, target pelted with objects (blinded 1 round)
	else if (n < 28) {
		return _WILD_MAGIC_RAIN;
	}
	// random target
	else if (n < 32) {
		return _WILD_MAGIC_RANDOM;
	}
	// charge/components not used
	else if (n < 36) {
		return _WILD_MAGIC_NOEX;
	}
	// fails, 30 radius heal spell
	else if (n < 40) {
		return _WILD_MAGIC_HEAL;
	}
	// fails, 30 radius darkness spell (2d4 rounds)
	else if (n < 44) {
		return _WILD_MAGIC_DARK;
	}
	// fails, 30 radius reverse gravity (1 round)
	else if (n < 48) {
		return _WILD_MAGIC_RGRAV;
	}
	// glitterdust 1d4 rounds
	else if (n < 52) {
		return _WILD_MAGIC_GLITTER;
	}
	// fails, components used
	else if (n < 60) {
		return _WILD_MAGIC_FAIL;
	}
	// fails, components not used
	else if (n < 72) {
		return _WILD_MAGIC_FAIL_NOEX;
	}
	// normal
	else if (n < 99) {
	}
	// maximized, +2 to DC
	else {
		return _WILD_MAGIC_MAX;
	}

	return _WILD_MAGIC_NORMAL;	
}

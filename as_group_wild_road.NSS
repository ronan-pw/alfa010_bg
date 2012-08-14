#include "acr_spawn_i"

void main();

void main() {

	int nRoll = d100();
	int i;

	if (GetIsDay()) 
	{ 
		switch (Random(15)) {
			case 0:
			case 1:
			case 2:
			case 3:
			case 4:
			case 5:
				ACR_SpawnGroup("friendly_human");
				break;
			case 6:
			case 12:
				ACR_SpawnGroup("wild");
				break;
			case 7:
			case 13:
			case 14:
				ACR_SpawnGroup("wild_nonhostile");
				break;
			case 8:
				ACR_SpawnGroup("gnoll_hunters");
				break;
			case 9:
				ACR_SpawnGroup("orc_raiders");
				break;
			case 10:
				ACR_SpawnGroup("goblin_raiders");
				break;
			case 11:
				ACR_SpawnGroup("kobold_raiders");
				break;
		}
	}	
	else	// Is night
	{
		switch (Random(15)) {
			case 0:
			case 1:
			case 2:
				ACR_SpawnGroup("friendly_human");
				break;
			case 6:
			case 5:
				ACR_SpawnGroup("wild");
				break;
			case 7:
			case 14:
				ACR_SpawnGroup("wild_nonhostile");
				break;
			case 4:
			case 8:
				ACR_SpawnGroup("gnoll_hunters");
				break;
			case 13:
			case 9:
				ACR_SpawnGroup("orc_raiders");
				break;
			case 3:
			case 10:
				ACR_SpawnGroup("goblin_raiders");
				break;
			case 12:
			case 11:
				ACR_SpawnGroup("kobold_raiders");
				break;
		}
	}
}

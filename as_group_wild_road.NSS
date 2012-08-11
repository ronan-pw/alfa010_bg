#include "acr_spawn_i"

void main();

void main() {

	int nRoll = d100();
	int i;

	if (GetIsDay()) 
	{ 
		switch (Random(9)) {
			case 0:
			case 1:
			case 2:
				ACR_SpawnGroup("friendly_human");
				break;
			case 3:
				ACR_SpawnGroup("wild_nonhostile");
				break;
			case 4:
				ACR_SpawnGroup("wild");
				break;
			case 5:
				ACR_SpawnGroup("kobold_raiders");
				break;
			case 6:
				ACR_SpawnGroup("goblin_raiders");
				break;
			case 7:
				ACR_SpawnGroup("gnoll_hunters");
				break;
			case 8:
				ACR_SpawnGroup("orc_raiders");
				break;
		}
	}	
	else	// Is night
	{
		switch (Random(9)) {
			case 0:
				ACR_SpawnGroup("friendly_human");
				break;
			case 1:
				ACR_SpawnGroup("wild");
				break;
			case 2:
				ACR_SpawnGroup("kobold_raiders");
				break;
			case 3:
				ACR_SpawnGroup("goblin_raiders");
				break;
			case 4:
				ACR_SpawnGroup("gnoll_hunters");
				break;
			case 5:
				ACR_SpawnGroup("orc_raiders");
				break;
			case 6:
				ACR_SpawnGroup("wild_nonhostile");
				break;
		}

	}
}

#include "acr_spawn_i"

void main();

/* 
Day:
//10% Neutral Animals
//10% Militia
//10% Patrol
//9% Bandits
//4% Dire Rats 1d4
//4% Gargoyle 1
//5% Gnoll Hunters
//5% Kobolds 1d6+3
//10% Neutral NPCs 1d3+2
//11% Merchants
//4% Leopard 1d2
//4% Werewolf 1
//9% Wolf 1d4
//5% Boar 1d2

Night:
7% Neutral Animals
5% Militia
5% Patrol
6% Bandits
2% Baneguard 1
5% -> 4% Dire Rat 1d4
2% Dread Warrior 1
2% Gargoyle 1
4% Ghast 1
2% Ghoul 1d6
2% Gnoll Hunters
5% Goblin Raiders
2% Hell Hound 1
5% Kobold 1d6+3
8% Neutral NPCs 1d3+2
5% Ogre 1d2
9% Orc 1d3+1
4% Skeleton (Medium) 1d6
2% Leopard 1d2
2% Vampire Spawn 1d2
5% Werewolf 1
2% Wight 1d2
4% Wolf 1d4
2% Worg 1d2
4% Zombie, medium 1d4+1

Groups:
Animals:
25% Horses 1d3+1
25% Badger 1d3+2
25% Eagle 1d3
25% Rabbits 1d3+1
Argent Legion Militia: 1d4+4 1st level warriors
Argent Legion Patrol: 1d3+1 1st level fighters + 1d2 2nd level leaders (ranger, cleric, fighter, etc)
Bandits: 1d3+1 1st level warriors + 1d2 lvl 2 leaders (fighters, clerics, rangers, etc)
Gnoll Hunters: 1d4+1 gnolls, led by 3rd level gnoll ranger
Goblin Raiders: 1d3+2 goblins, 1 2nd level goblin fighter
Merchants: 2d4 1st level commoners, 2d4 1st level warriors, 1d2 2nd level leaders (ranger, cleric, fighter, etc)
*/

void main() {

	int nRoll = d100();
	int i;

	if (GetIsDay()) 
	{ 
		if (nRoll <= 10) {	//10% Animals
			int nType = d100();
			if (nType <= 25) {
				int nHorses = d3() + 1;
				for (i = 0; i < nHorses; i++) ACR_SpawnObject("abr_cr_an_dom_horse", OBJECT_TYPE_CREATURE);
			}
			else if (nType <= 50) {
				int nBadgers = d3() + 2;
				for (i = 0; i < nBadgers; i++) ACR_SpawnObject("010_cr_badger", OBJECT_TYPE_CREATURE);
			}
			else if (nType <= 75) {
				int nRabbits = d3() + 1;
				for (i = 0; i < nRabbits; i++) ACR_SpawnObject("010_cr_bunny", OBJECT_TYPE_CREATURE);
			}
			else {
				int nBirds = d3();
				for (i = 0; i < nBirds; i++) ACR_SpawnObject("c_bird", OBJECT_TYPE_CREATURE);
			}
		}
		else if (nRoll <= 20) 	//10% Travellers
		{
			ACR_SpawnGroup("friendly_human");
		}
		else if (nRoll <= 30) //10% Guards
		{
			ACR_SpawnGroup("friendly_guard");
		}
		else if (nRoll <= 34)	//4% Bandits
		{
			ACR_SpawnGroup("bandits");
		}
		else if (nRoll <= 40)	//6% Dire Rats 1d4
		{
			int nRats = d4();
			for (i = 0; i < nRats; i++) ACR_SpawnObject("010_cr_ratdire", OBJECT_TYPE_CREATURE);
		}
		else if (nRoll <= 44)	//4% Gargoyle 1
		{
			ACR_SpawnObject("010_cr_humanoid_gargoyle", OBJECT_TYPE_CREATURE);
		}
		else if (nRoll <= 52)	//8% Gnoll Hunters
		{	
			ACR_SpawnGroup("gnoll_hunters");
		}
		//	5% Kobolds 1d6+3
		else if (nRoll <= 57)
		{
			int nKobolds = d6() + 3;
			for (i=0; i < nKobolds; i++) ACR_SpawnObject("abr_cr_hu_kobold", OBJECT_TYPE_CREATURE);
		}
		//	10% Neutral NPCs 1d3+2
		else if (nRoll <= 67)
		{
			int nNPCs = d3() + 2;
			for (i = 0; i < nNPCs; i++) {
				int n = d100();
				if (n < 20) ACR_SpawnObject("abr_cr_npc_brb_3", OBJECT_TYPE_CREATURE);
				else if (n < 40) ACR_SpawnObject("abr_cr_npc_cl_3_lath", OBJECT_TYPE_CREATURE);
				else if (n < 60) ACR_SpawnObject("abr_cr_npc_ftr_3", OBJECT_TYPE_CREATURE);
				else if (n < 80) ACR_SpawnObject("abr_cr_npc_rog_3", OBJECT_TYPE_CREATURE);
				else ACR_SpawnObject("abr_cr_npc_wiz_3", OBJECT_TYPE_CREATURE);
			}
		}
		//11% Merchants
		else if (nRoll <= 78)
		{
			int nType = d100();
			if (nType <= 50) 
				ACR_SpawnGroup("010_cr_travel_merchant0");
			else
				ACR_SpawnGroup("010_cr_travel_merchant1");
		}
		//4% Goblins
		else if (nRoll <= 82)
		{
			ACR_SpawnGroup("goblin_raiders");
		}
		//4% Werewolf 1
		else if (nRoll <= 86)
		{
			ACR_SpawnObject("abr_werewolf", OBJECT_TYPE_CREATURE);
		}
		//9% Wolf 1d4
		else if (nRoll <= 95)
		{
			int nWolves = d4();
			for (i=0; i < nWolves; i++) ACR_SpawnObject("010_cr_an_wolf", OBJECT_TYPE_CREATURE);
		}
		//5% Wild animal
		else 
		{
			ACR_SpawnGroup("wild");
		}
	}	
	else	// Is night
	{
		//	7% Animals
		if (nRoll <= 7)
		{
			int nType = d100();
			if (nType <= 25) {
				int nHorses = d3() + 1;
				for (i = 0; i < nHorses; i++) ACR_SpawnObject("abr_cr_an_dom_horse", OBJECT_TYPE_CREATURE);
			}
			else if (nType <= 50) {
				int nBadgers = d3() + 2;
				for (i = 0; i < nBadgers; i++) ACR_SpawnObject("010_cr_badger", OBJECT_TYPE_CREATURE);
			}
			else if (nType <= 75) {
				int nRabbits = d3() + 1;
				for (i = 0; i < nRabbits; i++) ACR_SpawnObject("010_cr_bunny", OBJECT_TYPE_CREATURE);
			}
			else {
				int nBirds = d3();
				for (i = 0; i < nBirds; i++) ACR_SpawnObject("c_bird", OBJECT_TYPE_CREATURE);
			}
		}
		//	5% Friendly Travellers
		else if (nRoll <= 12)
		{
			ACR_SpawnGroup("friendly_human");
		}
		// 5% Friendly Guards
		else if (nRoll <= 17)
		{
			ACR_SpawnGroup("friendly_guard");
		}		
		//	7% Bandits
		else if (nRoll <= 24)
		{
			ACR_SpawnGroup("bandits");
		}
		//	1% Baneguard 1
		else if (nRoll <= 25)
		{
			ACR_SpawnObject("acr_cr_un_baneguard", OBJECT_TYPE_CREATURE);
		}
		//	4% Dire Rat 1d4
		else if (nRoll <= 29)
		{
			int nRats = d4();
			for (i = 0; i < nRats; i++) ACR_SpawnObject("010_cr_ratdire", OBJECT_TYPE_CREATURE);
		}
		//	2% Dread Warrior 1
		else if (nRoll <= 31)
		{
			ACR_SpawnObject("abr_cr_un_dreadwarrior", OBJECT_TYPE_CREATURE);
		}
		//	2% Gargoyle 1
		else if (nRoll <= 33)
		{
			ACR_SpawnObject("010_cr_humanoid_gargoyle", OBJECT_TYPE_CREATURE);
		}
		//	4% Ghast 1
		else if (nRoll <= 37)
		{
			ACR_SpawnObject("010_cr_undead_ghast", OBJECT_TYPE_CREATURE);
		}
		//	2% Ghoul 1d6
		else if (nRoll <= 39)
		{
			int nGhouls = d6();
			for (i=0; i < nGhouls; i++) ACR_SpawnObject("010_cr_undead_ghoul", OBJECT_TYPE_CREATURE);
		}
		//	2% Gnoll Hunters
		else if (nRoll <= 41)
		{
			ACR_SpawnGroup("gnoll_hunters");
		}
		//	5% Goblin Raiders
		else if (nRoll <= 46)
		{
			ACR_SpawnGroup("goblin_raiders");
		}
		//	2% Dire badger
		else if (nRoll <= 48)
		{
			ACR_SpawnObject("010_cr_badgerdire", OBJECT_TYPE_CREATURE);
		}
		//	5% Kobold 1d6+3
		else if (nRoll <= 53)
		{
			int nKobolds = d6() + 3;
			for (i=0; i < nKobolds; i++) ACR_SpawnObject("abr_cr_hu_kobold", OBJECT_TYPE_CREATURE);
		}
		//	8% Neutral NPCs 1d3+2
		else if (nRoll <= 61)
		{
			int nNPCs = d3() + 2;
			for (i = 0; i < nNPCs; i++) {
				int n = d100();
				if (n < 20) ACR_SpawnObject("abr_cr_npc_brb_3", OBJECT_TYPE_CREATURE);
				else if (n < 40) ACR_SpawnObject("abr_cr_npc_cl_3_lath", OBJECT_TYPE_CREATURE);
				else if (n < 60) ACR_SpawnObject("abr_cr_npc_ftr_3", OBJECT_TYPE_CREATURE);
				else if (n < 80) ACR_SpawnObject("abr_cr_npc_rog_3", OBJECT_TYPE_CREATURE);
				else ACR_SpawnObject("abr_cr_npc_wiz_3", OBJECT_TYPE_CREATURE);
			}
		}
		//	5% Ogre 1d2
		else if (nRoll <= 66)
		{
			int nOgres = d3();
			for (i = 0; i < nOgres; i++) ACR_SpawnObject("abr_cr_gt_ogre", OBJECT_TYPE_CREATURE);
		}
		//	9% Orc 1d3+1
		else if (nRoll <= 75)
		{
			int nOrcs = d3() + 1;
			for (i = 0; i < nOrcs; i++) ACR_SpawnObject("010_sand_orc1", OBJECT_TYPE_CREATURE);
		}
		//	4% Skeleton (Medium) 1d6
		else if (nRoll <= 79)
		{
			int nSkeletons = d6();
			for (i = 0; i < nSkeletons; i++) ACR_SpawnObject("abr_cr_un_skeleton", OBJECT_TYPE_CREATURE);
		}
		//	2% Wild animals
		else if (nRoll <= 81)
		{
			ACR_SpawnGroup("wild");
		}
		//	2% Allips
		else if (nRoll <= 83)
		{
			int nSpawns = d2();
			for (i = 0; i < nSpawns; i++) ACR_SpawnObject("010_cr_undead_allip", OBJECT_TYPE_CREATURE);
		}
		//	5% Werewolf 1
		else if (nRoll <= 88)
		{
			ACR_SpawnObject("abr_werewolf", OBJECT_TYPE_CREATURE);
		}
		//	2% Wight 1d2
		else if (nRoll <= 90)
		{
			int nWights = d2();
			for (i = 0; i < nWights; i++) ACR_SpawnObject("010_cr_undead_wight", OBJECT_TYPE_CREATURE);
		}
		//	4% Wolf 1d4
		else if (nRoll <= 94)
		{
			int nWolves = d4();
			for (i=0; i < nWolves; i++) ACR_SpawnObject("010_cr_an_wolf", OBJECT_TYPE_CREATURE);
		}
		//	2% Worg 1d2
		else if (nRoll <= 96)
		{
			int nWorgs = d2();
			for (i = 0; i < nWorgs; i++) ACR_SpawnObject("abr_cr_mb_worg", OBJECT_TYPE_CREATURE);
		}
		//	4% Zombie, medium 1d4+1
		else
		{
			int nZombies = d4() + 1;
			for (i = 0; i < nZombies; i++) ACR_SpawnObject("abr_cr_un_zombie", OBJECT_TYPE_CREATURE);
		}
	}
}

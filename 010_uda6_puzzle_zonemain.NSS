#include "010_uda6_puzzle_inc"

/*
Puzzle states:
0=Inactive
1=Run first room (rules)
2=Run Second Room (scholar)
3=Run third room (warrior)
4=run fourth room (scribe)
5=run fifth room (priest)
6=run 6th room (seneschal)
7=run throneroom (lord + fight)
*/



void main()
{
object UDA6=GetArea(OBJECT_SELF);
object oPC=GetEnteringObject();
int PUZZLE_STATE=GetLocalInt(UDA6,"PUZZLE_STATE");

int PCS_IN_MAIN=GetLocalInt(UDA6,"PCS_IN_MAIN");
int PARTY_MEMBERS=GetLocalInt(UDA6,"PARTY_MEMBERS");

PCS_IN_MAIN=PCS_IN_MAIN+1;
SetLocalInt(UDA6,"PCS_IN_MAIN",(PCS_IN_MAIN));
if (DEBUG==1){SendMessageToPC(oPC,"PCs in Main Area="+IntToString(GetLocalInt(UDA6,"PCS_IN_MAIN")));}
if (DEBUG==1){SendMessageToPC(oPC,"PCs in Party="+IntToString(GetLocalInt(UDA6,"PARTY_MEMBERS")));}
if (DEBUG==1){SendMessageToPC(oPC,"Puzzle State="+IntToString(GetLocalInt(UDA6,"PUZZLE_STATE")));}


if (PCS_IN_MAIN==PARTY_MEMBERS)
	{
	if (PUZZLE_STATE==0)
		{
		object oDoor=GetObjectByTag("UDA6_E_DOOR_ZONE1");
		SetLocked(oDoor,FALSE);
		DelayCommand(6.0,AssignCommand(oDoor,ActionOpenDoor(oDoor)));
		SetLocalInt(UDA6,"PUZZLE_STATE",1);
		}
	if ((PUZZLE_STATE==1)&&(GetLocalInt(UDA6,"PUZZLE_ZONE1_SUCCESS")==1))
		{
		object oDoor=GetObjectByTag("UDA6_E_DOOR_ZONE1");
		AssignCommand(oDoor,ActionCloseDoor(oDoor));
		SetLocked(oDoor,TRUE);
		oDoor=GetObjectByTag("UDA6_E_DOOR_ZONE2");
		DelayCommand(11.5,SetLocked(oDoor,FALSE));
		DelayCommand(12.0,AssignCommand(oDoor,ActionOpenDoor(oDoor)));
		SetLocalInt(UDA6,"PUZZLE_STATE",2);
		}		
	if ((PUZZLE_STATE==2)&&(GetLocalInt(UDA6,"PUZZLE_ZONE2_SUCCESS")==1))
		{
		object oDoor=GetObjectByTag("UDA6_E_DOOR_ZONE2");
		AssignCommand(oDoor,ActionCloseDoor(oDoor));
		SetLocked(oDoor,TRUE);
		oDoor=GetObjectByTag("UDA6_E_DOOR_ZONE3");
		DelayCommand(11.5,SetLocked(oDoor,FALSE));
		DelayCommand(12.0,AssignCommand(oDoor,ActionOpenDoor(oDoor)));
		SetLocalInt(UDA6,"PUZZLE_STATE",3);
		}	
	if ((PUZZLE_STATE==3)&&(GetLocalInt(UDA6,"PUZZLE_ZONE3_SUCCESS")==1))
		{
		object oDoor=GetObjectByTag("UDA6_E_DOOR_ZONE3");
		AssignCommand(oDoor,ActionCloseDoor(oDoor));
		SetLocked(oDoor,TRUE);
		oDoor=GetObjectByTag("UDA6_E_DOOR_ZONE4");
		DelayCommand(11.5,SetLocked(oDoor,FALSE));
		DelayCommand(12.0,AssignCommand(oDoor,ActionOpenDoor(oDoor)));
		SetLocalInt(UDA6,"PUZZLE_STATE",4);
		}	
	if ((PUZZLE_STATE==4)&&(GetLocalInt(UDA6,"PUZZLE_ZONE4_SUCCESS")==1))
		{
		object oDoor=GetObjectByTag("UDA6_E_DOOR_ZONE4");
		AssignCommand(oDoor,ActionCloseDoor(oDoor));
		SetLocked(oDoor,TRUE);
		oDoor=GetObjectByTag("UDA6_E_DOOR_ZONE5");
		DelayCommand(11.5,SetLocked(oDoor,FALSE));
		DelayCommand(12.0,AssignCommand(oDoor,ActionOpenDoor(oDoor)));
		SetLocalInt(UDA6,"PUZZLE_STATE",5);
		}
	if ((PUZZLE_STATE==5)&&(GetLocalInt(UDA6,"PUZZLE_ZONE5_SUCCESS")==1))
		{
		object oDoor=GetObjectByTag("UDA6_E_DOOR_ZONE5");
		AssignCommand(oDoor,ActionCloseDoor(oDoor));
		SetLocked(oDoor,TRUE);
		oDoor=GetObjectByTag("UDA6_E_DOOR_ZONE6");
		DelayCommand(11.5,SetLocked(oDoor,FALSE));
		DelayCommand(12.0,AssignCommand(oDoor,ActionOpenDoor(oDoor)));
		SetLocalInt(UDA6,"PUZZLE_STATE",6);
		}		
	if ((PUZZLE_STATE==6)&&(GetLocalInt(UDA6,"PUZZLE_ZONE6_SUCCESS")==1))
		{
		object oDoor=GetObjectByTag("UDA6_E_DOOR_ZONE6");
		AssignCommand(oDoor,ActionCloseDoor(oDoor));
		SetLocked(oDoor,TRUE);
		oDoor=GetObjectByTag("UDA6_E_DOOR_ZONE7");
		DelayCommand(11.5,SetLocked(oDoor,FALSE));
		DelayCommand(12.0,AssignCommand(oDoor,ActionOpenDoor(oDoor)));
		SetLocalInt(UDA6,"PUZZLE_STATE",7);
		}
	}
}
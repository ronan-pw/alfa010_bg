void main()
{
int iD20=d20(1);
string sResRef;
switch (iD20)
	{
	case 1:sResRef="010_cr_comm_human";break;
	case 2:sResRef="010_cr_comm_human0";break;
	case 3:sResRef="010_cr_comm_human1";break;
	case 4:sResRef="010_cr_comm_human2";break;
	case 5:sResRef="010_cr_comm_human3";break;
	case 6:sResRef="010_cr_comm_human4";break;
	case 7:sResRef="010_cr_comm_human5";break;
	case 8:sResRef="010_cr_comm_human6";break;
	case 9:sResRef="010_cr_comm_human7";break;
	case 10:sResRef="010_cr_comm_human8";break;
	case 11:sResRef="010_cr_comm_human00";break;
	case 12:sResRef="010_cr_comm_human10";break;
	case 13:sResRef="010_cr_comm_human20";break;
	case 14:sResRef="010_cr_comm_human30";break;
	case 15:sResRef="010_cr_comm_human40";break;
	case 16:sResRef="010_cr_comm_human50";break;
	case 17:sResRef="010_cr_comm_human60";break;
	case 18:sResRef="010_cr_comm_human70";break;
	case 19:sResRef="010_cr_comm_human80";break;
	case 20:sResRef="010_cr_comm_human11";break;
	}

object oSpawned=CreateObject(OBJECT_TYPE_CREATURE,sResRef,GetLocation(OBJECT_SELF),FALSE,GetTag(OBJECT_SELF));	
DelayCommand(0.1,DestroyObject(OBJECT_SELF));


}
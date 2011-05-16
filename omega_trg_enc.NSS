////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_trg_onenter.nss
//    $Revision:: 236        $ current version of the file
//        $Date:: 2007-01-21#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnEnter code for triggers, and any
//  custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
//  2009/08/6  Wynna  
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_trigger_i"
#include "acr_quest_i"
#include "acr_spawn_i"
#include "acr_language_i"

void TSM_SendText(object oPC, string sText, int bFloat=FALSE, int nColor=COLOR_CYAN, int bFaction=FALSE);

void TSM_SendText(object oPC, string sText, int bFloat=FALSE, int nColor=-1, int bFaction=FALSE)
{   //Purpose: Send text to a pc or faction in color quickly
    //Original Scripter: Demetrious
    //Last Modified By: Demetrious 10/12/6
    object oFaction;
	
	if (bFloat)
		FloatingTextStringOnCreature(sText, oPC, bFaction, 3.0);
	else
	{
		if (bFaction)
        {
            oFaction = GetFirstFactionMember(oPC, TRUE);
            while (GetIsObjectValid(oFaction))
            {
                if ((GetDistanceBetween(oFaction, oPC)<30.0) && (GetArea(oFaction)==GetArea(oPC)))
                    SendMessageToPC(oPC, sText);
                oFaction = GetNextFactionMember(oPC, TRUE);
            }
        }
        else SendMessageToPC(oPC, sText);
	}	
}

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Variables ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////



void main()
{


// Custom code goes here.
object oPC = GetLocalObject(OBJECT_SELF, "Object_Target");
object oPartyLeader = GetFactionLeader(oPC);
object oPartyMember = GetFirstFactionMember(oPartyLeader, TRUE);
object oTrigger = GetNearestObject(OBJECT_TYPE_TRIGGER, oPC, 1);
int iAreaNumber = GetLocalInt(oTrigger, "AreaNumber");
SendMessageToAllDMs(GetName(oTrigger) + " triggering an encounter on " + GetName(oPC));

//Define permanent trigger specific variables, if hasn't been done yet, including SendText strings, DC ints, Destination objects.
//If sArea is already defined, the rest are assumed to be and the script skips to functions only relevant to an entering PartyLeader at line 320
	string sArea = GetLocalString(oTrigger, "sArea");
	string sSpotPC;
	string sListenPC;
	string sSpotListenPC;
	string sDest1;
	string sDest3;
	string sPCCombat;
	string sDragonDirection;
	int DCSpot;
	int DCSpotNight;
	int DCListen;

	object oDestinationGeneric1 = GetLocalObject(oTrigger, "oDestinationGeneric1");
	object oDestinationGeneric2;
	object oDestinationGeneric3;
	object oDestinationGenericDragon;
	object oMeet1Generic;
	object oMeet2Generic;
				
	object oDestination1 = GetLocalObject(oTrigger, "oDestination1");
	object oDestination2;
	object oDestination3;
	object oDestinationDragon;
	object oMeet1;
	object oMeet2;
			
	if(sArea == "")
		{if(iAreaNumber == 1)
			  {DCSpot = 12;
			   sArea = "Orphanage";
			   DCListen = 12;
			   sSpotPC = "At least one distant figure strolls the grounds of the Orphanage to the north.";
			   sListenPC = "Relaxed voices and the distant sound of inhabitants going about day to day life drift down to the road from the Orphanage." ;
			   sSpotListenPC = "You can both hear and see those going about their day to day workings at the Orphanage to the north.";
			   sPCCombat = "You see people in combat near the Orphanage!";
			   sDest1 = "west";
   			   sDest3 = "east";
			   sDragonDirection = "a hill overlooking the road to the east";
			  }
			else if((iAreaNumber == 2) || (iAreaNumber == 4))
			   {sArea = "Western_Highway";
				DCSpot = 10;
				DCListen = 10;
				sDest1 = "west";
				sDest3 = "east";
				}
			else if(iAreaNumber == 3)
				{DCSpot = 20;
				 sArea = "Great_Oak";
				 DCListen = 20;
				 sSpotPC = "You spot a glimpse of movement through the trees to the north.";
				 sListenPC = "You hear a rustling of leaves slightly too loud to be the wind.";
				 sSpotListenPC = "For a moment, you hear a bit of a calm, low conversation blown to you by the breeze, too distant to make out individual words, but your eye is drawn to a momentary movement on a high hill that thrusts its one lone oak above the tops of the surrounding trees. You saw a willowy female figure, briefly.";
				 sPCCombat = "People are fighting something amongst the trees to the north!";
				 sDest1 = "west";
				 sDest3 = "east";
				 sDragonDirection = "a hill north of the road to the east";
				}
			else if(iAreaNumber == 5)
				{DCSpot = 12;
				 sArea = "Blasted_Tower";
				 DCListen = 12;
				 sSpotPC = "Against the backdrop of what looks to have been a rain of granite projectiles long ago, you spot humanoid movement.";
				 sListenPC = "The crunch of footsteps sounds on granite flakes that have peeled off pillars of rock to the north, over decades or centuries.";
				 sSpotListenPC = "Whatever he, she or they are doing in there, you both spot and overhear at least one non-monstrous creature to the north, amid the pillars of rock jutting from the earth at all angles.";
				 sPCCombat = "The cries of adventurers and combat drift to you from the direction of a tower amid pillars of natural granite!";
				 sDest1 = "west";
				 sDest3 = "east";
				 sDragonDirection = "a tall pillar of rock east of the Blasted Tower";
				}
			else if(iAreaNumber == 6)
				{sArea = "North_Road";
				 DCSpot = 10;
				 DCListen = 10;
				 sDest1 = "south";
				 sDest3 = "north";
				}
			else if(iAreaNumber == 7)
				{DCSpot = 12;
				 sArea = "NR2";
				 DCListen = 12;
				 sSpotPC = "A figure -- or the shadow of one -- passes across the rutted entrance to an island tower tower and its causeway." ;
				 sListenPC = "A flock of crows burst up from the ground, screeching their disapproval of someone moving through the crackling brush.";
				 sSpotListenPC = "Sound and movement signal that the signposted tower of Wima Duvabiddle has visitors.";
				 sPCCombat = "Your journey is interrupted by the clash and screams of unknown people's battle echoing amid the high cliffs!";
				 sDest1 = "south";
				 sDest3 = "north";
				 sDragonDirection = "a plateau north of the sign pointing to the tower";
				}
			else if((iAreaNumber == 8)|| (iAreaNumber == 9))
				{sArea = "Silverymoon_Highway";
				DCSpot = 10;
				DCListen = 10;
				sDest1 = "west";
				sDest3 = "east";
				}
		else if(iAreaNumber == 10)
				{DCSpot = 10;
				 sArea = "Meteor";
				 DCListen = 10;
				 sSpotPC = "At least one figure moves around the edge of the lake, on the red-stained earth of the shore.";
				 sListenPC = "The sound of water lapping can't disguise the sound of visitors to the lake. A shower of gravel plops into the water and wet earth sucks at boots with somebody's footsteps." ;
				 sSpotListenPC = "At least one figure dallies at the lake shore. You can hear footsteps in the wet mud and see movement through the trees.";
				 sPCCombat = "Steel flashes and war cries sound from the shores of the lake! People have joined battle there.";
				 sDest1 = "west";
				 sDest3 = "east";
				 sDragonDirection = "the island of rock in the center of the lake";
				}
			else if(iAreaNumber == 11)
				{DCSpot = 10;
				 sArea = "Khelb";
				 DCListen = 10;
				 sSpotPC = "At least one figure that does not appear to be the usual rustic farmer moves near the settlement of Khelb.";
				 sListenPC = "The voices of locals drift down from Khelb's ridgeline, speaking of current visitors to the village.";
				 sSpotListenPC = "You spot a figure whose garb and bearing sets him or her apart from the locals and overhear villagers speaking of visitors.";
				 sPCCombat = "Somewhere nearby, Khelb's pastoral quiet is shattered by the sounds of combat and the cries of adventurers!";
				 sDest1 = "south";
				 sDest3 = "north";
				 sDragonDirection = "top of a cliff overlooking the waterfall to the south";
				}
			else if((iAreaNumber == 12) || (iAreaNumber == 14)|| (iAreaNumber == 15)|| (iAreaNumber == 16))
				{sArea = "Silvy_Pass";
				 DCSpot = 12;
				 DCListen = 12;
				 sDest1 = "west";
				 sDest3 = "east";
				}
			else if(iAreaNumber == 13)
				{DCSpot = 12;
				 sArea = "Hawk_Nest";
				 DCListen = 12;
				 sSpotPC = "Seen above the tree line, travellers seem to have broken their journey at the Hawk's Nest.";
				 sListenPC = "Carried on the clear mountain air, the voices of the knights who man the Hawk's Nest reach you, apparently in conversation with a visitor or visitors.";
				 sSpotListenPC = "The crunching of snow on the path above, the jingle of steel and movement against the stone walls of the Hawk Nest signal travellers coming or going from the fortress.";
				 sPCCombat = "Your travels have brought you into sight of people in combat with something on the slopes near the Hawk's Nest!";
				 sDest1 = "west";
				 sDest3 = "east";
				 sDragonDirection = "a plateau above the fort";
				}
			else if(iAreaNumber == 17)
				{DCSpot = 12;
				 sArea = "Auvandell";
				 DCListen = 12;
				 sSpotPC = "You catch brief sight of a traveller or travellers on the road beneath the village of Auvandell.";
				 sListenPC = "Voices drift down the hill from Auvandell, speaking of passers by on the road.";
				 sSpotListenPC = "The squeak of leather and the soft sounds of sheathed steel draw your eyes to movement of an indeterminate amount of travellers on the road below Auvandell.";
				 sPCCombat = "You see people in combat on the road beneath Auvandell!";
				 sDest1 = "west";
				 sDest3 = "east";
				 sDragonDirection = "a tall pillar of rock southwest of Auvandell";
				}
						
			DCSpotNight = DCSpot + 5;
			SetLocalString(oTrigger, "sArea", sArea);
			SetLocalString(oTrigger, "sPCCombat", sPCCombat);
			SetLocalString(oTrigger, "sSpotPC", sSpotPC);
			SetLocalString(oTrigger, "sListenPC", sListenPC);
			SetLocalString(oTrigger, "sSpotListenPC", sSpotListenPC);
			SetLocalString(oTrigger, "sDest1", sDest1);
			SetLocalString(oTrigger, "sDest3", sDest3);
			SetLocalString(oTrigger, "sDragonDirection", sDragonDirection);
			SetLocalInt(oTrigger, "DCSpot", DCSpot);
			SetLocalInt(oTrigger, "DCSpotNight", DCSpotNight);
			SetLocalInt(oTrigger, "DCListen", DCListen);
			 
		    		
			//Using sArea perma-local variables defined above, define the Generic and Specific Encounter Waypoints 
			//for this trigger if hasn't been done yet        
				
			string sRegion = "Western_Highway";
				if((iAreaNumber > 5) && (iAreaNumber < 8))
					{sRegion = "North_Road";
					 }
				if((iAreaNumber > 7) && (iAreaNumber < 11))
					{sRegion = "Silverymoon_Highway";
					}
				if(iAreaNumber >10)
					{sRegion = "Silvy_Pass";
					}
				
			if(oDestinationGeneric1 == OBJECT_INVALID)
				{object oGeneric = GetFirstObjectInArea(GetArea(GetWaypointByTag("TM_" + sRegion + "_WP")));
				 while(oGeneric != OBJECT_INVALID)
						{if(GetName(oGeneric) == sRegion + "_TM_Encounter_1")
								{SetLocalObject(oTrigger, "oDestinationGeneric1", oGeneric);
								 }
						 if(GetName(oGeneric) == sRegion + "_TM_Encounter_2")
								{SetLocalObject(oTrigger, "oDestinationGeneric2", oGeneric);
								 }
						 if(GetName(oGeneric) == sRegion + "_TM_Encounter_3")
								{SetLocalObject(oTrigger, "oDestinationGeneric3", oGeneric);
								 }
						 if(GetName(oGeneric) == sRegion + "_TM_Encounter_Sky")
								{SetLocalObject(oTrigger, "oDestinationGenericDragon", oGeneric);
								 }
						 if(GetName(oGeneric) == "TM_" + sRegion + "_Meet_1_WP")
								{SetLocalObject(oTrigger, "oMeet1Generic", oGeneric);
								}
						 if(GetName(oGeneric) == "TM_" + sRegion + "_Meet_2_WP")
								{SetLocalObject(oTrigger, "oMeet2Generic", oGeneric);
								}
						 oGeneric = GetNextObjectInArea(GetArea(GetWaypointByTag("TM_" + sRegion + "_WP")));
						 }
				}
					
			if((oDestination1 == OBJECT_INVALID) && ((iAreaNumber == 1) || (iAreaNumber == 3) || (iAreaNumber == 5) || (iAreaNumber == 7) || (iAreaNumber == 10) || (iAreaNumber == 11) || (iAreaNumber == 13) || (iAreaNumber == 17)))
				{object oSpecific = GetFirstObjectInArea(GetArea(GetWaypointByTag("TM_" + sArea + "_WP")));
				 while(oSpecific != OBJECT_INVALID)
						{if(GetName(oSpecific) == sArea + "_TM_Encounter_1")
								{SetLocalObject(oTrigger, "oDestination1", oSpecific);
								 }
						  if(GetName(oSpecific) == sArea + "_TM_Encounter_2")
								{SetLocalObject(oTrigger, "oDestination2", oSpecific);
								}
						  if(GetName(oSpecific) == sArea + "_TM_Encounter_3")
								{SetLocalObject(oTrigger, "oDestination3", oSpecific);
								}
						  if(GetName(oSpecific) == sArea + "_TM_Encounter_Sky")
								{SetLocalObject(oTrigger, "oDestinationDragon", oSpecific);
								}
						  if(GetName(oSpecific) == "TM_" + sArea + "_Meet_1_WP")
								{SetLocalObject(oTrigger, "oMeet1", oSpecific);
								}
						  if(GetName(oSpecific) == "TM_" + sArea + "_Meet_2_WP")
								{SetLocalObject(oTrigger, "oMeet2", oSpecific);
								}
						  oSpecific = GetNextObjectInArea(GetArea(GetWaypointByTag("TM_" + sArea + "_WP")));
						}
					}
		}
			
//Begin actual encounter definitions, both for other PCs and mobs
if(oPC == oPartyLeader) 
	{//Which trigger was the entering party in previously, to determine the direction the party is coming from?
	 int iAreaNumberPrevious = GetLocalInt(oPartyLeader, "AreaNumber");
	
	//Use the direction of travel to determine which of the three possible Generic and which of the three possible 
	//Specific Destinations is the most appropriate for Party and mob/OtherParty
	object oDestinationGeneric1 = GetLocalObject(oTrigger, "oDestinationGeneric1");
	object oDestinationGeneric2 = GetLocalObject(oTrigger, "oDestinationGeneric2");
	object oDestinationGeneric3 = GetLocalObject(oTrigger, "oDestinationGeneric3");
	object oDestinationGenericDragon = GetLocalObject(oTrigger, "oDestinationGenericDragon");
	object oDestination1 = GetLocalObject(oTrigger, "oDestination1");
	object oDestination2 = GetLocalObject(oTrigger, "oDestination2");
	object oDestination3 = GetLocalObject(oTrigger, "oDestination3");
	object oDestinationDragon = GetLocalObject(oTrigger, "oDestinationDragon");
	object oPartyDestination;
	object oMobDestination;
	object oPartyMeet;
	object oOtherMeet;
	object oMeet1 = GetLocalObject(oTrigger, "oMeet1");
	object oMeet2 = GetLocalObject(oTrigger, "oMeet2");
	object oMeet1Generic = GetLocalObject(oTrigger, "oMeet1Generic");
	object oMeet2Generic = GetLocalObject(oTrigger, "oMeet2Generic");
	string sMobDirection;
	object oPartyDestinationSpecific;
	object oMobDestinationSpecific;
	object oPartyDestinationGeneric;	 
	object oMobDestinationGeneric;	 
	object oPartyMeetSpecific;
	object oPartyMeetGeneric;
	object oOtherMeetSpecific;
	object oOtherMeetGeneric;
	
	
	//Roll iGroup. The monster group is needed now to assign some specialized destinations at the end of the next set of brackets.  
	int iGroup = Random(100);
	if(iAreaNumber - iAreaNumberPrevious != 0)
	 	{if(iAreaNumber - iAreaNumberPrevious == 1)
				{sMobDirection = sDest3;
				 oPartyDestinationSpecific = oDestination1;
				 oPartyDestinationGeneric = oDestinationGeneric1;
				 oPartyMeetSpecific = oMeet1;
				 oPartyMeetGeneric = oMeet1Generic;
				 oOtherMeetSpecific = oMeet2;
				 oOtherMeetGeneric = oMeet2Generic;
									 
				if(Random(2) == 1)
						{oMobDestinationSpecific = oDestination2;
						 oMobDestinationGeneric = oDestinationGeneric2;
						 }
				 else{oMobDestinationSpecific = oDestination3;
						 oMobDestinationGeneric = oDestinationGeneric3;
					     }
				}
							 
		else if(iAreaNumberPrevious - iAreaNumber == 1)
				{sMobDirection = sDest1;
				 oPartyDestinationSpecific = oDestination3;
				 oPartyDestinationGeneric = oDestinationGeneric3;
				 oPartyMeetSpecific = oMeet2;
				 oPartyMeetGeneric = oMeet2Generic;
				 oOtherMeetSpecific = oMeet1;
				 oOtherMeetGeneric = oMeet1Generic;
				 if(Random(2) == 1)
						{oMobDestinationSpecific = oDestination1;
						oMobDestinationGeneric = oDestinationGeneric1;
					    }
				 else
					 	{oMobDestinationSpecific = oDestination2;
		 			     oMobDestinationGeneric = oDestinationGeneric2;
						 }
				}
			
		else if((iAreaNumber - iAreaNumberPrevious != 1) && (iAreaNumberPrevious - iAreaNumber != 1))
				{oPartyDestinationSpecific = oDestination2;
				 oPartyDestinationGeneric = oDestinationGeneric2;
				 if(Random(2) == 1)
						{oMobDestinationSpecific = oDestination1;
						 oMobDestinationGeneric = oDestinationGeneric1;
					     sMobDirection = sDest1;
				       	 oPartyMeetSpecific = oMeet1;
						 oPartyMeetGeneric = oMeet1Generic;
						 oOtherMeetSpecific = oMeet2;
						 oOtherMeetGeneric = oMeet2Generic;
						}
						
					
			else 	{oMobDestinationSpecific = oDestination3;
					 oMobDestinationGeneric = oDestinationGeneric3;
					 sMobDirection = sDest3;
					 oPartyMeetSpecific = oMeet2;
					 oPartyMeetGeneric = oMeet2Generic;
					 oOtherMeetSpecific = oMeet1;
					 oOtherMeetGeneric = oMeet1Generic;
					}
				}
		
		
	//Choose the Specific Destination, unless the Specific is invalid or the encounter is not appropriate to the Specific Destination	 	
	oPartyDestination = oPartyDestinationSpecific;
	oMobDestination = oMobDestinationSpecific;
	oPartyMeet = oPartyMeetSpecific;
	oOtherMeet = oOtherMeetSpecific;
	
	
	if((iGroup > 9) && (iGroup < 11))
		 	{oMobDestination = oDestinationDragon;
			 }
				
	if((GetLocalString(oPC, sArea) == sArea) || (oPartyDestination == OBJECT_INVALID) || ((sArea == "Orphanage") && (iGroup > 21))) 
			{oPartyDestination = oPartyDestinationGeneric;
			 oMobDestination = oMobDestinationGeneric;
			 oPartyMeet = oPartyMeetGeneric;
			 oOtherMeet = oOtherMeetGeneric;
			 if((iGroup > 9) && (iGroup < 11))
			 	{oMobDestination = oDestinationGenericDragon;
				}
			}
			
		SetLocalObject(oTrigger, "oPartyDestinationGeneric", oPartyDestinationGeneric);
		SetLocalObject(oTrigger, "oPartyDestination", oPartyDestination);
		SetLocalObject(oTrigger, "oMobDestination", oMobDestination);
		SetLocalObject(oTrigger, "oPartyMeet", oPartyMeet);
		SetLocalObject(oTrigger, "oOtherMeet", oOtherMeet);

	SendMessageToAllDMs("PartyDestination = " + GetName(oPartyDestination));
			
	}
	
	oPartyDestinationGeneric = GetLocalObject(oTrigger, "oPartyDestinationGeneric");
	oPartyDestination = GetLocalObject(oTrigger, "oPartyDestination");
	oMobDestination = GetLocalObject(oTrigger, "oMobDestination");
	oPartyMeet = GetLocalObject(oTrigger, "oPartyMeet");
	oOtherMeet = GetLocalObject(oTrigger, "oOtherMeet");
	
	//Now that our destinations are set for PCParty and mob/OtherParty, begin checking for a PCxPC encounter on the highway
	//Clear previous highway meeting, party-relevant, non-permanent trigger settings
	SetLocalInt(oTrigger, "PCxPC", 0);
	SetLocalInt(oTrigger, "iPC", 0);
	SetLocalObject(oTrigger, "oOtherPartyLeader", OBJECT_INVALID);
	SetLocalInt(oTrigger, "iOtherPartyStealthHide", 0);
	SetLocalInt(oTrigger, "iOtherPartyStealthMS", 0);
	SetLocalInt(oTrigger, "iPartyStealthHide", 0);
	SetLocalInt(oTrigger, "iPartyStealthMS", 0);

	//Set party meeting relevant variables on OBJECT_SELF (trigger), PC Party and any Other Party within 5.0
	//Increment the AreaNumber int on the PartyMember, to be drawn as PreviousAreaNumber next time this fires
	//Refresh auto-follow on Party Members now, since this is the first PartyMember loop in the script
	//Set oPCDestination on Party Members now, since this is the first PartyMember loop in the script
	//Set Party Member name strings on each other for 30 minutes so that PCxPC meetings aren't forced after departy
	object oOtherPC = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(oPartyLeader), FALSE, OBJECT_TYPE_CREATURE);
	while(oOtherPC != OBJECT_INVALID)
		{SetLocalInt(oOtherPC, "FavoredEnemyBonus", 0);
		 if((!GetIsDM(oOtherPC)) && (GetFactionLeader(oOtherPC) == oPartyLeader)  && (GetIsPC(oOtherPC)))
			   {SetLocalLocation(oOtherPC, "lStartFrom", GetLocation(oPartyLeader));
			    SetLocalObject(oOtherPC, "oPCDestination", oPartyDestination);
			    if(iAreaNumber != GetLocalInt(oOtherPC, "AreaNumber")) 
			   		{SetLocalInt(oOtherPC, "AreaNumber", iAreaNumber);
			   		}
			    if(oOtherPC != oPartyLeader)
			   		{
				    AssignCommand(oOtherPC, ActionForceFollowObject(oPartyLeader, 0.5, 0));
					SetLocalString(oPartyLeader, GetName(oOtherPC), GetName(oOtherPC));
					SetLocalString(oOtherPC, GetName(oPartyLeader), GetName(oPartyLeader));
					DelayCommand(1800.0, SetLocalString(oOtherPC, GetName(oPartyLeader), GetName(oPartyLeader)));
					DelayCommand(1800.0, SetLocalString(oPartyLeader, GetName(oOtherPC), GetName(oOtherPC)));
					}
					
				//Set variables: Party Hide and Move Silently for PartyLeader Party
				if(GetStealthMode(oPartyLeader) == (STEALTH_MODE_ACTIVATED))
					{while(oPartyMember != OBJECT_INVALID)
					 	{int iPartyStealthHide = GetSkillRank(SKILL_HIDE, oPartyMember, FALSE);
						 if(iPartyStealthHide < GetLocalInt(oTrigger, "iPartyStealthHide"))
						 	{SetLocalInt(oTrigger, "iPartyStealthHide", iPartyStealthHide);
						 	}
						 int iPartyStealthMS = GetSkillRank(SKILL_MOVE_SILENTLY, oPartyMember, FALSE);
						 if(iPartyStealthMS < GetLocalInt(oTrigger, "iPartyStealthMS"))
						 	{SetLocalInt(oTrigger, "iPartyStealthMS", iPartyStealthMS);
						 	}
					 				
						oPartyMember = GetNextFactionMember(oPartyLeader);
						}
					}
				}
				
		
		//Toggle PCxPC to indicate another party on the road and set Other Party variables
		//Set Other Party Member name strings on each other for 30 minutes so that PCxPC meetings aren't forced after departy
		if((!GetIsDM(oOtherPC)) && (GetFactionLeader(oOtherPC) != oPartyLeader))
				{SetLocalInt(oTrigger, "PCxPC", 1);
				 SetLocalObject(oTrigger, "oOtherPartyLeader", GetFactionLeader(oOtherPC));
				 object oOtherPartyLeader = GetLocalObject(oTrigger, "oOtherPartyLeader");
				 object oOtherFaction = GetFirstFactionMember(oOtherPartyLeader, TRUE);
				 SetLocalString(oOtherPartyLeader, GetName(oOtherFaction), GetName(oOtherFaction));
				 SetLocalString(oOtherFaction, GetName(oOtherPartyLeader), GetName(oOtherPartyLeader));
				 DelayCommand(1800.0, SetLocalString(oOtherFaction, GetName(oOtherPartyLeader), GetName(oOtherPartyLeader)));
				 DelayCommand(1800.0, SetLocalString(oOtherPartyLeader, GetName(oOtherFaction), GetName(oOtherFaction)));
				
				
				//Set variables: Party Hide and Move Silently for other party
				if(GetStealthMode(oOtherPartyLeader) == (STEALTH_MODE_ACTIVATED))
						{int iOtherPartyStealthHide = GetSkillRank(SKILL_HIDE, oOtherPC, FALSE);
						 if(iOtherPartyStealthHide < GetLocalInt(oTrigger, "iOtherPartyStealthHide"))
						 	{SetLocalInt(oTrigger, "iOtherPartyStealthHide", iOtherPartyStealthHide);
						 	}
						 int iOtherPartyStealthMS = GetSkillRank(SKILL_MOVE_SILENTLY, oOtherPC, FALSE);
						 if(iOtherPartyStealthMS < GetLocalInt(oTrigger, "iOtherPartyStealthMS"))
						 	{SetLocalInt(oTrigger, "iOtherPartyStealthMS", iOtherPartyStealthMS);
						 	}
						 }
				 
				}		
		 oOtherPC = GetNextObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(oPartyLeader), FALSE, OBJECT_TYPE_CREATURE);
		}
		
		object oOtherPartyLeader = GetLocalObject(oTrigger, "oOtherPartyLeader");
		object oOtherFaction = GetFirstFactionMember(oOtherPartyLeader);
							
	 	//If there is another party on the highway and both groups are not stealthed, jump both parties to meeting area
		//If one or both parties are stealthed, give spot/listen rolls and SendTexts if passed
		//Set DCs for spot/listen rolls and strings for SendTexts
		//Grab cached possible destinations, so that they can be despawned in advance of a PCxPC meeting
		int iPCxPC = GetLocalInt(oTrigger, "PCxPC");
		if(iPCxPC == 1) 
		   {int iPartyStealthHide = GetLocalInt(oTrigger, "iPartyStealthHide");				
			int iPartyStealthMS = GetLocalInt(oTrigger, "iPartyStealthMS");				
			int iOtherPartyStealthHide = GetLocalInt(oTrigger, "iOtherPartyStealthHide");				
			int iOtherPartyStealthMS = GetLocalInt(oTrigger, "iOtherPartyStealthMS");				
								 
			int iPartySpotDC = d20(1) + iOtherPartyStealthHide;
			int iPartyListenDC = d20(1) + iOtherPartyStealthMS;
			int iOtherPartySpotDC = d20(1) + iPartyStealthHide;
			int iOtherPartyListenDC = d20(1) + iPartyStealthMS;
		
			string sSpotPC_Stealth = "You catch a glimpse of a travelling party ahead, slipping from shadow to shadow slowly and stealthily.";
			string sListenPC_Stealth = "You hear the muted sounds of travellers on the road ahead. The sounds are soft and muffled.";
			string sSpotListenPC_Stealth = "Sharp eyes and ears allow you to both see and hear a travelling party ahead despite that party's apparent attempt at stealth.";
			string sMeeting = "If you wish to speak with them, perhaps you can convince them to step off the road with you.";
			string sSpotted;	
			if(oPartyDestination == oPartyDestinationGeneric)
				{sSpotPC_Stealth = "You catch a glimpse of a travelling party on the road ahead.";
				 sListenPC_Stealth = "You hear the sounds of travellers on the road ahead.";
				 sSpotListenPC_Stealth =  "The sounds of a travelling party on the road ahead precede your sight of the approaching party.";
			 	 sPCCombat = "There is fighting on the road ahead!";
				}
					
			
			//Here's where we jump the parties if neither are stealthed				
			if((GetStealthMode(oOtherPartyLeader) != STEALTH_MODE_ACTIVATED) && (GetStealthMode(oPartyLeader) != STEALTH_MODE_ACTIVATED))
				{//First check to see if they've been together recently. If so, assume they don't want an auto-port
				if(GetLocalString(oPartyLeader, GetName(oOtherPartyLeader)) == GetName(oOtherPartyLeader))
					{if(GetLocalInt(oPartyLeader, "TravelledWith " + GetName(oOtherPartyLeader)) == 0)
							{TSM_SendText(oPartyLeader, "Another party of travellers nearby is led by someone with whom you have recently travelled. If you wish to speak to the other party, perhaps you can convince them to step off the road with you.");
							 SetLocalInt(oPartyLeader, "TravelledWith " + GetName(oOtherPartyLeader), 1);
							 DelayCommand(1800.0, SetLocalInt(oPartyLeader, "TravelledWith " + GetName(oOtherPartyLeader), 0));
							 TSM_SendText(oOtherPartyLeader, "Another party of travellers nearby is led by someone with whom you have recently travelled. If you wish to speak to the other party, perhaps you can convince them to step off the road with you.");
							 SetLocalInt(oOtherPartyLeader, "TravelledWith " + GetName(oPartyLeader), 1);
							 DelayCommand(1800.0, SetLocalInt(oOtherPartyLeader, "TravelledWith "+ GetName(oPartyLeader), 0));
							}
						 //Of course, if they're travelling together as solo parties to avoid encounters, that isn't going to work
						 //Give them two hints, then begin rolling encounters as if they were partied as one party
						 else if(GetLocalInt(oPartyLeader, "TravelledWith " + GetName(oOtherPartyLeader)) == 1)
						 	{TSM_SendText(oPartyLeader, "A party of travellers nearby is led by someone with whom you have recently travelled. Perhaps you had better join together as one party to provide protection on the road.");
							 SetLocalInt(oPartyLeader, "TravelledWith " + GetName(oOtherPartyLeader), 2);
							 TSM_SendText(oOtherPartyLeader, "A party of travellers nearby is led by someone with whom you have recently travelled. Perhaps you had better join together as one party to provide protection on the road.");
							 SetLocalInt(oOtherPartyLeader, "TravelledWith " + GetName(oPartyLeader), 2);
							 }						
						 }
					
				//If they haven't travelled or been PCxPC ported together within the last 30 minutes, do the autojump
				else if(GetLocalString(oPartyLeader, GetName(oOtherPartyLeader)) != GetName(oOtherPartyLeader))
					{while(oPartyMember != OBJECT_INVALID)
						{//Set oPCDestination on the jumper so that DMFI follow-off can grab it later if needed
						SetLocalObject(oPartyMember, "oPCDestination", oPartyDestination);
		 				 while(oOtherFaction != OBJECT_INVALID)
							{//Set those strings to avoid autoporting for 30 minutes
							 SetLocalObject(oOtherFaction, "oPCDestination", oPartyDestination);
		 					 SetLocalString(oPartyMember, GetName(oOtherFaction), GetName(oOtherFaction));
					     	 DelayCommand(1800.0, SetLocalString(oPartyMember, GetName(oOtherFaction), ""));
					 	 	 SetLocalString(oOtherFaction, GetName(oPartyMember), GetName(oPartyMember));
					     	 DelayCommand(1800.0, SetLocalString(oOtherFaction, GetName(oPartyMember), ""));
					 	 	 //The Other Party only needs to be told once they're pausing, not once per PartyMember
							 if(GetLocalInt(oOtherFaction, "Pause") != 1)
							 	{TSM_SendText(oOtherFaction, "Another party of travellers nearby causes you to pause in your journey.");
						    	 SetLocalInt(oOtherFaction, "Pause", 1);
								 DelayCommand(10.0, SetLocalInt(oOtherFaction, "Pause", 0));
								 SetLocalString(oOtherFaction, sArea, sArea);	  
					  		     DelayCommand(1800.0, SetLocalString(oOtherFaction, sArea, ""));
								 } 
							oOtherFaction = GetNextFactionMember(oOtherPartyLeader, TRUE);
							}
						 //Set the sArea string to avoid porting to this area in a monster encounter for 30 minutes
						 SetLocalString(oPartyMember, sArea, sArea);	  
			  		     DelayCommand(1800.0, SetLocalString(oPartyMember, sArea, ""));
						 TSM_SendText(oPartyMember, "Another party of travellers nearby causes you to pause in your journey.");
						 oPartyMember = GetNextFactionMember(oPartyLeader, TRUE);
						}
						
					//Despawn the appropriate area to avoid porting PCs into lingering monsters from previous encounters
					 if(oPartyDestination == oPartyDestinationSpecific)
					 	{ACR_SetIsSpawnPointEnabled(oDestination1, FALSE, TRUE);
						 ACR_SetIsSpawnPointEnabled(oDestination2, FALSE, TRUE);
						 ACR_SetIsSpawnPointEnabled(oDestination3, FALSE, TRUE);
						 ACR_SetIsSpawnPointEnabled(oDestinationDragon, FALSE, TRUE);
						 }
					 else
						 {ACR_SetIsSpawnPointEnabled(oDestinationGeneric1, FALSE, TRUE);
						 ACR_SetIsSpawnPointEnabled(oDestinationGeneric2, FALSE, TRUE);
						 ACR_SetIsSpawnPointEnabled(oDestinationGeneric3, FALSE, TRUE);
						 ACR_SetIsSpawnPointEnabled(oDestinationGenericDragon, FALSE, TRUE);
						 }
					 //Jump 'em
					 DelayCommand(5.0, AssignCommand(oTrigger, JumpPartyToArea(oPartyLeader, oPartyMeet)));
					 DelayCommand(6.0, AssignCommand(oTrigger, JumpPartyToArea(oOtherPartyLeader, oOtherMeet)));
					}
				}
				
			//Here's where we start checking spot rolls for stealthed parties
			 else if((GetStealthMode(oOtherPartyLeader) == STEALTH_MODE_ACTIVATED) && (GetStealthMode(oPartyLeader) != STEALTH_MODE_ACTIVATED))
				{//if the Other Party is stealthed, give each PartyMember a spot/listen roll against the cached worst Hide/MS of the OtherParty
				while(oPartyMember != OBJECT_INVALID)
					{if(GetIsSkillSuccessful(oPartyMember, SKILL_SPOT, iPartySpotDC, FALSE))
						{if(GetIsSkillSuccessful(oPartyMember, SKILL_LISTEN, iPartyListenDC, FALSE))
							{TSM_SendText(oPartyMember, sSpotListenPC_Stealth);
							}
						 else{TSM_SendText(oPartyMember, sSpotPC_Stealth);
						 	}
						TSM_SendText(oPartyMember, sMeeting);
						sSpotted = "One of your party members points out an approaching travelling party.";
						}
					 else if(GetIsSkillSuccessful(oPartyMember, SKILL_LISTEN, iPartyListenDC, FALSE))
							{TSM_SendText(oPartyMember, sListenPC_Stealth);
							 TSM_SendText(oPartyMember, sMeeting);
							 sSpotted = "One of your party members points out an approaching travelling party.";
						     }
					else
						{TSM_SendText(oPartyMember, sSpotted);
						}
						
					oPartyMember = GetNextFactionMember(oPartyLeader, TRUE);
					}
					
				//Warn the stealthed Other Party that others are rolling against them	
				 while(oOtherFaction != OBJECT_INVALID)
					{TSM_SendText(oOtherFaction, "There is another party of travellers ahead. Perhaps they have not seen or heard your stealthy progress.");
					 oOtherFaction = GetNextFactionMember(oOtherPartyLeader);
					}	
				}
				
			//if the PartyLeader Party is stealthed, give each Other Party Member a spot/listen roll 
			//against the cached worst Hide/MS of the PartyLeader Party
				else if((GetStealthMode(oOtherPartyLeader) != STEALTH_MODE_ACTIVATED) && (GetStealthMode(oPartyLeader) == STEALTH_MODE_ACTIVATED))
				{while(oOtherFaction != OBJECT_INVALID)
					{if(GetIsSkillSuccessful(oOtherFaction, SKILL_SPOT, iOtherPartySpotDC, FALSE))
						{if(GetIsSkillSuccessful(oOtherFaction, SKILL_LISTEN, iOtherPartyListenDC, FALSE))
							{TSM_SendText(oOtherFaction, sSpotListenPC_Stealth);
							}
						 else{TSM_SendText(oOtherFaction, sSpotPC_Stealth);
						 	}
						TSM_SendText(oOtherFaction, sMeeting);
						sSpotted = "One of your party members points out an approaching travelling party.";
						}
					 else if(GetIsSkillSuccessful(oOtherFaction, SKILL_LISTEN, iOtherPartyListenDC, FALSE))
							{TSM_SendText(oOtherFaction, sListenPC_Stealth);
							 TSM_SendText(oOtherFaction, sMeeting);
							 sSpotted = "One of your party members points out an approaching travelling party.";
						    }
					else
						{TSM_SendText(oOtherFaction, sSpotted);
						}
												
					oOtherFaction = GetNextFactionMember(oOtherPartyLeader);
					}
					
				 //Warn the stealthed PartyLeader Party that others are rolling against them	
				 while(oPartyMember != OBJECT_INVALID)
					{TSM_SendText(oPartyMember, "There is another party of travellers ahead. Perhaps they have not seen or heard your stealthy progress.");
					 oPartyMember = GetNextFactionMember(oPartyLeader);
					}	
				}
				
			//if both parties are stealthed, roll against each other
			else if((GetStealthMode(oOtherPartyLeader) == STEALTH_MODE_ACTIVATED)&& (GetStealthMode(oPartyLeader) == STEALTH_MODE_ACTIVATED))
				{while(oOtherFaction != OBJECT_INVALID)
					{if(GetIsSkillSuccessful(oOtherFaction, SKILL_SPOT, iOtherPartySpotDC, FALSE))
						{if(GetIsSkillSuccessful(oOtherFaction, SKILL_LISTEN, iOtherPartyListenDC, FALSE))
							{TSM_SendText(oOtherFaction, sSpotListenPC_Stealth);
							}
						 else{TSM_SendText(oOtherFaction, sSpotPC_Stealth, TRUE, COLOR_CYAN);
						 	}
						TSM_SendText(oOtherFaction, sMeeting);
						sSpotted = "One of your party members points out an approaching travelling party.";
						}
					 else if(GetIsSkillSuccessful(oOtherFaction, SKILL_LISTEN, iOtherPartyListenDC, FALSE))
							{TSM_SendText(oOtherFaction, sListenPC_Stealth);
							 TSM_SendText(oOtherFaction, sMeeting);
							 sSpotted = "One of your party members points out an approaching travelling party.";
						     }
					 else
						{TSM_SendText(oOtherFaction, sSpotted, TRUE, COLOR_CYAN);
						}
					 oOtherFaction = GetNextFactionMember(oOtherPartyLeader);
					}
					
				 while(oPartyMember != OBJECT_INVALID)
					{if(GetIsSkillSuccessful(oPartyMember, SKILL_SPOT, iPartySpotDC, FALSE))
						{if(GetIsSkillSuccessful(oPartyMember, SKILL_LISTEN, iPartyListenDC, FALSE))
							{TSM_SendText(oPartyMember, sSpotListenPC_Stealth, TRUE, COLOR_CYAN);
							}
						 else{TSM_SendText(oPartyMember, sSpotPC_Stealth, TRUE, COLOR_CYAN);
						 	}
						TSM_SendText(oPartyMember, sMeeting, TRUE, COLOR_CYAN);
						sSpotted = "One of your party members points out an approaching travelling party.";
						}
					 else if(GetIsSkillSuccessful(oPartyMember, SKILL_LISTEN, iPartyListenDC, FALSE))
							{TSM_SendText(oPartyMember, sListenPC_Stealth, TRUE, COLOR_CYAN);
							 TSM_SendText(oPartyMember, sMeeting, TRUE, COLOR_CYAN);
							 sSpotted = "One of your party members points out an approaching travelling party.";
							}
					 else
						{TSM_SendText(oPartyMember, sSpotted, TRUE, COLOR_CYAN);
						}
					oPartyMember = GetNextFactionMember(oPartyLeader);
					}	
				}
				//At this point, if there IS another party within range and the two parties have NOT gotten two hints to join together, return.
				//Otherwise, if the parties are travelling together too long, go ahead to first check for yet more PCs in the passing areas,
				//then roll encounters with wandering monsters
				if(GetLocalInt(oPartyLeader, "TravelledWith " + GetName(oOtherPartyLeader)) != 2)
					{return;}
			 }
		
					 
																 
		//If no PCxPC Travel Map meeting called for, check the destination area for PCs						
		//Send the PCCombat message to the triggering Party if applicable, then return. It is assumed such combat is visible from the road.
		//If stealthed, give spots to the triggering party against the resident party's Hide/MS
		if(iPCxPC != 1) 
		{	sPCCombat = GetLocalString(oTrigger, "sPCCombat");
			sSpotListenPC = GetLocalString(oTrigger, "sSpotListenPC");
			sSpotPC = GetLocalString(oTrigger, "sSpotPC");
			sListenPC = GetLocalString(oTrigger, "sListenPC");
			object oObjectPC = GetFirstObjectInArea(GetArea(oPartyDestination));
			while(oObjectPC != OBJECT_INVALID)
					{if(GetIsPC(oObjectPC)) 
					 	{SetLocalInt(oTrigger, "iPC", 1);
						 if(GetIsInCombat(oObjectPC))
							 {while(oPartyMember != OBJECT_INVALID)
								{TSM_SendText(oPartyMember, sPCCombat, TRUE, COLOR_CYAN);
								 oPartyMember = GetNextFactionMember(oPC, TRUE);
								}
							 return;
							}
					 	 else if (GetStealthMode(oObjectPC) != STEALTH_MODE_ACTIVATED)
						 	{int Area_PC_Stealth_Hide = DCSpot;
							 int Area_PC_Stealth_MS = DCListen;
							 break;
							 }
							 
						 else if (GetStealthMode(oObjectPC) == STEALTH_MODE_ACTIVATED)
						 	{int Area_PC_Stealth_Hide = GetSkillRank(SKILL_HIDE, oObjectPC, FALSE);
							 if(Area_PC_Stealth_Hide < GetLocalInt(oTrigger, "Area_PC_Stealth_Hide"))
							 	{SetLocalInt(oTrigger, "Area_PC_Stealth_Hide", Area_PC_Stealth_Hide);
							 	}
							 int Area_PC_Stealth_MS = GetSkillRank(SKILL_MOVE_SILENTLY, oObjectPC, FALSE);
							 if(Area_PC_Stealth_MS < GetLocalInt(oTrigger, "Area_PC_Stealth_MS"))
							 	{SetLocalInt(oTrigger, "Area_PC_Stealth_MS", Area_PC_Stealth_MS);
							 	}
							}
						 }
					  oObjectPC = GetNextObjectInArea(GetArea(oPartyDestination));	
					}
			//Give the PartyMembers Spot/Listen vs. the area DCSpot/DCListen if any of the resident PCs aren't stealthed
			//Give the PartyMembers Spot/Listen vs. the worst Hide/MS of the resident PC party if all are stealthed
			int iPC = GetLocalInt(oTrigger, "iPC");
			if(iPC == 1)
				{while(oPartyMember != OBJECT_INVALID)
					{int Area_PC_Stealth_Hide = GetLocalInt(oTrigger, "Area_PC_Stealth_Hide");
					 int Area_PC_Stealth_Listen = GetLocalInt(oTrigger, "Area_PC_Stealth_Listen");
					 if(GetIsSkillSuccessful(oPartyMember, SKILL_SPOT, Area_PC_Stealth_Hide, FALSE))
							{if(GetIsSkillSuccessful(oPartyMember, SKILL_LISTEN, Area_PC_Stealth_Listen, FALSE))
								{TSM_SendText(oPartyMember, sSpotListenPC, TRUE, COLOR_CYAN);
								}
							 else 
								{TSM_SendText(oPartyMember, sSpotPC, TRUE, COLOR_CYAN);
								}
							}
					 else if(GetIsSkillSuccessful(oPartyMember, SKILL_LISTEN, Area_PC_Stealth_Listen, FALSE))
								{TSM_SendText(oPartyMember, sListenPC, TRUE, COLOR_CYAN);
								}
							 
					 oPartyMember = GetNextFactionMember(oPC, TRUE);
					  }
				  
				 //if any PCs are in the Destination Area, even if the triggering party failed spot/listen on them, do not spawn monsters on them		  
				 return;
				}
			} 	
						
	
	//Whether or not this PC has had an encounter in this area in the last 30 minutes, set this trigger 
	//on Party Members for 30 minutes and proceed.
		  SetLocalString(oPartyLeader, GetName(oTrigger), GetName(oTrigger));
		  DelayCommand(1800.0, SetLocalString(oPartyLeader, GetName(oTrigger), ""));
		   while(oPartyMember != OBJECT_INVALID)
			  	{SetLocalString(oPartyMember, GetName(oTrigger), GetName(oTrigger));
			  	 DelayCommand(1800.0, SetLocalString(oPartyMember, GetName(oTrigger), ""));
			     oPartyMember = GetNextFactionMember(oPartyLeader, TRUE);
				 }
				
		 
			 
	//Go ahead and make a wandering monster roll
		int iRandomEnc = 1;
		
				
		if(((!GetIsNight()) && (iRandomEnc < 6) && (iGroup > 21) && (iAreaNumber < 13)) 
				|| ((!GetIsNight()) && (iRandomEnc < 11) && (iGroup < 22)&& (iAreaNumber < 13))
				|| ((GetIsNight()) && (iRandomEnc < 11) && (iAreaNumber < 13))   
				|| ((!GetIsNight()) && (iRandomEnc < 8) && (iGroup > 21) && (iAreaNumber >= 13))   
				|| ((GetIsNight()) && (iRandomEnc < 13) && (iGroup > 21) && (iAreaNumber >= 13))   
				|| ((iRandomEnc < 11) && (iGroup < 22) && (iAreaNumber >= 13)))   
						
			{//Pull the remaining local trigger area variables cached earlier and so far unused, and define others for the first time
	 			sArea = GetLocalString(oTrigger, "sArea");
				sDragonDirection = GetLocalString(oTrigger, "sDragonDirection");
				sDest1 = GetLocalString(oTrigger, "sDest1");
				sDest3 = GetLocalString(oTrigger, "sDest3");
				DCSpot = GetLocalInt(oTrigger, "DCSpot");
				DCSpotNight = GetLocalInt(oTrigger, "DCSpotNight");
				DCListen = GetLocalInt(oTrigger, "DCListen");
				int iRangerLvlMult;
				string sLinguage;
				string sLangRace;
				string sSpotListen;
				string sSpot;
				string sListen;	 
				string sPosition = "You move quickly to the best defensive position you can find.";
			    string sLookSee = "Uneasy for some reason, you move off the road to have a look around.";
				//Define the group script to run on the waypoint cached as the the mob destination, and monster specific variables
				string sGroup;	 
				if((iGroup < 10 ) && (iAreaNumber < 11))
					{sGroup = "argent";
					 sSpotListen = "The clomping of military boots and the jingle of military hardware fill the air. You see a column of Argent Legion soldiers to the " + sMobDirection + ".";
					 sSpot = "You see a file of soldiers to the " + sMobDirection + ".";
					 sListen = "A commanding voice barks an order to troops to halt, somewhere to the " + sMobDirection + ".";
					 sPosition = "";
					 }
				else if((iGroup < 10 ) && (iAreaNumber > 10))
					{sGroup = "kis";
					 sSpotListen = "Armor creaks and helmets shine. You see a Knights in Silver patrol to the " + sMobDirection + ".";
					 sSpot = "You see a file of soldiers to the " + sMobDirection + ".";
					 sListen = "A commanding voice barks an order to troops to halt, to the " + sMobDirection + ".";
					 sPosition = "";
					 }
				else if(iGroup < 11)
					{object oArea = GetArea(oPartyDestination);		 
				        if(GetTag(oArea) == "003_travel_map_north_road")
						 	{sDragonDirection = "on a bluff north of the natural arch";
							}
						 else if(GetTag(oArea) == "003_travel_map_silvy_pass")
						 	{sDragonDirection = "on a plateau overlooking the pass from the west";
							}
						 else if(GetTag(oArea) == "003_travel_map_west_road")
						 	{sDragonDirection = "on a cliff south of the road";
							}
						 else if(GetTag(oArea) == "003_travel_map_silvy_road")
						 	{sDragonDirection = "on a pile of boulders northeast of the road";
							}
					 sGroup = "dragon";
					 sSpotListen = "A thunderous roar splits the air from high, high above you as a huge, scaled, winged form flies overhead. Has it seen you? Is it hunting? It lands on " + sDragonDirection + ".";
					 sSpot = "The shadow of a massive winged form flashes over the ground, casting you momentarily in its pall. Dread creeps over you as the creature that cast the shadow lands on " + sDragonDirection + ".";
					 sListen = "A thunderous roar echoes suddenly, from above. Only one creature could make that bellow...but where is the dragon?";
					 DCSpot = 10;
				     DCListen = 0;
				 	 object oPartyMember = GetFirstFactionMember(oPC, TRUE);
					 while(oPartyMember != OBJECT_INVALID)
					 	{if((GetHasFeat(272, oPartyMember, TRUE)) || (GetHasFeat(1209, oPartyMember, TRUE)))
							{if(GetLevelByClass(7, oPartyMember) < 20)
							 	{iRangerLvlMult = 4;}
							 if(GetLevelByClass(7, oPartyMember) < 15)
							 	{iRangerLvlMult = 3;}
							 if(GetLevelByClass(7, oPartyMember) < 10)
							 	{iRangerLvlMult = 2;}
							 if(GetLevelByClass(7, oPartyMember) < 5)
							 	{iRangerLvlMult = 1;}
							 SetLocalInt(oPartyMember, "FavoredEnemyBonus", 1 * iRangerLvlMult); 
							}
						 oPartyMember = GetNextFactionMember(oPC, TRUE);
					 	} 
					}
				else if(iGroup < 17)
					{sGroup = "merchant";
					 sSpotListen = "The cheerful whistling and periodic calls of 'Goods for sale!' draw your eyes to a travelling merchant to the " + sMobDirection + ".";
					 sListen = "Somewhere close, you hear a voice calling out: 'Goods for sale!' from the " + sMobDirection + ".";
					 sSpot = "To the " + sMobDirection + " you spot a travelling merchant, by his pack and heavy load of gear.";
					 sPosition = "";
					 }
				else if(iGroup < 22)
					{sGroup = "priest";
					 sSpotListen = "The sound of quiet prayer draws your attention to a figure in clerical garb to the " + sMobDirection + ".";
					 sSpot = "A figure in clerical garb strolls  to the " + sMobDirection + ".";
					 sListen = "The soft chanting of someone in prayer reaches your ears from the " + sMobDirection + ".";
					 sPosition = "";
					 }
				else if(iGroup < 27)
					{sGroup = "gnolls_low";
					 sLinguage = LNG_GNOLL;
					 sLangRace = "gnoll";
					 sSpotListen = "Menacing dog-headed figures whine and shake their weaponry. Mangy looking gnolls to the " + sMobDirection + "!";
					 sSpot = "Mangy gnolls snuffle around the underbrush to the " + sMobDirection + ".";
					 sListen = "Somewhere nearby you hear barking and growling strung together into a conversation from the " + sMobDirection + ".";
					 object oPartyMember = GetFirstFactionMember(oPC, TRUE);
					 while(oPartyMember != OBJECT_INVALID)
					 	{if((GetHasFeat(274, oPartyMember, TRUE)) || (GetHasFeat(1211, oPartyMember, TRUE)))
							{if(GetLevelByClass(7, oPartyMember) < 20)
							 	{iRangerLvlMult = 4;}
							 if(GetLevelByClass(7, oPartyMember) < 15)
							 	{iRangerLvlMult = 3;}
							 if(GetLevelByClass(7, oPartyMember) < 10)
							 	{iRangerLvlMult = 2;}
							 if(GetLevelByClass(7, oPartyMember) < 5)
							 	{iRangerLvlMult = 1;}
							 SetLocalInt(oPartyMember, "FavoredEnemyBonus", 1 * iRangerLvlMult); 
							}
						 oPartyMember = GetNextFactionMember(oPC, TRUE);
					 	} 
					}
				else if(iGroup < 32)
					{sGroup = "gnolls_elite";
					 sLinguage = LNG_GNOLL;
					 sLangRace = "gnoll";
					 sSpotListen = "Battle-scarred, very large gnolls growl and yip at each other to the " + sMobDirection + ". They appear well armed and experienced!";
					 sSpot = "Battle-scarred, very large gnolls growl and yip at each other to the " + sMobDirection + ".";
					 sListen = "Somewhere nearby you hear barking and growling strung together into a conversation from the " + sMobDirection + ".";
					 object oPartyMember = GetFirstFactionMember(oPC, TRUE);
					 while(oPartyMember != OBJECT_INVALID)
					 	{if((GetHasFeat(274, oPartyMember, TRUE)) || (GetHasFeat(1211, oPartyMember, TRUE)))
							{if(GetLevelByClass(7, oPartyMember) < 20)
							 	{iRangerLvlMult = 4;}
							 if(GetLevelByClass(7, oPartyMember) < 15)
							 	{iRangerLvlMult = 3;}
							 if(GetLevelByClass(7, oPartyMember) < 10)
							 	{iRangerLvlMult = 2;}
							 if(GetLevelByClass(7, oPartyMember) < 5)
							 	{iRangerLvlMult = 1;}
							 SetLocalInt(oPartyMember, "FavoredEnemyBonus", 1 * iRangerLvlMult); 
							}
						 oPartyMember = GetNextFactionMember(oPC, TRUE);
					 	} 
					}
				else if(iGroup < 37)
					{sGroup = "goblins_low";
					 sLinguage = LNG_GOBLIN;
					 sLangRace = "goblin";
					 sSpotListen = "Runty, wart-skinned goblins screech and yammer at each other to the " + sMobDirection + ".";
					 sSpot = "Movement in the underbrush seems to be made by small, ugly, green-skinned humanoids to the " + sMobDirection + ".";
					 sListen = "High, thin, vicious voices converse somewhere to the " + sMobDirection + ".";
					 object oPartyMember = GetFirstFactionMember(oPC, TRUE);
					 while(oPartyMember != OBJECT_INVALID)
					 	{if((GetHasFeat(273, oPartyMember, TRUE))|| (GetHasFeat(1210, oPartyMember, TRUE)))
							{if(GetLevelByClass(7, oPartyMember) < 20)
							 	{iRangerLvlMult = 4;}
							 if(GetLevelByClass(7, oPartyMember) < 15)
							 	{iRangerLvlMult = 3;}
							 if(GetLevelByClass(7, oPartyMember) < 10)
							 	{iRangerLvlMult = 2;}
							 if(GetLevelByClass(7, oPartyMember) < 5)
							 	{iRangerLvlMult = 1;}
							 SetLocalInt(oPartyMember, "FavoredEnemyBonus", 1 * iRangerLvlMult); 
							}
						 oPartyMember = GetNextFactionMember(oPC, TRUE);
					 	} 
					}
				else if(iGroup < 42)
					{sGroup = "goblins_elite";
					 sLinguage = LNG_GOBLIN;
					 sLangRace = "goblin";
					 sSpotListen = "Jabbering back and forth, goblins, muscled and well-armed for their kind, stalk among the rocks, trees and brush to the " + sMobDirection + ".";
					 sSpot = "Ugly, green-skinned goblins, large for their race, lope along to the " + sMobDirection + ".";
					 sListen = "High, thin, vicious voices converse somewhere to the " + sMobDirection + " in a monstrous language.";
					 object oPartyMember = GetFirstFactionMember(oPC, TRUE);
					 while(oPartyMember != OBJECT_INVALID)
					 	{if((GetHasFeat(273, oPartyMember, TRUE))|| (GetHasFeat(1210, oPartyMember, TRUE)))
							{if(GetLevelByClass(7, oPartyMember) < 20)
							 	{iRangerLvlMult = 4;}
							 if(GetLevelByClass(7, oPartyMember) < 15)
							 	{iRangerLvlMult = 3;}
							 if(GetLevelByClass(7, oPartyMember) < 10)
							 	{iRangerLvlMult = 2;}
							 if(GetLevelByClass(7, oPartyMember) < 5)
							 	{iRangerLvlMult = 1;}
							 SetLocalInt(oPartyMember, "FavoredEnemyBonus", 1 * iRangerLvlMult); 
							}
						 oPartyMember = GetNextFactionMember(oPC, TRUE);
					 	} 
					}
				else if(iGroup < 47)
					{sGroup = "lycanthrope";
					 sSpotListen = "A creature half fur and fangs, half humanoid, stalks to the " + sMobDirection + " of you. An animal's cry bursts from its throat, but the movement of the creature are too sentient to be pure beast.";
					 sSpot = "You spot a creature half animal, half humanoid to the " + sMobDirection + ".";
					 sListen = "You hear the howls and shrieks of some wild animal from the " + sMobDirection + ".";
					object oPartyMember = GetFirstFactionMember(oPC, TRUE);
					 while(oPartyMember != OBJECT_INVALID)
					 	{if((GetHasFeat(284, oPartyMember, TRUE))|| (GetHasFeat(1219, oPartyMember, TRUE)))
							{if(GetLevelByClass(7, oPartyMember) < 20)
							 	{iRangerLvlMult = 4;}
							 if(GetLevelByClass(7, oPartyMember) < 15)
							 	{iRangerLvlMult = 3;}
							 if(GetLevelByClass(7, oPartyMember) < 10)
							 	{iRangerLvlMult = 2;}
							 if(GetLevelByClass(7, oPartyMember) < 5)
							 	{iRangerLvlMult = 1;}
							 SetLocalInt(oPartyMember, "FavoredEnemyBonus", 1 * iRangerLvlMult); 
							}
						 oPartyMember = GetNextFactionMember(oPC, TRUE);
					 	} 
					}
				else if(iGroup < 50)
					{sGroup = "ogre_low";
					 sLinguage = LNG_GIANT;
					 sLangRace = "ogre, a dialect of giant";
					 sSpotListen = "Grunting what sounds like curses, crashing, thrusting all out of its path, at least one ogre lumbers to the " + sMobDirection + ".";
					 sSpot = "A huge, mis-shapen humanoid lurches along to the " + sMobDirection + ", carrying a club.";
					 sListen = "A crashing and grunting of what sounds like curses that comes from the " + sMobDirection + " has silenced all natural sounds.";
					 object oPartyMember = GetFirstFactionMember(oPC, TRUE);
					 while(oPartyMember != OBJECT_INVALID)
					 	{if((GetHasFeat(279, oPartyMember, TRUE)) || (GetHasFeat(1216, oPartyMember, TRUE)))
							{if(GetLevelByClass(7, oPartyMember) < 20)
							 	{iRangerLvlMult = 4;}
							 if(GetLevelByClass(7, oPartyMember) < 15)
							 	{iRangerLvlMult = 3;}
							 if(GetLevelByClass(7, oPartyMember) < 10)
							 	{iRangerLvlMult = 2;}
							 if(GetLevelByClass(7, oPartyMember) < 5)
							 	{iRangerLvlMult = 1;}
							 SetLocalInt(oPartyMember, "FavoredEnemyBonus", 1 * iRangerLvlMult); 
							}
						 oPartyMember = GetNextFactionMember(oPC, TRUE);
					 	} 
					}
				else if(iGroup < 54)
					{sGroup = "orcs_low";
					 sLinguage = LNG_ORC;
					 sLangRace = "orcish";
					 sSpotListen = "Orcs bellow and snarl to the " + sMobDirection + ", laying waste to all natural beauty around them.";
					 sListen = "Deep, bestial voices growl and bellow to the " + sMobDirection + ", fighting amongst themselves, or preparing to attack?";
					 sSpot = "You spot orcs to the " + sMobDirection + "!";
					 object oPartyMember = GetFirstFactionMember(oPC, TRUE);
					 while(oPartyMember != OBJECT_INVALID)
					 	{if((GetHasFeat(275, oPartyMember, TRUE)) || (GetHasFeat(1212, oPartyMember, TRUE)))
							{if(GetLevelByClass(7, oPartyMember) < 20)
							 	{iRangerLvlMult = 4;}
							 if(GetLevelByClass(7, oPartyMember) < 15)
							 	{iRangerLvlMult = 3;}
							 if(GetLevelByClass(7, oPartyMember) < 10)
							 	{iRangerLvlMult = 2;}
							 if(GetLevelByClass(7, oPartyMember) < 5)
							 	{iRangerLvlMult = 1;}
							 SetLocalInt(oPartyMember, "FavoredEnemyBonus", 1 * iRangerLvlMult); 
							}
						 oPartyMember = GetNextFactionMember(oPC, TRUE);
					 	} 
					}
				else if(iGroup < 58)
					{sGroup = "orcs_elite";
					 sLinguage = LNG_ORC;
					 sLangRace = "orcish";
					 sSpotListen = "Orcs, large even for their kind and well-armed, form an apparently seasoned battle group to the " + sMobDirection + ".";
					 sSpot = "You spot huge, well-armed orcs to the " + sMobDirection + ".";
					 sListen = "Rough, crude, arguments in a bestial tongue drift through the air from the " + sMobDirection + ".";
					 object oPartyMember = GetFirstFactionMember(oPC, TRUE);
					 while(oPartyMember != OBJECT_INVALID)
					 	{if((GetHasFeat(275, oPartyMember, TRUE)) || (GetHasFeat(1212, oPartyMember, TRUE)))
							{if(GetLevelByClass(7, oPartyMember) < 20)
							 	{iRangerLvlMult = 4;}
							 if(GetLevelByClass(7, oPartyMember) < 15)
							 	{iRangerLvlMult = 3;}
							 if(GetLevelByClass(7, oPartyMember) < 10)
							 	{iRangerLvlMult = 2;}
							 if(GetLevelByClass(7, oPartyMember) < 5)
							 	{iRangerLvlMult = 1;}
							 SetLocalInt(oPartyMember, "FavoredEnemyBonus", 1 * iRangerLvlMult); 
							}
						 oPartyMember = GetNextFactionMember(oPC, TRUE);
					 	} 
					}
				else if(iGroup < 71)
					{sGroup = "trolls";
					 sLinguage = LNG_GIANT;
					 sLangRace = "troll, a dialect of giant";
					 sSpotListen = "Guttural mumbling and lurching footsteps warn you in time to spot the unmistakable sight -- and smell -- of troll, to the " + sMobDirection + ".";
					 sSpot = "You spot a troll, to the " + sMobDirection + ".";
					 sListen = "Guttural mumbling sounds and footsteps drag with a rubbery, squishing sound. Something large comes this way from the " + sMobDirection + ".";
					 object oPartyMember = GetFirstFactionMember(oPC, TRUE);
					 while(oPartyMember != OBJECT_INVALID)
					 	{if((GetHasFeat(279, oPartyMember, TRUE)) || (GetHasFeat(1216, oPartyMember, TRUE)))
							{if(GetLevelByClass(7, oPartyMember) < 20)
							 	{iRangerLvlMult = 4;}
							 if(GetLevelByClass(7, oPartyMember) < 15)
							 	{iRangerLvlMult = 3;}
							 if(GetLevelByClass(7, oPartyMember) < 10)
							 	{iRangerLvlMult = 2;}
							 if(GetLevelByClass(7, oPartyMember) < 5)
							 	{iRangerLvlMult = 1;}
							 SetLocalInt(oPartyMember, "FavoredEnemyBonus", 1 * iRangerLvlMult); 
							}
						 oPartyMember = GetNextFactionMember(oPC, TRUE);
					 	} 
					}
				else if(iGroup < 73)
					{sGroup = "uthgardt_br";
					 sSpotListen = "To the " + sMobDirection + ", you see a hunting party of barbaric humans with black feathers in their hair and beards.";
					sSpot = "To the " + sMobDirection + ", you spot shaggy-haired humans wearing animal clothes and black feathers in their hair.";
					sListen = "Harsh tongues speak back and forth in a northern dialect, somewhere to the " + sMobDirection + ".";
					object oPartyMember = GetFirstFactionMember(oPC, TRUE);
					while(oPartyMember != OBJECT_INVALID)
					 	{if((GetHasFeat(267, oPartyMember, TRUE)) || (GetHasFeat(1204, oPartyMember, TRUE)))
							{if(GetLevelByClass(7, oPartyMember) < 20)
							 	{iRangerLvlMult = 4;}
							 if(GetLevelByClass(7, oPartyMember) < 15)
							 	{iRangerLvlMult = 3;}
							 if(GetLevelByClass(7, oPartyMember) < 10)
							 	{iRangerLvlMult = 2;}
							 if(GetLevelByClass(7, oPartyMember) < 5)
							 	{iRangerLvlMult = 1;}
							 SetLocalInt(oPartyMember, "FavoredEnemyBonus", 1 * iRangerLvlMult); 
							}
						 oPartyMember = GetNextFactionMember(oPC, TRUE);
					 	} 
					}
				else if(iGroup < 75)
					{sGroup = "uthgardt_gw";
					 sSpotListen = "To the " + sMobDirection + ", you see a hunting party of barbaric humans wearing wolf skins.";
					 sSpot = "To the " + sMobDirection + ", you spot shaggy-haired humans wearing gray wolf skins.";
					 sListen = "Harsh tongues speak back and forth in a northern dialect, somewhere to the " + sMobDirection + ".";
					 object oPartyMember = GetFirstFactionMember(oPC, TRUE);
					while(oPartyMember != OBJECT_INVALID)
					 	{if((GetHasFeat(267, oPartyMember, TRUE)) || (GetHasFeat(1204, oPartyMember, TRUE)))
							{if(GetLevelByClass(7, oPartyMember) < 20)
							 	{iRangerLvlMult = 4;}
							 if(GetLevelByClass(7, oPartyMember) < 15)
							 	{iRangerLvlMult = 3;}
							 if(GetLevelByClass(7, oPartyMember) < 10)
							 	{iRangerLvlMult = 2;}
							 if(GetLevelByClass(7, oPartyMember) < 5)
							 	{iRangerLvlMult = 1;}
							 SetLocalInt(oPartyMember, "FavoredEnemyBonus", 1 * iRangerLvlMult); 
							}
						 oPartyMember = GetNextFactionMember(oPC, TRUE);
					 	} 
					}
				else if(iGroup < 85)
					{sGroup = "wild";
					 sSpotListen = "A wild animal crashes through the landscape, to the " + sMobDirection + ".";
					 sSpot = "A wild animal crashes through the landscape, to the " + sMobDirection + ".";
					 sListen = "The grunt and cough of a wild animal sounds from somewhere to the " + sMobDirection + ".";
					 object oPartyMember = GetFirstFactionMember(oPC, TRUE);
					 while(oPartyMember != OBJECT_INVALID)
					 	{if((GetHasFeat(269, oPartyMember, TRUE))|| (GetHasFeat(1206, oPartyMember, TRUE)))
							{if(GetLevelByClass(7, oPartyMember) < 20)
							 	{iRangerLvlMult = 4;}
							 if(GetLevelByClass(7, oPartyMember) < 15)
							 	{iRangerLvlMult = 3;}
							 if(GetLevelByClass(7, oPartyMember) < 10)
							 	{iRangerLvlMult = 2;}
							 if(GetLevelByClass(7, oPartyMember) < 5)
							 	{iRangerLvlMult = 1;}
							 SetLocalInt(oPartyMember, "FavoredEnemyBonus", 1 * iRangerLvlMult); 
							}
						 oPartyMember = GetNextFactionMember(oPC, TRUE);
					 	} 
					}
				else if(iGroup < 90)
					{sGroup = "wolves_timber";
					 sSpotListen = "Lean gray shapes flit through the shadows. A moment later, the howling of wolves splits the air from the " + sMobDirection + ".";
					 sSpot = "Timber wolves lope silently along, to the " + sMobDirection + ".";
					 sListen = "Wolves howl from somewhere to the " + sMobDirection + ".";
					 object oPartyMember = GetFirstFactionMember(oPC, TRUE);
					 while(oPartyMember != OBJECT_INVALID)
					 	{if((GetHasFeat(269, oPartyMember, TRUE))|| (GetHasFeat(1206, oPartyMember, TRUE)))
							{if(GetLevelByClass(7, oPartyMember) < 20)
							 	{iRangerLvlMult = 4;}
							 if(GetLevelByClass(7, oPartyMember) < 15)
							 	{iRangerLvlMult = 3;}
							 if(GetLevelByClass(7, oPartyMember) < 10)
							 	{iRangerLvlMult = 2;}
							 if(GetLevelByClass(7, oPartyMember) < 5)
							 	{iRangerLvlMult = 1;}
							 SetLocalInt(oPartyMember, "FavoredEnemyBonus", 1 * iRangerLvlMult); 
							}
						 oPartyMember = GetNextFactionMember(oPC, TRUE);
					 	} 
					}
				else if((iGroup < 100) && (GetIsNight()))
					{sGroup = "undead_med";
					 sSpotListen = "A chill creeps over your skin at the sound and sight of undead to the " + sMobDirection + ".";
					 sSpot = "Lurching or clattering, silent or shadowed, the passage of undead chills the air. They have risen to the " + sMobDirection + " of your position";
					 sListen = "Chilling moans and the whisper of heartless, lifeless voices sound in the night from somewhere to the " + sMobDirection + ".";
					 object oPartyMember = GetFirstFactionMember(oPC, TRUE);
					 while(oPartyMember != OBJECT_INVALID)
					 	{if((GetHasFeat(285, oPartyMember, TRUE))|| (GetHasFeat(1220, oPartyMember, TRUE)))
							{if(GetLevelByClass(7, oPartyMember) < 20)
							 	{iRangerLvlMult = 4;}
							 if(GetLevelByClass(7, oPartyMember) < 15)
							 	{iRangerLvlMult = 3;}
							 if(GetLevelByClass(7, oPartyMember) < 10)
							 	{iRangerLvlMult = 2;}
							 if(GetLevelByClass(7, oPartyMember) < 5)
							 	{iRangerLvlMult = 1;}
							 SetLocalInt(oPartyMember, "FavoredEnemyBonus", 1 * iRangerLvlMult); 
							}
						 oPartyMember = GetNextFactionMember(oPC, TRUE);
					 	} 
					}
				
				else if(iGroup < 100)
					{sGroup = "goblins_low";
					 sLinguage = LNG_GOBLIN;
					 sLangRace = "goblin";
					 sSpotListen = "Runty, wart-skinned goblins screech and yammer at each other to the " + sMobDirection + ".";
					 sSpot = "Movement in the underbrush seems to be made by small, ugly, green-skinned humanoids to the " + sMobDirection + ".";
					 sListen = "High, thin, vicious voices converse somewhere to the " + sMobDirection + ".";
					 object oPartyMember = GetFirstFactionMember(oPC, TRUE);
					 while(oPartyMember != OBJECT_INVALID)
					 	{if((GetHasFeat(273, oPartyMember, TRUE))|| (GetHasFeat(1210, oPartyMember, TRUE)))
							{if(GetLevelByClass(7, oPartyMember) < 20)
							 	{iRangerLvlMult = 4;}
							 if(GetLevelByClass(7, oPartyMember) < 15)
							 	{iRangerLvlMult = 3;}
							 if(GetLevelByClass(7, oPartyMember) < 10)
							 	{iRangerLvlMult = 2;}
							 if(GetLevelByClass(7, oPartyMember) < 5)
							 	{iRangerLvlMult = 1;}
							 SetLocalInt(oPartyMember, "FavoredEnemyBonus", 1 * iRangerLvlMult); 
							}
						 oPartyMember = GetNextFactionMember(oPC, TRUE);
					 	} 
					}
						
				string sLangSuccess = "You recognize the language as " + sLangRace + ".";
			SendMessageToAllDMs("Encounter = " + sGroup);
		
				
							 				
				//despawn the Destination area, create the encounter,
				//make spot/listen rolls, freeze the PC to avoid double encounters
						if(oPartyDestination == oPartyDestinationSpecific)
							{ACR_SetIsSpawnPointEnabled(oDestination1, FALSE, TRUE);
						    ACR_SetIsSpawnPointEnabled(oDestination2, FALSE, TRUE);
						    ACR_SetIsSpawnPointEnabled(oDestination3, FALSE, TRUE);
						    ACR_SetIsSpawnPointEnabled(oDestinationDragon, FALSE, TRUE);
							}
						else	
							{ACR_SetIsSpawnPointEnabled(oDestinationGeneric1, FALSE, TRUE);
						    ACR_SetIsSpawnPointEnabled(oDestinationGeneric2, FALSE, TRUE);
						    ACR_SetIsSpawnPointEnabled(oDestinationGeneric3, FALSE, TRUE);
						    ACR_SetIsSpawnPointEnabled(oDestinationGenericDragon, FALSE, TRUE);
							}
							
						location lStartFrom = GetLocation(oPartyLeader);
						ACR_SetIsSpawnPointEnabled(oMobDestination, TRUE, FALSE);
					    ACR_SpawnGroup(sGroup, oMobDestination);
						
						oPartyMember = GetFirstFactionMember(oPartyLeader);
						while(oPartyMember != OBJECT_INVALID)
							{ int iFavoredEnemyBonus = GetLocalInt(oPartyMember, "FavoredEnemyBonus");
							 SetLocalLocation(oPartyMember, "lStartFrom", lStartFrom);
							 SetLocalLocation(GetArea(oPartyDestination), "lStartFrom", lStartFrom);
							 SetLocalInt(oPartyMember, "iEncounter", 1);
							 SetLocalString(oPartyMember, GetTag(GetArea(oPartyDestination)), GetTag(GetArea(oPartyDestination)));
							 DelayCommand(600.0, SetLocalInt(oPartyMember, "iEncounter", 0));
							 DelayCommand(1800.0, SetLocalString(oPartyMember, GetName(GetArea(oPartyDestination)), ""));
							 if(GetIsSkillSuccessful(oPartyMember, SKILL_SPOT, DCSpot - iFavoredEnemyBonus, FALSE) )
									{if(GetIsSkillSuccessful(oPartyMember, SKILL_LISTEN - iFavoredEnemyBonus, DCListen, FALSE))
										{TSM_SendText(oPartyMember, sSpotListen, TRUE, COLOR_CYAN);
										 DelayCommand(4.0, TSM_SendText(oPartyMember, sPosition, TRUE, COLOR_CYAN));
										 sLookSee = "One of your party members shouts a warning!";
										 }
									 else{TSM_SendText(oPartyMember, sSpot, TRUE, COLOR_CYAN);
										 DelayCommand(4.0, TSM_SendText(oPartyMember, sPosition, TRUE, COLOR_CYAN));
										 sLookSee = "One of your party members shouts a warning!";
										 }
									 }	 
							  else if(GetIsSkillSuccessful(oPartyMember, SKILL_LISTEN, DCListen - iFavoredEnemyBonus, FALSE)) 
									{TSM_SendText(oPartyMember, sListen, TRUE, COLOR_CYAN);
									 if(_IsLanguageKnown(oPartyMember, sLinguage) == TRUE) 
											{DelayCommand(2.0, TSM_SendText(oPartyMember, sLangSuccess, TRUE, COLOR_CYAN));
											}
									 DelayCommand(4.0, TSM_SendText(oPartyMember, sPosition, TRUE, COLOR_CYAN));
									 sLookSee = "One of your party members shouts a warning!";
									}
							else
								{TSM_SendText(oPartyMember, sLookSee, TRUE, COLOR_CYAN);
								 DelayCommand(4.0, TSM_SendText(oPartyMember, sPosition, TRUE, COLOR_CYAN));
								 sLookSee = "One of your party members shouts a warning!";
									}		
							
												
							  oPartyMember = GetNextFactionMember(oPartyLeader, TRUE);
							  }
							
							
							
							
						
						//if the PartyLeader Party is stealthed, give the monsters a spot/listen roll 
						//against the cached worst Hide/MS of the PartyLeader Party. If the monsters fail, apply a bonus to iRandomEnc.
						//The bonus applied is a +1 if the monster fails only Spot or Listen, or a +2 if the monster fails both.
						//If the new iRandomEnc puts the party outside the encounter percentage, abort the port...but leave the critter spawned.
						//Tell the Party that their stealthy progress has helped them avoid a {Jabberwocky} but it could still lurk in X Area.
						object oChild = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(oMobDestination), FALSE, OBJECT_TYPE_CREATURE); 
						if(GetStealthMode(oPartyLeader) == STEALTH_MODE_ACTIVATED)
						   {int iPartyStealthHide = GetLocalInt(oTrigger, "iPartyStealthHide");				
							int iPartyStealthMS = GetLocalInt(oTrigger, "iPartyStealthMS");				
						    int iMobSpotDC = d20(1) + iPartyStealthHide;
							int iMobListenDC = d20(1) + iPartyStealthMS;
							int iStealth;
							if(!GetIsSkillSuccessful(oChild, SKILL_SPOT, iMobSpotDC, FALSE))
									{if(!GetIsSkillSuccessful(oChild, SKILL_LISTEN, iMobListenDC, FALSE))
										{iStealth = 2;}
									 else{iStealth = 1;}
									}
								 else if(!GetIsSkillSuccessful(oChild, SKILL_LISTEN, iMobListenDC, FALSE))
										{iStealth = 1;
										}
							
							iRandomEnc = iRandomEnc + iStealth;
							}
						//Set the flocking destinations and execute the flocking script	
						int iRep = 1;
						object oExit = GetNearestObjectByTag(sArea + "_Exit", oMobDestination, 2);
						if(oExit == OBJECT_INVALID)
							{oExit = GetNearestObjectByTag(sArea + "_Exit", oMobDestination, 1);
							}
						object oRandom1 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_TRIGGER | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
					    if((FindSubString(GetName(oRandom1), "Sky") != -1) || (FindSubString(GetName(oRandom1), "Walkmesh") != -1))
							{oRandom1 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_TRIGGER | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
					    	}
						if(oRandom1 == oExit)
							{oRandom1 = oMobDestination;
							}
						object oRandom2 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_TRIGGER | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
						if((FindSubString(GetName(oRandom2), "Sky") != -1) || (FindSubString(GetName(oRandom2), "Walkmesh") != -1))
							{oRandom2 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_TRIGGER | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
					    	}
						if(oRandom2 == oRandom1)
							{oRandom2 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_TRIGGER | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
							if((FindSubString(GetName(oRandom2), "Sky") != -1) || (FindSubString(GetName(oRandom2), "Walkmesh") != -1))
								{oRandom2 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_TRIGGER | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
						    	}
							}
						object oRandom3 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_TRIGGER | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
						if((FindSubString(GetName(oRandom3), "Sky") != -1) || (FindSubString(GetName(oRandom3), "Walkmesh") != -1))
							{oRandom3 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_TRIGGER | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
					    	}
						if((oRandom3 == oRandom1) || (oRandom3 == oRandom2))
							{oRandom3 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_TRIGGER | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
							if((FindSubString(GetName(oRandom2), "Sky") != -1) || (FindSubString(GetName(oRandom3), "Walkmesh") != -1))
								{oRandom3 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_TRIGGER | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
						    	}
							}
						object oRandom4 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_TRIGGER | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
						if((FindSubString(GetName(oRandom4), "Sky") != -1) || (FindSubString(GetName(oRandom4), "Walkmesh") != -1))
							{oRandom4 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_TRIGGER | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
					    	}
						if((oRandom4 == oRandom1)  || (oRandom4 == oRandom2)|| (oRandom4 == oRandom3))
							{oRandom4 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_TRIGGER | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
							if((FindSubString(GetName(oRandom4), "Sky") != -1) || (FindSubString(GetName(oRandom4), "Walkmesh") != -1))
								{oRandom4 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_TRIGGER | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
						    	}
							}
						object oRandom5 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_TRIGGER | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
						if((FindSubString(GetName(oRandom5), "Sky") != -1) || (FindSubString(GetName(oRandom5), "Walkmesh") != -1))
							{oRandom5 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_TRIGGER | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
					    	}
						if((oRandom5 == oRandom1) || (oRandom5 == oRandom4)|| (oRandom5 == oRandom3)|| (oRandom5 == oRandom2))
							{oRandom5 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_TRIGGER | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
							if((FindSubString(GetName(oRandom5), "Sky") != -1) || (FindSubString(GetName(oRandom5), "Walkmesh") != -1))
								{oRandom5 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_TRIGGER | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
						    	}
							}
						object oRandom6 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_TRIGGER | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
						if((FindSubString(GetName(oRandom6), "Sky") != -1) || (FindSubString(GetName(oRandom6), "Walkmesh") != -1))
							{oRandom6 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_TRIGGER | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
					    	}
						if((oRandom6 == oRandom1) || (oRandom6 == oRandom5) || (oRandom6 == oRandom4)|| (oRandom6 == oRandom3)|| (oRandom6 == oRandom2))
							{oRandom6 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_TRIGGER | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
							if((FindSubString(GetName(oRandom6), "Sky") != -1) || (FindSubString(GetName(oRandom6), "Walkmesh") != -1))
								{oRandom6 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_TRIGGER | OBJECT_TYPE_CREATURE, oMobDestination, Random(10) + 5);
						    	}
							}
						if((iGroup < 22) && (iGroup != 10))
							{oRandom1 = oPartyDestination;
							 oRandom6 = oExit;
							 }
							 
						if(oRandom1 == OBJECT_INVALID)
							{oRandom1 = oMobDestination;
							}
						if(oRandom2 == OBJECT_INVALID)
							{oRandom2 = oMobDestination;
							}
						if(oRandom3 == OBJECT_INVALID)
							{oRandom3 = oMobDestination;
							}
						if(oRandom4 == OBJECT_INVALID)
							{oRandom4 = oMobDestination;
							}
						if(oRandom5 == OBJECT_INVALID)
							{oRandom5 = oMobDestination;
							}
						if(oRandom6 == OBJECT_INVALID)
							{oRandom6 = oMobDestination;
							}
						
						
								while(oChild != OBJECT_INVALID) 
									{float fDistance = GetDistanceBetween(oChild, oPC);
									 object oWP = GetNearestObject(OBJECT_TYPE_WAYPOINT, OBJECT_SELF, 1);
									 SetLocalObject(oChild, "oRandom1", oRandom1);
									 SetLocalObject(oChild, "oRandom2", oRandom2);
									 SetLocalObject(oChild, "oRandom3", oRandom3);
									 SetLocalObject(oChild, "oRandom4", oRandom4);
									 SetLocalObject(oChild, "oRandom5", oRandom5);
									 SetLocalObject(oChild, "oRandom6", oRandom6);
									 DelayCommand(30.0, ExecuteScript("tsm_npc_flocking", oChild));
									 if(FindSubString(GetTag(oChild), "dragon") != -1)
										 {string sDragon = "dragon";
										  if(oChild != OBJECT_INVALID)
										  	{sDragon = GetName(oChild);
											} 
										 float fDragonDestroy = IntToFloat(Random(60) + 60);
										  DestroyObject(oChild, fDragonDestroy);
										  while(oPartyMember != OBJECT_INVALID)
												{DelayCommand(fDragonDestroy, TSM_SendText(oPartyMember, "The " + sDragon + " flies off, vanishing in the distance.", TRUE, COLOR_CYAN));
												 oPartyMember = GetNextFactionMember(oPartyLeader, TRUE);
												}
										   }
									  oChild = GetNextObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(oMobDestination), FALSE, OBJECT_TYPE_CREATURE);
									 }
							 	
						 
						if(((!GetIsNight()) && (iRandomEnc >= 6) && (iGroup > 21) && (iAreaNumber < 13)) 
								|| ((!GetIsNight()) && (iRandomEnc >= 11) && (iGroup < 22)&& (iAreaNumber < 13))
								|| ((GetIsNight()) && (iRandomEnc >= 11) && (iAreaNumber < 13))   
								|| ((!GetIsNight()) && (iRandomEnc >= 8) && (iGroup > 21) && (iAreaNumber >= 13))   
								|| ((GetIsNight()) && (iRandomEnc >= 13) && (iGroup > 21) && (iAreaNumber >= 13))   
								|| ((iRandomEnc >= 11) && (iGroup < 22) && (iAreaNumber >= 13)))   
								
									{while(oPartyMember != OBJECT_INVALID)
										{SetLocalInt(oPartyMember, "iEncounter", 0);
										 DelayCommand(11.0, TSM_SendText(oPartyMember, "You have successfully avoided at least one " + GetName(oChild) + ". It may still lurk in the region around " + GetName(GetArea(oPartyDestination)) + ".", TRUE, COLOR_CYAN));
										 oPartyMember = GetNextFactionMember(oPartyLeader, TRUE);
										}
									 return;
									}
									
						AssignCommand(oPartyLeader, ClearAllActions(TRUE));
					    effect eFreeze = EffectParalyze(50, SAVING_THROW_WILL, FALSE);	
						ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, oPartyLeader, 15.0);
						DelayCommand(15.0, JumpPartyToArea(oPartyLeader, oPartyDestination));
						DelayCommand(3.0, ActionJumpToObject(oPartyDestination, FALSE));
						//Drag in other parties that are within 5.0
						if(GetDistanceBetween(oPartyLeader, oOtherPartyLeader) < 5.0)
							{effect eFreeze = EffectParalyze(50, SAVING_THROW_WILL, FALSE);	
							 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, oOtherPartyLeader, 15.0);
							 while(oOtherFaction != OBJECT_INVALID)
								{SetLocalObject(oOtherFaction, "oPCDestination", oPartyDestination);
								 TSM_SendText(oOtherFaction, "You and another party of travellers have stumbled into some trouble on the road!", TRUE, COLOR_CYAN);
								 oOtherFaction = GetNextFactionMember(oOtherPartyLeader, TRUE);
								  }
							 DelayCommand(15.0, JumpPartyToArea(oOtherPartyLeader, oPartyDestination));
							}
							
					}	
					
			}
}
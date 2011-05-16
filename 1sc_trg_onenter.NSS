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
//  2007/01/20  Cipher  Inception
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_trigger_i"
#include "acr_quest_i"



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
    ACR_TriggerOnEnter();
	
	int iPower = Random(5);
	int nTrap_Power;
	if(iPower == 4)
		{nTrap_Power = 1;
		}
	object oTrap;
	object oChest = GetLocalObject(OBJECT_SELF, "oChest");
	if(GetLocalString(oChest, GetName(GetEnteringObject())) != GetName(GetEnteringObject()))
		{SetLocalString(oChest, GetName(GetEnteringObject()), GetName(GetEnteringObject()));
		 if(GetUseableFlag(oChest) == FALSE)
			{int iUseableDC = GetLocalInt(oChest, "iUseableDC");
			 if(iUseableDC == 0)
					{iUseableDC = 20 + Random(11) - Random(11);
					 SetLocalInt(oChest, "iUseableDC", iUseableDC);
					}
			 if(GetIsSkillSuccessful(GetEnteringObject(), SKILL_SEARCH, iUseableDC, FALSE) == TRUE)
				{SetUseableFlag(oChest, TRUE);
				 int iUnlockDC = GetLocalInt(oChest, "iUnlockDC");
				 if(iUnlockDC == 0)
						{iUnlockDC = 30 + Random(11) - Random(11) + (5 * nTrap_Power);
						 SetLocalInt(oChest, "iUnlockDC", iUnlockDC);
						}
				 if(GetLockLockable(oChest) == TRUE)
						{SetLocked(oChest, TRUE);
						}
				 SetLockUnlockDC(oChest, iUnlockDC);
				 if(GetLocalInt(oChest, "Trappable") == 1)
				 	{if(Random(2) == 1)
					 	{int iDetectDC = GetLocalInt(oChest, "iDetectDC");;
						 if(iDetectDC == 0)
								{iDetectDC = 20 + Random(11) - Random(11) + (5 * nTrap_Power);
								 SetLocalInt(oChest, "iDetectDC", iDetectDC);
								}
						 int iDisableDC = GetLocalInt(oChest, "iDisableDC");
						 if(iDisableDC == 0)
								{iDisableDC = 25 + Random(11) - Random(11) + (5 * nTrap_Power);
								 SetLocalInt(oChest, "iDisableDC", iDisableDC);
								}
						 if(iPower == 4)
						 	{CreateTrapOnObject(4 * Random(11) + 1, oChest, STANDARD_FACTION_HOSTILE, "1sc_plc_ontrapdisarm");
						 	 SetLocalInt(oChest, "Average_Trap", 1);
							 }
						 else
						 	{CreateTrapOnObject(4 * Random(11), oChest, STANDARD_FACTION_HOSTILE, "1sc_plc_ontrapdisarm");
						 	}
						 oTrap = GetNearestTrapToObject(OBJECT_SELF, FALSE);
						 SetTrapDisarmable(oTrap, TRUE);
						 SetTrapDetectDC(oTrap, iDetectDC);
						 SetTrapDisarmDC(oTrap, iDisableDC);
						 SetTrapDisarmable(oChest, TRUE);
						 SetTrapDetectDC(oChest, iDetectDC);
						 SetTrapDisarmDC(oChest, iDisableDC);
						 SetLocalInt(oChest, "DM_Trapped", 1);
		 }
					}
				 }
			}
		}
    // Custom code goes here.
	

}
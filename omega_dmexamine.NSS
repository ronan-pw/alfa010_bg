//  System Name : ALFA Core Rules
//     Filename : i_acr_dmexamine_ac
//    $Revision::             $ current version of the file
//        $Date::             $ date the file was created or modified
//       Author : AcadiusLost

//  Dependencies: None
//  Description
//  This script handles activation of the dc setter wand, for traps and doors.
//
//  Revision History
//  2008/11/03  AcadiusLost  Inception
////////////////////////////////////////////////////////////////////////////////


void main()
{
object oDM = OBJECT_SELF;
object oTarget = GetLocalObject(oDM, "Object_Damage");
    

string sDescription = GetDescription(oTarget);
SendMessageToPC(oDM, "Description field for object "+GetName(oTarget));
SendMessageToPC(oDM, "With tag = "+GetTag(oTarget));
SendMessageToPC(oDM, "-----------------------");
SendMessageToPC(oDM, sDescription);

}		
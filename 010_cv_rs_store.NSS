// a_DoStuff (string sTarget)
/*
	Description:
	
	Parameters:
		sTarget -  Tag of the target object.  Default is OWNER.

		
	=== Action Script general Info ===
	This is a conversation action script template.  
	Action script names are usually prefixed as follows:
		"ga_" - global action script
		"ka_" - campaign action script
		"<moduleID>a_" - module action script
	Conversation actions and conditions are the only scripts that can have parameters.
	Any number and many types of parameters can be passed.
*/
// Name_Date

#include "ginc_param_const"

void main(string sTarget)
{
	// Get the PC Speaker - if used from command line, then use OBJECT_SELF
	// In a conversation, OBJECT_SELF refers to the NPC.
	// From the command line, OBJECT_SELF refers to the currently possesed character.
    object oPC = (GetPCSpeaker()==OBJECT_INVALID?OBJECT_SELF:GetPCSpeaker());

	// Find a target by Tag - also supports "$PC", "$OWNED_CHAR", etc. (see list in ginc_param_const)
	// Optional second parameter can be added to change the default target.
	object oTarget = GetTarget(sTarget);
	object oStore = GetObjectByTag("010_bg_red_sheaf");
	
	// If debug text is on, this will let you know the script fired.
	//PrettyDebug("Script Fired on target: " + GetName(oTarget) + "!");
	
	// Do stuff here
	OpenStore(oStore, oPC);
}
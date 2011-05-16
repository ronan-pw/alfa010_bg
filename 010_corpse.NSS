// Placeable OnUsed Template	
/*
	Required: Static=FALSE, Usable=TRUE, CurrentHP>0, attach script to the OnUsed event
	Suggested: Plot=TRUE, DefaultActionPreference="Use"
*/
//

#include "ginc_debug"

void main()
{
	object oUser = GetLastUsedBy();

	PrettyDebug( GetName( OBJECT_SELF ) + "'s was used by " + GetName( oUser ) );

	//BeginConversation("clothes");
	ActionStartConversation(oUser,"010_corpse",TRUE);
	
	// Do something
}
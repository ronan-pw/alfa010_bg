
#include "ginc_debug"

void main()
{
	object oUser = GetLastUsedBy();

	PrettyDebug( GetName( OBJECT_SELF ) + "'s was used by " + GetName( oUser ) );

	//BeginConversation("clothes");
	ActionStartConversation(oUser,"bg_altar_umberlee",TRUE);
	
	// Do something
}
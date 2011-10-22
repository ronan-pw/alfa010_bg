void main(string tag)
{
	int i;
	string t;
	object o;
	
	GetNearestCreatureToLocation(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, GetLocation(GetPCSpeaker()));
	
	for (i=1; o != OBJECT_INVALID; ++i) {
		
		t = GetTag(o);
		
		if (FindSubString(t,tag) == -1)
			continue;
			
		ChangeToStandardFaction(o,STANDARD_FACTION_HOSTILE);
			
		o = GetNearestCreatureToLocation(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, GetLocation(GetPCSpeaker()), i);
	}
}
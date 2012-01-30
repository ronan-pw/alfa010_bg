void main(string tag)
{
	int i;
	string t;
	object o;
	
	o = GetNearestCreatureToLocation(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, GetLocation(GetPCSpeaker()));
	
	for (i=0; o != OBJECT_INVALID; ++i) {
			
		o = GetNearestCreatureToLocation(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, GetLocation(GetPCSpeaker()), i);
		
		t = GetTag(o);
		
		if (FindSubString(t,tag) != -1) {
			ChangeToStandardFaction(o,STANDARD_FACTION_HOSTILE);
		}
	}
}

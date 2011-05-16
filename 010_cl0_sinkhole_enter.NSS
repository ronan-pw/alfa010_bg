void main()
{
	object o = GetEnteringObject();
	string s_r0 = "abr_it_gr_rope";
	string s_r1 = "010_it_ms_rope5";
	string s_r2 = "abr_it_ms_rope5";
	string s_g0 = "abr_it_gr_grapplinghook";
	
	int r = 0;
	int g = 0;
	
	if (!GetIsPC(o))
		return;
	
	r = GetIsObjectValid(GetItemPossessedBy(o,s_r0)) +
		GetIsObjectValid(GetItemPossessedBy(o,s_r1)) + 
		GetIsObjectValid(GetItemPossessedBy(o,s_r2));
	g = GetIsObjectValid(GetItemPossessedBy(o,s_g0));
	
	if (((r > 0) && (g > 0)) || (GetGlobalInt("sinkhole_rope") > 0)) {
		BeginConversation("010_cl0_sinkhole",o);
	}
}
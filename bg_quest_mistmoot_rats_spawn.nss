void main()
{
	location loc;
	object o;
	
	o = GetWaypointByTag("ud_mistmoot_keg_spawn");
	loc = GetLocation(o);
	CreateObject(OBJECT_TYPE_ITEM, "it_plot_alekeg", loc);
}

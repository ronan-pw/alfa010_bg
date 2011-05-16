void main()
{
	location loc;
	object o;
	
	o = GetWaypointByTag("bg_mermaid_cask_spawn");
	loc = GetLocation(o);
	CreateObject(OBJECT_TYPE_ITEM, "it_plot_winecask", loc);
}
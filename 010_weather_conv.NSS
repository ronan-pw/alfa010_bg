#include "010_weather_i"

void main()
{
	object o = GetLastSpeaker();
	object pc = GetPCSpeaker();
	int cmd,arg,region;
	string stype,spower;
	
	cmd = GetLocalInt(o,"command");
	arg = GetLocalInt(o,"arg");
	region = GetLocalInt(o,"region");
	
	switch (cmd) {
		case 0:
			break;
		case 1:
			set_region_weather(region,arg,get_region_weather_power(region));
			break;
		case 2:
			set_region_weather(region,get_region_weather_type(region),arg);
			break;
	}
	
	switch (get_region_weather_type(region)) {
		case 0:
			stype = "clear";
			break;
		case 1:
			stype = "rain";
			break;
		case 2:
			stype = "storm";
			break;
	}
	
	switch (get_region_weather_power(region)) {
		case 0:
			spower = "empty";
			break;
		case 1:
			spower = "weak";
			break;
		case 2:
			spower = "light";
			break;
		case 3:
			spower = "medium";
			break;
		case 4:
			spower = "heavy";
			break;
		case 5:
			spower = "extreme";
			break;
	}
	SendMessageToPC(pc,"Region "+IntToString(region)+" is "+spower + " " + stype+".");
}

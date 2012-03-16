#include "010_area_ex"
#include "acr_debug_i"

/* mild weather */

string wmat_mild =
/*          C    R    L    +    -  */
/* C1 */ "1.00,0.10,0.05,1.00,0.00;"+
/* C2 */ "1.00,0.07,0.05,1.00,1.00;"+
/* C3 */ "1.00,0.05,0.10,1.00,1.20;"+
/* C4 */ "1.00,0.05,0.15,1.00,1.50;"+
/* C5 */ "1.00,0.01,0.20,0.00,2.00;"+
/* R1 */ "2.00,1.00,0.20,1.00,0.00;"+
/* R2 */ "1.20,1.00,0.30,1.00,1.00;"+
/* R3 */ "0.50,1.00,0.40,1.00,1.20;"+
/* R4 */ "0.05,1.00,0.70,1.00,1.50;"+
/* R5 */ "0.01,1.00,1.00,0.00,2.00;"+
/* L1 */ "0.10,2.50,1.00,1.00,0.00;"+
/* L2 */ "0.05,2.00,1.00,1.00,1.00;"+
/* L3 */ "0.02,1.50,1.00,1.00,1.20;"+
/* L4 */ "0.01,1.50,1.00,1.00,1.50;"+
/* L5 */ "0.01,1.00,1.00,0.00,2.00;";

/* rainy weather */

string wmat_rainy =
/*          C    R    L    +    -  */
/* C1 */ "1.00,1.00,0.05,1.00,0.00;"+
/* C2 */ "1.00,0.80,0.05,1.00,1.00;"+
/* C3 */ "1.00,0.70,0.10,1.00,1.20;"+
/* C4 */ "1.00,0.50,0.15,1.00,1.50;"+
/* C5 */ "1.00,0.10,0.20,0.00,2.00;"+
/* R1 */ "1.50,1.00,0.20,1.00,0.00;"+
/* R2 */ "1.00,1.00,0.30,1.00,1.00;"+
/* R3 */ "0.10,1.00,0.40,1.00,1.20;"+
/* R4 */ "0.05,1.00,0.70,1.00,1.50;"+
/* R5 */ "0.01,1.00,1.00,0.00,2.00;"+
/* L1 */ "0.10,2.50,1.00,1.00,0.00;"+
/* L2 */ "0.05,2.00,1.00,1.00,1.00;"+
/* L3 */ "0.02,1.50,1.00,1.00,1.20;"+
/* L4 */ "0.01,1.50,1.00,1.00,1.50;"+
/* L5 */ "0.01,1.00,1.00,0.00,2.00;";

string wmat_empty =
/*          C    R    L    +    -  */
/* C1 */ "1.00,0.00,0.00,0.00,0.00;"+
/* C2 */ "0.00,0.00,0.00,0.00,0.00;"+
/* C3 */ "0.00,0.00,0.00,0.00,0.00;"+
/* C4 */ "0.00,0.00,0.00,0.00,0.00;"+
/* C5 */ "0.00,0.00,0.00,0.00,0.00;"+
/* R1 */ "0.00,0.00,0.00,0.00,0.00;"+
/* R2 */ "0.00,0.00,0.00,0.00,0.00;"+
/* R3 */ "0.00,0.00,0.00,0.00,0.00;"+
/* R4 */ "0.00,0.00,0.00,0.00,0.00;"+
/* R5 */ "0.00,0.00,0.00,0.00,0.00;"+
/* L1 */ "0.00,0.00,0.00,0.00,0.00;"+
/* L2 */ "0.00,0.00,0.00,0.00,0.00;"+
/* L3 */ "0.00,0.00,0.00,0.00,0.00;"+
/* L4 */ "0.00,0.00,0.00,0.00,0.00;"+
/* L5 */ "0.00,0.00,0.00,0.00,0.00;";

/* dependence of regions on other regions (Y->X) */
string rmat_dependence =
/*        0    1    2    3    4    5    6   */
/* 0 */ "0.00,0.10,0.10,0.00,0.10,0.50,0.00;"+
/* 1 */ "0.10,0.00,0.20,0.10,0.20,0.20,0.20;"+
/* 2 */ "0.10,0.20,0.00,0.00,0.00,0.30,0.00;"+
/* 3 */ "0.00,0.20,0.10,0.00,0.20,0.00,0.20;"+
/* 4 */ "0.10,0.10,0.00,0.10,0.00,0.20,0.20;"+
/* 5 */ "0.30,0.10,0.10,0.00,0.10,0.00,0.00;"+
/* 6 */ "0.00,0.20,0.00,0.20,0.30,0.00,0.00;";

const int BW_TYPE_CLEAR = 0;
const int BW_TYPE_RAIN = 1;
const int BW_TYPE_LIGHTNING = 2;

const float POWER_COEF = 0.5;

const string _WEATHER_SYSTEM_NAME = "010_weather_i";
int MAX_RND = 65535/2;
const int TICKS_PER_CHANGE = 20;

const int num_types = 3;
const int num_powers = 5;
const int num_regions = 7;

const int rows_per_type = num_powers;

const int wmat_n = 5;
int wmat_m = rows_per_type * num_types;

const int rmat_n = num_regions;
const int rmat_m = rmat_n;

const int chars_per_entry = 5;
int wmat_chars_per_row = wmat_n * chars_per_entry;

string get_wmat_row(int type, int power, string matrix)
{
	int row = power + type*rows_per_type;

	return GetSubString(matrix, row*wmat_chars_per_row, wmat_chars_per_row);
}

float get_wmat_entry(int i, string row)
{
	return StringToFloat(GetSubString(row, i*chars_per_entry, chars_per_entry));
}

float get_rmat_entry(int i, int j, string mat)
{
	return StringToFloat(GetSubString(mat, (i*rmat_n*chars_per_entry)+(j*chars_per_entry), chars_per_entry));
}

int get_region_weather_type(int region)
{
	return GetGlobalInt("weather_"+IntToString(region)+"_type");
}

int get_region_weather_power(int region)
{
	return GetGlobalInt("weather_"+IntToString(region)+"_power");
}

void set_region_weather(int region, int type, int power)
{
	SetGlobalInt("weather_"+IntToString(region)+"_type",type);
	SetGlobalInt("weather_"+IntToString(region)+"_power",power);
}

string calc_next_state(int region, int cur_type, int cur_power, string matrix)
{
	int i, dep_type, dep_power;
	int new_type = cur_type;
	int new_power = cur_power;
	string row = get_wmat_row(cur_type, cur_power, matrix);
	float diff_power, sum,f0,f1,f2,f3,f4,val,d,eps=1.0/MAX_RND;

	f0 = get_wmat_entry(0,row);
	f1 = get_wmat_entry(1,row);
	f2 = get_wmat_entry(2,row);
	f3 = get_wmat_entry(3,row);
	f4 = get_wmat_entry(4,row);
	
	/* generate dependence */
	for (i=0; i<rmat_n; ++i) {
		d = get_rmat_entry(region-1,i,rmat_dependence);
		dep_type = get_region_weather_type(i);
		dep_power = get_region_weather_power(i);
		
		switch (dep_type) {
			case BW_TYPE_CLEAR:
				f0 *= 1.0+d;
				break;
			case BW_TYPE_RAIN:
				f1 *= 1.0+d;
				break;
			case BW_TYPE_LIGHTNING:
				f2 *= 1.0+d;
				break;
		}
		
		diff_power = IntToFloat(dep_power - cur_power);
		
		if (diff_power > 0.0)
			f3 *= 1.0+d*diff_power*POWER_COEF;
			
		else if (diff_power < 0.0)
			f4 *= 1.0+d*(-diff_power)*POWER_COEF;
	}
	
	sum = f0+f1+f2+f3+f4;
	
	/* normalize */
	f0 = f0/sum;
	f1 = f1/sum + f0;
	f2 = f2/sum + f1;
	f3 = f3/sum + f2;
	f4 = f4/sum + f3;
	
	/* DEBUG */
	//SendMessageToPC(GetPrimaryPlayer(), "Generate path, (f0: "+FloatToString(f0)+"), (f1: "+FloatToString(f1)+"), (f2: "+FloatToString(f2)+"), (f3: "+FloatToString(f3)+"), (f4: "+FloatToString(f4)+")");
	
	
	val = IntToFloat(Random(MAX_RND))/IntToFloat(MAX_RND);
	
	/* DEBUG */
	//SendMessageToPC(GetPrimaryPlayer(), "Path:" + FloatToString(val));
	
	
	if (val < f0)
		new_type = 0;
	else if (val < f1)
		new_type = 1;
	else if (val < f2)
		new_type = 2;
	else if (val < f3)
		new_power = (new_power < num_powers-1 ? new_power+1 : num_powers-1);
	else
		new_power = (new_power > 0 ? new_power-1 : 0);
		
	return IntToString(new_type)+","+IntToString(new_power);
}

void set_fog( object oTarget, int nColor, float fFogStart, float fFogEnd)
{
	SetNWN2Fog( oTarget, FOG_TYPE_NWN2_SUNRISE, nColor, fFogStart, fFogEnd );
	SetNWN2Fog( oTarget, FOG_TYPE_NWN2_DAYTIME, nColor, fFogStart, fFogEnd );
	SetNWN2Fog( oTarget, FOG_TYPE_NWN2_SUNSET, nColor, fFogStart, fFogEnd );
	SetNWN2Fog( oTarget, FOG_TYPE_NWN2_MOONRISE, nColor, fFogStart, fFogEnd );
	SetNWN2Fog( oTarget, FOG_TYPE_NWN2_NIGHTTIME, nColor, fFogStart, fFogEnd );
	SetNWN2Fog( oTarget, FOG_TYPE_NWN2_MOONSET, nColor, fFogStart, fFogEnd );
}

void reset_fog(object oTarget )
{
	ResetNWN2Fog( oTarget, FOG_TYPE_NWN2_SUNRISE);
	ResetNWN2Fog( oTarget, FOG_TYPE_NWN2_DAYTIME);
	ResetNWN2Fog( oTarget, FOG_TYPE_NWN2_SUNSET);
	ResetNWN2Fog( oTarget, FOG_TYPE_NWN2_MOONRISE);
	ResetNWN2Fog( oTarget, FOG_TYPE_NWN2_NIGHTTIME);
	ResetNWN2Fog( oTarget, FOG_TYPE_NWN2_MOONSET);
}


void set_weather(object area,int type,int power)
{
	int track=0,volume=25;
	float tmp;
	
	/* convert power/type */
	power++;
	
	reset_fog(area);
	
	switch (type) {
		case 0:
			power = 0;
			
			/* hack for lightning */
			SetWeather(area,2,power);
			
			/* leave if unchanged */
			if (GetWeather(area, WEATHER_TYPE_RAIN) == 0) {
				if (power >= 3) {
					tmp = IntToFloat(power-2)+0.1;
					set_fog(area,FOG_COLOR_WHITE,50.0/(tmp),150.0/(tmp));
				}
			}
			break;
		case 1:
			type = 0;
			
			switch (power) {
				case 1:
					volume = 25;
					track = 38;
					break;
				case 2:
					volume = 60;
					track = 38;
					break;
				case 3:
					volume = 50;
					track = 135;
					break;
				case 4:
					volume = 50;
					track = 39;
					break;
				default:
					track = 39;
					volume = 100;
			}
			break;
		case 2:
		
			/* hack for lightning */
			SetWeather(area,0,power);
			
			switch (power) {
				case 1:
					track = 41;
					volume = 25;
					break;
				case 2:
					track = 41;
					volume = 75;
					break;
				case 3:
					track = 40;
					volume = 50;
					break;
				case 4:
					track = 40;
					volume = 50;
					break;
				default:
					track = 134;
					volume = 100;
			}
			break;
	}
	
	/* stop if it is a different track */
	if (GetLocalInt(area,"ambient_tmp_day_track") != track) {
		AmbientSoundStop(area);
		SetLocalInt(area,"ambient_tmp_day_track",track);
		SetLocalInt(area,"ambient_tmp_night_track",track);
		
		AmbientSoundChangeDay(area, GetLocalInt(area,"ambient_day_track"));
		AmbientSoundChangeNight(area, GetLocalInt(area,"ambient_night_track"));
	}
	
	
	/* set back to original/clear track */
	if (track == 0) {
		
		if (GetLocalInt(area,"ambient_day_track")) {
			AmbientSoundChangeDay(area, GetLocalInt(area,"ambient_day_track"));
		}
		else {
			AmbientSoundChangeDay(area, 138);
		}
			
		if (GetLocalInt(area,"ambient_night_track")) {
			AmbientSoundChangeNight(area, GetLocalInt(area,"ambient_night_track"));
		}
		else {
			volume = 10; // this thing was sampled SUPER loud
			AmbientSoundChangeDay(area, 128);
		}
	}
	else {
		AmbientSoundChangeDay(area, track);
		AmbientSoundChangeNight(area, track);
	}
	
	ACR_PrintDebugMessage("Setting weather ["+GetTag(area)+"] ("+IntToString(track)+","+IntToString(volume)+"),("+IntToString(type)+","+IntToString(power)+")", _WEATHER_SYSTEM_NAME, DEBUG_LEVEL_INFO);
	
	AmbientSoundSetDayVolume(area,volume);
	AmbientSoundSetNightVolume(area,volume);

	AmbientSoundPlay(area);
	SetWeather(area,type,power);
}


void process_weather()
{
	object area;
	int type,power,i,region=0;
	string retval, matrix;
	
	SetGlobalInt("weather_timer",GetGlobalInt("weather_timer")+1);

	/* shift weather */ 
	if (GetGlobalInt("weather_timer") <= GetGlobalInt("weather_threshold"))
		return;
			
	/* initialize */
	if (GetGlobalInt("weather_threshold") == 0) {
		ACR_CreateDebugSystem(_WEATHER_SYSTEM_NAME, DEBUG_TARGET_NONE, DEBUG_TARGET_LOG | DEBUG_TARGET_DMS, DEBUG_TARGET_LOG | DEBUG_TARGET_DMS);

		SetGlobalInt("weather_threshold", TICKS_PER_CHANGE);

	
		ACR_PrintDebugMessage("Initializing weather system...", _WEATHER_SYSTEM_NAME, DEBUG_LEVEL_INFO);
		
		return;
	}
	
	SetGlobalInt("weather_threshold", TICKS_PER_CHANGE + Random(TICKS_PER_CHANGE));
	SetGlobalInt("weather_timer",0);
	
		
	for (i=1; i<=num_regions; ++i) {
		type = get_region_weather_type(i);				
		power = get_region_weather_power(i);
		
		switch (i) {
			case 1:
			case 3:
				matrix = wmat_rainy;
				break;
			case 0:
				matrix = wmat_empty;
				break;
			default:
				matrix = wmat_mild;
		}
		
		retval = calc_next_state(region, type, power, matrix);
		type = StringToInt(GetSubString(retval,0,1));
		power = StringToInt(GetSubString(retval,2,1));
					
		set_region_weather(i,type,power);
			
		ACR_PrintDebugMessage(get_region_name(i)+" ("+IntToString(i)+") -> ("+IntToString(type)+","+IntToString(power)+")", _WEATHER_SYSTEM_NAME, DEBUG_LEVEL_INFO);
	}
			
			
	area = GetFirstArea();
	
	while (GetIsObjectValid(area)) {
	
		if (!GetIsAreaInterior(area)) {
			region = get_area_region(area);
						
			type = get_region_weather_type(region);				
			power = get_region_weather_power(region);
				
			set_weather(area,type,power);
		}
		area = GetNextArea();
	}
}

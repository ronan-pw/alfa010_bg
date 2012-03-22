/* 1 - bg
   2 - beregost
   3 - candlekeep
   4 - amn
   5 - sharpteeth
   6 - cloakwood
   7 - gullykin
   8 - snowy amn
*/

const int NUM_REGIONS = 9;

// TODO: rename to get_area_region
// 

string get_region_name(int region)
{
	switch (region) {
		case 0: return "other";
		case 1: return "baldursgate";
		case 2: return "beregost";
		case 3: return "candlekeep";
		case 4: return "nashkel";
		case 5: return "sharpteeth";
		case 6: return "cloakwood";
		case 7: return "gullykin";
		case 8: return "cloudpeaks";
		default:
	}
	return "invalid";
}

int get_area_region(object area=OBJECT_SELF)
{
	string str;
	int n;
	
	str = GetTag(area);
	
	//WriteTimestampedLogEntry("010_areas: get_area_region(): "+GetName(area) + " (" + GetTag(area) + ")");
	
	if (GetLocalInt(area,"region") > 0)
		return GetLocalInt(area,"region");
	
	if (FindSubString(str,"beregost") != -1) 
		return 2;
	else if (FindSubString(str,"sharpteeth") != -1) 
		return 5;
	else if (FindSubString(str,"cloakwood") != -1) 
		return 6;
	else if (FindSubString(str,"candlekeep") != -1) 
		return 3;
	else if (FindSubString(str,"lion") != -1) 
		return 3;
	else if (FindSubString(str,"pass") != -1) 
		return 8;
	else if (FindSubString(str,"nashkel") != -1) 
		return 4;
	else if (FindSubString(str,"cloud") != -1) 
		return 8;
	else if (FindSubString(str,"gullykin") != -1) 
		return 7;
	else if (FindSubString(str,"firewine") != -1) 
		return 7;
	else if (FindSubString(str,"uldoon") != -1) 
		return 7;
	else if (FindSubString(str,"tradeway") != -1) {
		str = GetSubString(str,11,2);
		n = StringToInt(str);
		
		// south of 1s of beregost
		if (n > 9)
			return 4;
		// north of 2s of bg
		else if (n < 3)
			return 1;
		// north of lionsway
		else if (n < 6)
			return 6;
		// around beregost
		else 
			return 2;
	}
	return 1;
}


int get_area_region_test(object owner=OBJECT_SELF)
{
	return get_area_region(GetArea(owner));
}

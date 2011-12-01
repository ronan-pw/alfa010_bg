
string generate_dwarf_name(int female)
{
	string str = "";
	switch (Random(20)) {
		case 0:
			str += "B";
			break;
		case 1:
			str += "Bal";
			break;
		case 2:
			str += "Bel";
			break;
		case 3:
			str += "Bof";
			break;
		case 4:
			str += "Bol";
			break;
		case 5:
			str += "D";
			break;
		case 6:
			str += "Dal";
			break;
		case 7:
			str += "Dor";
			break;
		case 8:
			str += "Dw";
			break;
		case 9:
			str += "Far";
			break;
		case 10:
			str += "Gil";
			break;
		case 11:
			str += "Gim";
			break;
		case 12:
			str += "Kil";
			break;
		case 13:
			str += "Mor";
			break;
		case 14:
			str += "Nal";
			break;
		case 15:
			str += "Nor";
			break;
		case 16:
			str += "Ov";
			break;
		case 17:
			str += "Th";
			break;
		case 18:
			str += "Thor";
			break;
		case 19:
			str += "Thr";
			break;
	}

	switch (Random(16)) {
		case 0:
			str += "b";
			break;
		case 1:
			str += "d";
			break;
		case 2:
			str += "f";
			break;
		case 3:
			str += "g";
			break;
		case 4:
			str += "k";
			break;
		case 5:
			str += "m";
			break;
		case 6:
			str += "t";
			break;
		case 7:
			str += "v";
			break;
		case 8:
			str += "z";
			break;
		case 9:
			str += "";
			break;
		case 10:
			str += "";
			break;
		case 11:
			str += "";
			break;
		case 12:
			str += "";
			break;
		case 13:
			str += "";
			break;
		case 14:
			str += "";
			break;
		case 15:
			str += "";
			break;
	}

	if (female) {
		switch (Random(10)) {
			case 0:
				str +=  "a";
				break;
			case 1:
				str +=  "ala";
				break;
			case 2:
				str +=  "ana";
				break;
			case 3:
				str +=  "ip";
				break;
			case 4:
				str +=  "ia";
				break;
			case 5:
				str +=  "ila";
				break;
			case 6:
				str +=  "ina";
				break;
			case 7:
				str +=  "on";
				break;
			case 8:
				str +=  "ola";
				break;
			case 9:
				str +=  "ona";
				break;
		}
	}
	else {
		switch (Random(10)) {
			case 0:
				str +=  "aim";
				break;
			case 1:
				str +=  "ain";
				break;
			case 2:
				str +=  "ak";
				break;
			case 3:
				str +=  "ar";
				break;
			case 4:
				str +=  "i";
				break;
			case 5:
				str +=  "im";
				break;
			case 6:
				str +=  "in";
				break;
			case 7:
				str +=  "o";
				break;
			case 8:
				str +=  "or";
				break;
			case 9:
				str +=  "ur";
				break;
		}
	}

	return str;
}

string generate_gnome_name(int female,int last)
{
	string str = "";
	int i;

	if (!last) {
		for (i=0; i<=Random(3); ++i) {
		
			switch (Random(40)) {
				case 0:
					str += "Arum";
					break;
				case 1:
					str += "Add";
					break;
				case 2:
					str += "Baer";
					break;
				case 3:
					str += "Bar";
					break;
				case 4:
					str += "Callad";
					break;
				case 5:
					str += "Chik";
					break;
				case 6:
					str += "Dal";
					break;
				case 7:
					str += "Din";
					break;
				case 8:
					str += "Eaus";
					break;
				case 9:
					str += "Erf";
					break;
				case 10:
					str += "Enn";
					break;
				case 11:
					str += "Faer";
					break;
				case 12:
					str += "Flan";
					break;
				case 13:
					str += "Fen";
					break;
				case 14:
					str += "Gaer";
					break;
				case 15:
					str += "Gar";
					break;
				case 16:
					str += "Hed";
					break;
				case 17:
					str += "Herl";
					break;
				case 18:
					str += "Ien";
					break;
				case 19:
					str += "Jan";
					break;
				case 20:
					str += "Kaer";
					break;
				case 21:
					str += "Len";
					break;
				case 22:
					str += "Lun";
					break;
				case 23:
					str += "Mikk";
					break;
				case 24:
					str += "Neb";
					break;
				case 25:
					str += "Oaen";
					break;
				case 26:
					str += "Ow";
					break;
				case 27:
					str += "Pall";
					break;
				case 28:
					str += "Pin";
					break;
				case 29:
					str += "Raer";
					break;
				case 30:
					str += "Ras";
					break;
				case 31:
					str += "Seg";
					break;
				case 32:
					str += "Skor";
					break;
				case 33:
					str += "Tikk";
					break;
				case 34:
					str += "Uran";
					break;
				case 35:
					str += "Urd";
					break;
				case 36:
					str += "Van";
					break;
				case 37:
					str += "Var";
					break;
				case 38:
					str += "Wann";
					break;
				case 39:
					str += "Wed";
					break;
			}
		}
	}
	else {
		switch (Random(20)) {
			case 0:
				str += "Wild";
				break;
			case 1:
				str += "Earth";
				break;
			case 2:
				str += "Fast";
				break;
			case 3:
				str += "Fast";
				break;
			case 4:
				str += "Glitter";
				break;
			case 5:
				str += "Gold";
				break;
			case 6:
				str += "Honor";
				break;
			case 7:
				str += "Iron";
				break;
			case 8:
				str += "Lightning";
				break;
			case 9:
				str += "Moon";
				break;
			case 10:
				str += "Shadow";
				break;
			case 11:
				str += "Shadow";
				break;
			case 12:
				str += "Silver";
				break;
			case 13:
				str += "Sly";
				break;
			case 14:
				str += "Sly";
				break;
			case 15:
				str += "Small";
				break;
			case 16:
				str += "Steel";
				break;
			case 17:
				str += "Stone";
				break;
			case 18:
				str += "Sun";
				break;
			case 19:
				str += "Swift";
				break;
		}
	
		switch (Random(20)) {
			case 0:
				str += "Bones";
				break;
			case 1:
				str += "Caller";
				break;
			case 2:
				str += "Caller";
				break;
			case 3:
				str += "Cloak";
				break;
			case 4:
				str += "Eye";
				break;
			case 5:
				str += "Foot";
				break;
			case 6:
				str += "Fox";
				break;
			case 7:
				str += "Gold";
				break;
			case 8:
				str += "Hand";
				break;
			case 9:
				str += "Hand";
				break;
			case 10:
				str += "Heart";
				break;
			case 11:
				str += "Heart";
				break;
			case 12:
				str += "Leaf";
				break;
			case 13:
				str += (female ? "Lady" : "Man");
				break;
			case 14:
				str += "Skin";
				break;
			case 15:
				str += "Srider";
				break;
			case 16:
				str += "Wanderer";
				break;
			case 17:
				str += "Wanderer";
				break;
			case 18:
				str += "Will";
				break;
			case 19:
				str += "Whisper";
				break;
		}
	}
	
	str = (GetStringUpperCase(GetSubString(str,0,1)) + GetStringLowerCase(GetSubString(str,1,GetStringLength(str))));
	return str;
}

string generate_human_name(int female)
{
	string str = RandomName();

	if (female) {
		switch (Random(6)) {
			case 0:
				str += "a";
				break;
			case 1:
				str += "ie";
				break;
			case 2:
				str += "re";
				break;
			case 3:
				str += "ele";
				break;
			case 4:
				str += "na";
				break;
			case 5:
				str += "ni";
				break;
		}	
	}
	return str;
}

string RandomNameDwarf(int nFemale=0)
{
	return generate_dwarf_name(nFemale);
}

string RandomNameGnome(int nFemale=0,int nLast=0)
{
	return generate_gnome_name(nFemale,nLast);
}

string RandomNameHuman(int nFemale=0)
{
	return generate_human_name(nFemale);
}

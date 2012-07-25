const float delay_mean = 3.0f;
const float delay_var = 0.002f;

#include "acr_tools_i"


void play_sound(object s)
{
	//WriteTimestampedLogEntry("010_Ring: play_sound in "+GetTag(GetArea(s)));
	SoundObjectStop(s);
	SoundObjectPlay(s);
}

void play_sounds(string tag)
{
	object s;
	int i=0;

	//WriteTimestampedLogEntry("010_Ring: play_sounds for "+tag);

	while ((s = GetLocalObject(OBJECT_SELF,tag+"_"+IntToString(i))) != OBJECT_INVALID) {
		play_sound(s);
		++i;
	}
}
	
void main()
{
	string tag,t0,t1;
	int i,time = GetTimeHour();
	object s0,s1;
	float delay;

	//WriteTimestampedLogEntry("010_Ring: "+IntToString(time)+":"+IntToString(GetTimeMinute()));

	// force regular heartbeats
	if (!GetLocalInt(OBJECT_SELF, "init")) {
		SetCustomHeartbeat(OBJECT_SELF, 5000);
		SetLocalInt(OBJECT_SELF, "init", 1);
	}

	if (GetLocalInt(OBJECT_SELF, "time") == time)
		return;
	
	tag = GetTag(OBJECT_SELF);
	SetLocalInt(OBJECT_SELF, "time", time);

	t0 = tag+"0";
	t1 = tag+"1";

	// cache sound objects
	if (!GetLocalInt(OBJECT_SELF, "cached")) {

		i=0;

		while ((s0 = GetObjectByTag(t0,i)) != OBJECT_INVALID) {
			SetLocalObject(OBJECT_SELF,t0+"_"+IntToString(i),s0);
			++i;
		}

		i=0;

		while ((s1 = GetObjectByTag(t1,i)) != OBJECT_INVALID) {
			SetLocalObject(OBJECT_SELF,t1+"_"+IntToString(i),s1);
			++i;
		}
		SetLocalInt(OBJECT_SELF, "cached", 1);
	}
	
	time = time%12;
	
	if (time == 0)
		time = 12;
	
	//WriteTimestampedLogEntry("010_Ring: ring "+ t0);
	//WriteTimestampedLogEntry("010_Ring: ring "+ t1);

	
	for (i=0; i<time; ++i) {
		delay = ACR_RandomNormal(IntToFloat(i)*delay_mean, sqrt(delay_var)); 
		if (i%2)
			DelayCommand(delay, play_sounds(t0));
		else
			DelayCommand(delay, play_sounds(t1));
	}
}


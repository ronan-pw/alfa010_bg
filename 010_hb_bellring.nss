const float delay_mean = 2.5f;
const float delay_var = 0.01f;

#include "acr_tools_i"


void play_sound(object s)
{
	SoundObjectStop(s);
	SoundObjectPlay(s);
}

void main()
{
	string tag;
	int i,time = GetTimeHour();
	object s0,s1;
	float delay;

	if (GetLocalInt(OBJECT_SELF, "time") == time)
		return;
	

	tag = GetTag(OBJECT_SELF);
	SetLocalInt(OBJECT_SELF, "time", time);
	
	s0 = GetNearestObjectByTag(tag+"0");
	s1 = GetNearestObjectByTag(tag+"1");
	
	time = time%12;
	
	if (time == 0)
		time = 12;
	
	
	for (i=0; i<time; ++i) {
	    delay = ACR_RandomNormal(IntToFloat(i)*delay_mean, sqrt(delay_var));

		if (i%2)
			DelayCommand(delay, play_sound(s0));
		else
			DelayCommand(delay, play_sound(s1));
	}
}


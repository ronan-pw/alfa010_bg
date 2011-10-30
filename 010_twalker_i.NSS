const int TWALK_LOWER_BOUND = 1;
const int TWALK_UPPER_BOUND = 10;
const float EPS = 0.01;
const float TWALK_LOC_BUF = 6.0;
const float TWALK_POLL = 3.0;
const float TWALK_TRANS = 1.0;

void start_walk();
void next_step(int step);
void move_to_next();
void check_status(object o);
void port_to_next();
void handle_follow(object o);

void handle_follow(object o)
{
	object f;
	int i;
	
	if (!GetLocalInt(o, "tw_follow_started")) {
			
		SetLocalInt(o, "tw_follow_started",1);
				
		i = 1;
				
		do {			
			f = GetNearestObject(OBJECT_TYPE_CREATURE,o,i++);
			if (GetLocalInt(f,"tw_id") == GetLocalInt(o,"tw_follow")) {
				SetLocalObject(o, "tw_follow_obj", f);
			}
		} while (f != OBJECT_INVALID);
		
		if (GetLocalFloat(o,"tw_distance") < 0.1)
			SetLocalFloat(o,"tw_distance",6.0);
	}
			
	f = GetLocalObject(o, "tw_follow_obj");
			
	if (GetArea(o) != GetArea(f)) {
		ClearAllActions();
		ActionJumpToObject(f);
	}
			
	ActionForceFollowObject(f,GetLocalFloat(o,"tw_distance"));
}

void start_walk()
{
	int next,reverse;
	object o = OBJECT_SELF;
	
	reverse = GetLocalInt(o,"reverse");
	
	if (reverse)
		next = TWALK_LOWER_BOUND;
	else
		next = TWALK_UPPER_BOUND;
		
	next_step(next);
}

void next_step(int step)
{
	object o = OBJECT_SELF,area=GetArea(o),t;
	string tag = GetTag(area);
	
	SetLocalInt(o,"step",step);
	
	// port me out to next area
	if ((step < TWALK_LOWER_BOUND) || (step > TWALK_UPPER_BOUND))
	{
		port_to_next();
		return;
	}
	
	tag = tag + "_";
	
	if (step >= 10)
		tag = tag + IntToString(step);
	else
		tag = tag + "0" + IntToString(step);
		
	t = GetNearestObjectByTag(tag);
	
	// no location here, just flip around
	if (t == OBJECT_INVALID) {
		WriteTimestampedLogEntry("TWALK: Leaving invalid, "+tag);
		SetLocalInt(o,"reverse",1^GetLocalInt(o,"reverse"));
		
		port_to_next();
	}
		
	SetLocalObject(o,"t_target",t);

	move_to_next();
}

void move_to_next()
{
	object o=OBJECT_SELF,t;
	t = GetLocalObject(o,"t_target");
	
	ActionMoveToObject(t);
}

void port_to_next()
{
	object o=OBJECT_SELF, t,area=GetArea(o);
	location l = GetLocation(o);
	
	DeleteLocalLocation(o,"loc");
	t = GetNearestObjectToLocation(OBJECT_TYPE_TRIGGER,l);
	
	ClearAllActions();
	AssignCommand(o,JumpToObject(GetTransitionTarget(t)));
	
	DelayCommand(TWALK_TRANS, start_walk());
}

void check_status(object o)
{
	int step,rev;
	object area,t;
	location l = GetLocation(o),l_prev,l_next;
	float diff;

	
	l_prev = GetLocalLocation(o,"loc");
	SetLocalLocation(o,"loc",l);
	
	diff = GetDistanceBetweenLocations(l,l_prev);
	
	// I'm walkin'
	if (diff > TWALK_LOC_BUF)
		return;
	
	t = GetLocalObject(o,"t_target");
	l_next = GetLocation(t);
	
	diff = GetDistanceBetweenLocations(l,l_next);

	// someone blocked me!
	if (diff > TWALK_LOC_BUF) {
		move_to_next();
		return;
	}
	
	step = GetLocalInt(o,"step");
	rev = GetLocalInt(o,"reverse");
	
	if (rev)
		step++;
	else
		step--;
		
	next_step(step);
}
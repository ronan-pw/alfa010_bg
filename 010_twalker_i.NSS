const int TWALK_LOWER_BOUND = 1;
const int TWALK_UPPER_BOUND = 10;
const float EPS = 0.01;
const float TWALK_LOC_BUF = 6.0;
const float TWALK_POLL = 3.0;
const float TWALK_TRANS = 0.1;

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
	float f_dist;
	
	if (!GetLocalInt(o, "tw_follow_started")) {
			
		SetLocalInt(o, "tw_follow_started",1);
				
		i = 1;
				
		do {			
			f = GetNearestObject(OBJECT_TYPE_CREATURE,o,i++);
			if (GetLocalInt(f,"tw_id") == GetLocalInt(o,"tw_follow")) {
				SetLocalObject(o, "tw_follow_obj", f);
				SetLocalObject(f, "tw_follower_obj", o);
				break;
			}
		} while (f != OBJECT_INVALID);
		
		if (FindSubString(GetTag(o),"wagon") != -1)
			SetLocalInt(o, "tw_wagon",1);
		
		if (GetLocalFloat(o,"tw_distance") < EPS)
			SetLocalFloat(o,"tw_distance", 6.0);
	}

	// If in combat, ignore all this
	if (GetIsInCombat(o))
		return;
			
			
	f = GetLocalObject(o, "tw_follow_obj");
			
	if (GetArea(o) != GetArea(f)) {
		ClearAllActions(TRUE);
		ActionJumpToObject(f);
	}
	
	f_dist = GetLocalFloat(o,"tw_distance")-1.0;
	
	// wagons use follow
	if (GetLocalInt(o, "tw_wagon")) {
		if (GetCurrentAction(o) == ACTION_FOLLOW)
			return;
			
		ActionForceFollowObject(f, f_dist, 1);
		return;
	}


	ClearAllActions(TRUE);
	
	if (!GetDetectMode(o))
		SetActionMode(o,ACTION_MODE_DETECT,1);

	ActionForceMoveToObject(f, FALSE, f_dist);
}

void start_walk()
{
	int next,reverse;
	object o = OBJECT_SELF;
	
	reverse = GetLocalInt(o,"reverse");
	
	next = (reverse ? TWALK_LOWER_BOUND : TWALK_UPPER_BOUND);
		
	next_step(next);
}

void next_step(int step)
{
	object o = OBJECT_SELF,area=GetArea(o),t;
	string tag = GetTag(area);
	
	SetLocalInt(o,"tw_step",step);
	
	// port me out to next area
	if ((step < TWALK_LOWER_BOUND) || (step > TWALK_UPPER_BOUND)) {
		port_to_next();
		return;
	}
	
	tag = tag + "_";
	
	if (step >= 10)
		tag = tag + IntToString(step);
	else
		tag = tag + "0" + IntToString(step);
		
	t = GetNearestObjectByTag(tag);
	SetLocalObject(o,"tw_target",t);
	
	// no location here, just flip around
	if (t == OBJECT_INVALID) {
		WriteTimestampedLogEntry("TWALK: "+GetName(o)+" leaving invalid, "+tag);
		SetLocalInt(o,"reverse",1^GetLocalInt(o,"reverse"));
		
		port_to_next();
		return;
	}
		
	move_to_next();
}

void move_to_next()
{
	object o=OBJECT_SELF,t;
	t = GetLocalObject(o,"tw_target");
	
	ActionMoveToObject(t);
}

void port_to_next()
{
	object o=OBJECT_SELF, t,area=GetArea(o),f;
	location l = GetLocation(o);
	
	DeleteLocalLocation(o,"tw_loc");
	t = GetNearestObjectToLocation(OBJECT_TYPE_TRIGGER,l);
	
	ClearAllActions(TRUE);
	AssignCommand(o,JumpToObject(GetTransitionTarget(t)));

	// move followers too
	f = o;
	while ((f = GetLocalObject(f,"tw_follower_obj")) != OBJECT_INVALID) {
		AssignCommand(f,ClearAllActions(TRUE));
		AssignCommand(f,JumpToObject(GetTransitionTarget(t)));
	}
	
	SetLocalInt(o,"tw_transitioned",1);
}

void check_status(object o)
{
	int step,rev;
	object area,t;
	location l = GetLocation(o),l_prev,l_next;
	float diff;

	// If in combat, ignore all this
	if (GetIsInCombat(o))
		return;

	// just transitioned, start walking
	if (GetLocalInt(o,"tw_transitioned")) {
		DeleteLocalInt(o,"tw_transitioned");
		start_walk();
		return;
	}
	
	l_prev = GetLocalLocation(o,"tw_loc");
	SetLocalLocation(o,"tw_loc",l);
	
	diff = GetDistanceBetweenLocations(l,l_prev);
	
	// I'm walkin'
	if (diff > TWALK_LOC_BUF)
		return;
	
	t = GetLocalObject(o,"tw_target");
	l_next = GetLocation(t);
	
	diff = GetDistanceBetweenLocations(l,l_next);

	// someone blocked me!
	if (diff > TWALK_LOC_BUF) {
		move_to_next();
		return;
	}
	
	step = GetLocalInt(o,"tw_step");
	rev = GetLocalInt(o,"reverse");
	
	rev ? step++ : step--;
		
	next_step(step);
}
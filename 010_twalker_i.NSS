const int TWALK_LOWER_BOUND = 1;
const int TWALK_UPPER_BOUND = 10;
const float eps = 0.01;
const float TWALK_LOC_BUF = 1.0;
const float TWALK_POLL = 3.0;
const float TWALK_TRANS = 2.0;

void start_walk();
void next_step(int step);
void move_to_next();
void check_status(object o);
void port_to_next();


void start_walk()
{
	int next,reverse;
	object o = OBJECT_SELF;
	
	GetLocalInt(o,"reverse");
	
	if (reverse)
		next = TWALK_LOWER_BOUND;
	else
		next = TWALK_UPPER_BOUND;
		
	next_step(next);
}

void next_step(int step)
{
	object o = OBJECT_SELF,area=GetArea(o),t;
	string tag = GetTag(o);
	
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
	SetLocalObject(o,"t_target",t);

	move_to_next();
}

void move_to_next()
{
	object o=OBJECT_SELF,t;
	t = GetLocalObject(o,"t_target");
	
	AssignCommand(o, ActionMoveToObject(t));
}

void port_to_next()
{
	object o=OBJECT_SELF, t;
	location l = GetLocation(o);
	
	DeleteLocalLocation(o,"loc");
	t = GetNearestObjectToLocation(OBJECT_TYPE_TRIGGER,l);
	
	AssignCommand(o, ActionInteractObject(t));
	DelayCommand(TWALK_TRANS, start_walk());
}

void check_status(object o)
{
	int step,rev;
	object area,t;
	location l = GetLocation(o),l_prev,l_next;
	float diff;
	
	//DelayCommand(TWALK_POLL,check_status(o));
	
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
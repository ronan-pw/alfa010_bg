#include "test_var_i"

void main()
{	
	int i,max=1,n,incr=1000;
	float f;
	string s;
	object o = GetEnteringObject();
	
	n = GetLocalInt(o, "TEST_MAX");
	
	if (n==0)
		n=5;
		
	SetLocalInt(o, "TEST_MAX", n);
	SetLocalObject(o, "TEST_OBJ", OBJECT_SELF);

	for (i=0; i < n; ++i)
		max *= 10;
		
	gen(0,incr,incr,max,o);
		
	print(o,"generating w/ max " + IntToString(max));
}
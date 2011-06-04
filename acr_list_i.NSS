object _check_object(object o)
{
	return ((o == OBJECT_INVALID) ? GetModule() : o);
}

int _get_index(string id, object src=OBJECT_INVALID)
{
	src = _check_object(src);
	
	return GetLocalInt(src, id+"_index");
}

void _incr_index(string id, object src=OBJECT_INVALID)
{
	src = _check_object(src);
	
	SetLocalInt(src, id+"_index", GetLocalInt(src, id+"_index")+1);
}

void _incr_count(string id, int n=1, object src=OBJECT_INVALID)
{
	src = _check_object(src);
	
	SetLocalInt(src, id+"_count", GetLocalInt(src, id+"_count")+n);
}

int get_count(string id, object src=OBJECT_INVALID)
{
	src = _check_object(src);
	
	return GetLocalInt(src, id+"_count");
}

int get_next_index(string id, int index, object src=OBJECT_INVALID)
{
	src = _check_object(src);
	
	return GetLocalInt(src, id+"_"+IntToString(index)+"_"+"N");
}

int get_prev_index(string id, int index, object src=OBJECT_INVALID)
{
	src = _check_object(src);
	
	return GetLocalInt(src, id+"_"+IntToString(index)+"_"+"P");
}

object get_element_object(string id, int index, object src=OBJECT_INVALID)
{
	src = _check_object(src);
	
	return GetLocalObject(src, id+"_"+IntToString(index));
}

void set_element_object(string id, int index, object elem, object src=OBJECT_INVALID)
{
	src = _check_object(src);
	
	SetLocalObject(src, id+"_"+IntToString(index), elem);
}

int insert_after_index(string id, int index, object src=OBJECT_INVALID)
{
	int next, new_index;
	
	src = _check_object(src);
	
	next = get_next_index(id,index,src);
	
	_incr_count(id, 1, src);
	_incr_index(id, src);
	
	new_index = _get_index(id, src);
	
	SetLocalInt(src, id+"_"+IntToString(new_index)+"_"+"N", next);
	SetLocalInt(src, id+"_"+IntToString(new_index)+"_"+"P", index);
	
	SetLocalInt(src, id+"_"+IntToString(index)+"_"+"N", new_index);
	SetLocalInt(src, id+"_"+IntToString(next)+"_"+"P", new_index);
	
	return new_index;
}

void remove_at_index(string id, int index, object src=OBJECT_INVALID)
{
	int next, prev;
	
	src = _check_object(src);
	
	next = get_next_index(id,index,src);
	prev = get_prev_index(id,index,src);
	
	_incr_count(id, -1, src);
	
	DeleteLocalObject(src,id+"_"+IntToString(index));
	DeleteLocalInt(src,id+"_"+IntToString(index)+"_"+"N");
	DeleteLocalInt(src,id+"_"+IntToString(index)+"_"+"P");

	SetLocalInt(src, id+"_"+IntToString(prev)+"_"+"N", next);
	SetLocalInt(src, id+"_"+IntToString(next)+"_"+"P", prev);
}

int get_first_index(string id, object src=OBJECT_INVALID)
{
	src = _check_object(src);
	
	return 0;
}

int insert_at_tail(string id, object src=OBJECT_INVALID)
{
	int tail;
	
	src = _check_object(src);
	
	tail = get_prev_index(id, get_first_index(id, src), src);
	
	return insert_after_index(id, tail, src);
}

int remove_at_element_object(string id, object elem, object src=OBJECT_INVALID)
{
	int i,first;
	
	src = _check_object(src);
	
	first = get_first_index(id, src);
	i = first;
	
	do {
		i = get_next_index(id, i, src);
		if (get_element_object(id, i, src) == elem) {
			remove_at_index(id, i, src);
			return 1;
		}
		
	} while (first !=i);
	
	return 0;
}

string list_to_string(string id, object src=OBJECT_INVALID)
{
	int i,first;
	string str;
	
	src = _check_object(src);
	
	first = get_first_index(id, src);
	i = first;
	
	do {
		
		str = str + IntToString(i) + ": " + GetName(get_element_object(id,i)) + ", ";
		i = get_next_index(id, i, src);
		
	} while (first !=i);
	
	return str;
}
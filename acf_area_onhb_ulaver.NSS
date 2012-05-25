#include "acr_area_i"

const int ULAVER_TICKS = 23000;

void main()
{
	object o, store, tmp;
	int ticks = GetLocalInt(OBJECT_SELF, "ulaver_timer");
	location loc;

	ACR_AreaOnHeartbeat();

	if (ticks > 0) {
		SetLocalInt(OBJECT_SELF, "ulaver_timer", ticks-1);
		return;
	}

	SetLocalInt(OBJECT_SELF, "ulaver_timer", ULAVER_TICKS);

	store = GetNearestObject(OBJECT_TYPE_STORE, GetFirstObjectInArea(OBJECT_SELF));

	if (store == OBJECT_INVALID)
		return;

	loc = GetLocation(store);

	for (o = GetFirstItemInInventory(store); o != OBJECT_INVALID; o = GetNextItemInInventory(store)) {
		if (GetTag(o) == "cs_it_dwine1")
			break;
	}


	// create an ulaver item
	if (o == OBJECT_INVALID) {
		o = CreateObject(OBJECT_TYPE_ITEM, "cs_it_dwine1", loc);
		CopyItem(o, store);
	}

	// destroy clone/real
	DestroyObject(o);
}

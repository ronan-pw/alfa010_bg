
void main()
{
	object oPC      = GetItemActivator();
	object oItem    = GetItemActivated();
	object o;

	o = GetLocalObject(oItem, "pet");

	if (GetIsObjectValid(o) && 
		(GetIsInCombat(o) || GetIsInCombat(oPC))) {

		SendMessageToPC(oPC, "Not in combat!");
		return;
	}



	if (GetLocalInt(oItem, "summoned")) {
		if (!GetIsObjectValid(o)) {
			SendMessageToPC(oPC, "You pet is dead.");
			return;
		}

		SetLocalInt(oItem, "summoned", 0);
		DestroyObject(o);

		SendMessageToPC(oPC, "You call your pet away.");
		return;
	}

	string resref = GetLocalString(oItem, "resref");
	string name = GetName(oItem);

	o = CreateObject(OBJECT_TYPE_CREATURE, resref, GetLocation(oPC));

	SetLocalInt(oItem, "summoned", 1);
	SetLocalObject(oItem, "pet", o);

	SetFirstName(o, name);
	SetLastName(o, "");
	ChangeFaction(o, oPC);
	AddHenchman(oPC, o);

	SendMessageToPC(oPC, "You call your pet over.");
}

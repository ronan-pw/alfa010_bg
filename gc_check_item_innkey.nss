

int StartingConditional(string checker)
{

	object otarget = GetObjectByTag("innkey_holder");

	if (GetIsObjectValid(GetItemPossessedBy(otarget,checker)))
		return TRUE;
	return FALSE;
}

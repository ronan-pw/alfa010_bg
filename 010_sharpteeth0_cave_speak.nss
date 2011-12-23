void main()
{
	object o = GetEnteringObject();
	string msg,s = GetDeity(o);
	
	if (	s == "Corellon Larethian" ||
		s == "Angharradh" ||
		s == "Aerdrie Faenya" ||
		s == "Hanali Celanil" ||
		s == "Sehanine Moonbow" ||
		s == "Deep Sashelas" ||
		s == "Labelas Enoreth" ||
		s == "Rillifane Rallathil" ||
		s == "Solonor Thelandira" ||
		s == "Fenmarel Mestarine" ||
		s == "Shevarash" ||
		s == "Eilistraee")
		msg = "The soft cascade of water and warm light offers a feeling of ease in this cavern.";
	else
		msg = "Strangely, you feel rather ill at ease in this cavern.";

	SendMessageToPC(o, msg);
}

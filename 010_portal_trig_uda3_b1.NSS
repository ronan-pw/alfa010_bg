void main()
{
object oBrazier=GetObjectByTag("UDA3_B_BRAZIER");
int iCued=GetLocalInt(oBrazier,"SPEAKSTRING_CUED");
if (iCued==1)
	{
	AssignCommand(oBrazier,SpeakString("A thousand stars shine like gold"));
	DelayCommand(4.0,AssignCommand(oBrazier,SpeakString("But what good is gold to I")));
	DelayCommand(8.0,AssignCommand(oBrazier,SpeakString("Feed me goods to the sum of a ton")));
	DelayCommand(12.0,AssignCommand(oBrazier,SpeakString("Else tarry here to die")));
	DeleteLocalInt(oBrazier,"SPEAKSTRING_CUED");
	}
}
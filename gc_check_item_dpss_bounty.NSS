// gc_check_item
/*
    This script checks to see if the PC has an item in their inventory
        sItem   = The tag name you want to check to see if the PC has
        bCheckParty = TRUE if you want to check the entire party for possession of the item
*/

int StartingConditional(int i)
{

    object oPC = GetPCSpeaker();

    switch (i) {
	// goblin ears
        case 0:
            if (GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(),"it_plot_goblin_bouny"))) return TRUE;
	    break;
    }
    return FALSE;
}

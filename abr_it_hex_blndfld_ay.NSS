void main(){
object oPC = GetItemPossessor(OBJECT_SELF);

//if(GetTag(GetItemInSlot(INVENTORY_SLOT_HEAD,oPC))=="abr_it_hex_blindfold_ay"){
ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectBlindness(), oPC, 50.00);
//}
//else RemoveEffect(oPC, EffectBlindness());


}
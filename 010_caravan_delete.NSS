
#include "010_caravan_i"



int StartingConditional()
{
   object Area = OBJECT_SELF; // The area being created

   // Clean up spawned objects in the area and remove treasure, etc.
   // It is up to you to decide how what to do here.  This example
   // script just looks for any freestanding items or creatures in
   // the area and deletes them.  You're guaranteed that there are
   // no PCs in the area when the on delete script runs.

   object Obj = GetFirstObjectInArea(Area);
   while (Obj != OBJECT_INVALID)
   {
      int Type = GetObjectType(Obj);

      if (Type == OBJECT_TYPE_ITEM)
         DestroyObject(Obj);

      Obj = GetNextObjectInArea(Area);
   }

   // The script can now return TRUE to allow the area to be considered
   // cleaned up (and available for re-use).  Otherwise, the script can
   // return FALSE and the cleanup attempt is dismissed.  If automatic
   // cleanup was enabled, cleanup may run again if the area remains
   // empty, once the cleanup timer elapses next time.

   return TRUE;
}


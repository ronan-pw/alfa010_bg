/*

object NewArea = CreateInstancedAreaFromSource(SourceArea); // make the instanced area
object LastObject = CreateObject(OBJECT_TYPE_PLACEABLE, "sometemplate", somelocation); // find next object id
DestroyObject(LastObject); // delete dummy object
SetTag(NewArea, <tag>); // assign tag to new area
SetLocalInt(NewArea, "LASTOBJECTIDTODELETE", ObjectToInt(LastObject));

*/

//
// Now, to clean the area up, call DeleteArea(Area).
//

const int MAX_DELETIONS_AT_ONCE = 100;

void DeleteAreaFinalize(object Area)
{
 int i = 0;
 object CurObject = GetFirstObjectInArea(Area);

 while (CurObject != OBJECT_INVALID && i++ != MAX_DELETIONS_AT_ONCE) // Delete enumerable objects in the area
 {
  DestroyObject(CurObject);
  CurObject = GetNextObjectInArea(Area);
 }

 if (CurObject != OBJECT_INVALID)
  AssignCommand(GetModule(), DelayCommand(1.0f, DeleteAreaFinalize(Area)));
 else
  DestroyObject(Area); // note, fails if any PC-controlled objects are present, check for that first
}

void DeleteArea(object Area, object NextObjectToDelete = OBJECT_INVALID)
{
 int LastObjectIdToDelete = GetLocalInt(Area, "LASTOBJECTIDTODELETE");
 int i;
 int ObjectId;
 object CurObject;

 if (NextObjectToDelete == OBJECT_INVALID)
   ObjectId = ObjectToInt(Area)+1;
 else
   ObjectId = ObjectToInt(NextObjectToDelete);

 for (; ObjectId != LastObjectIdToDelete; ObjectId += 1) // Delete non-enumerable objects in the area
 {
   CurObject = IntToObject(ObjectId);
   if (i++ == MAX_DELETIONS_AT_ONCE) // break up deletions over time so we don't hang the server for a long time
   {
    AssignCommand(GetModule(), DelayCommand(1.0f, DeleteArea(Area, CurObject)));
    return;
   }

   if (GetArea(CurObject) == Area)
    DestroyObject(IntToObject(ObjectId));
 }

 DeleteAreaFinalize(Area);
}
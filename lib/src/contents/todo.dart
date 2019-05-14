// import 'package:firebase_database/firebase_database.dart';

// class Todo {
//   String key;
//   String todoUid;
//   String todoTitle;
//   String todoNotes;
//   bool todoCompleted;

//   Todo(this.todoUid, this.todoTitle, this.todoNotes, this.todoCompleted);

//   Todo.fromSnapshot(DataSnapshot snapshot) :
//     key = snapshot.key,
//     todoUid = snapshot.value["uid"],
//     todoTitle = snapshot.value["title"],
//     todoNotes = snapshot.value["notes"],
//     todoCompleted = snapshot.value["completed"];

//   toJson() {
//     return {
//       "uid": todoUid,
//       "title": todoTitle,
//       "notes": todoNotes,
//       "completed": todoCompleted,
//     };
//   }
// }
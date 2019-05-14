// import 'package:flutter/material.dart';
// import 'package:chaming/src/services/authentication.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:chaming/src/contents/todo.dart';
// import 'dart:async';

// class Home extends StatefulWidget {
//   Home({Key key, this.auth, this.userId, this.onSignedOut})
//       : super(key: key);

//   final BaseAuth auth;
//   final VoidCallback onSignedOut;
//   final String userId;

//   @override
//   State<StatefulWidget> createState() => new HomeState();
// }

// class HomeState extends State<Home> {
//   List<Todo> _todoList;

//   final FirebaseDatabase _database = FirebaseDatabase.instance;
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
//   final _titleEditingController = TextEditingController();
//   final _notesEditingController = TextEditingController();

//   StreamSubscription<Event> _onTodoAddedSubscription;
//   StreamSubscription<Event> _onTodoChangedSubscription;

//   Query _todoQuery;

//   bool _isEmailVerified = false;

//   @override
//   void initState() {
//     super.initState();

//     _checkEmailVerification();

//     _todoList = new List();
//     _todoQuery = _database
//         .reference()
//         .child("todo")
//         .orderByChild("uid")
//         .equalTo(widget.userId);
//     _onTodoAddedSubscription = _todoQuery.onChildAdded.listen(_onEntryAdded);
//     _onTodoChangedSubscription = _todoQuery.onChildChanged.listen(_onEntryChanged);
//   }

//   void _checkEmailVerification() async {
//     _isEmailVerified = await widget.auth.isEmailVerified();
//     if (!_isEmailVerified) {
//       _showVerifyEmailDialog();
//     }
//   }

//   void _resentVerifyEmail(){
//     widget.auth.sendEmailVerification();
//     _showVerifyEmailSentDialog();
//   }

//   void _showVerifyEmailDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         // return object of type Dialog
//         return AlertDialog(
//           title: new Text("Verify your account"),
//           content: new Text("Please verify account in the link sent to email"),
//           actions: <Widget>[
//             new FlatButton(
//               child: new Text("Resent link"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _resentVerifyEmail();
//               },
//             ),
//             new FlatButton(
//               child: new Text("Dismiss"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showVerifyEmailSentDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         // return object of type Dialog
//         return AlertDialog(
//           title: new Text("Verify your account"),
//           content: new Text("Link to verify account has been sent to your email"),
//           actions: <Widget>[
//             new FlatButton(
//               child: new Text("Dismiss"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _onTodoAddedSubscription.cancel();
//     _onTodoChangedSubscription.cancel();
//     super.dispose();
//   }

//   _onEntryChanged(Event event) {
//     var oldEntry = _todoList.singleWhere((entry) {
//       return entry.key == event.snapshot.key;
//     });

//     setState(() {
//       _todoList[_todoList.indexOf(oldEntry)] = Todo.fromSnapshot(event.snapshot);
//     });
//   }

//   _onEntryAdded(Event event) {
//     setState(() {
//       _todoList.add(Todo.fromSnapshot(event.snapshot));
//     });
//   }

//   _signOut() async {
//     try {
//       await widget.auth.signOut();
//       widget.onSignedOut();
//     } catch (e) {
//       print(e);
//     }
//   }

//   _addNewTodo(String todoTitle, String todoNotes) async {
//     if (todoTitle.length > 0) {

//       Todo todo = new Todo(widget.userId, todoTitle.toString(), todoNotes.toString(), false);
//       _database.reference().child("todo").push().set(todo.toJson());
//     }
//   }

//   _updateTodo(Todo todo){
//     //Toggle completed
//     todo.todoCompleted = !todo.todoCompleted;
//     if (todo != null) {
//       _database.reference().child("todo").child(todo.key).set(todo.toJson());
//     }
//   }

//   _deleteTodo(String todoId, int index) {
//     _database.reference().child("todo").child(todoId).remove().then((_) {
//       print("Delete $todoId successful");
//       setState(() {
//         _todoList.removeAt(index);
//       });
//     });
//   }

//   _showDialog(BuildContext context) async {
//     _titleEditingController.clear();
//     _notesEditingController.clear();
//     await showDialog<String>(
//         context: context,
//       builder: (BuildContext context) {
//           return AlertDialog(
//             content: new Column(
//               children: <Widget>[
//                 new Expanded(
//                   child: ListView(
//                     scrollDirection: Axis.vertical,
//                     children: <Widget>[
//                       Center(
//                         child: new Text(
//                           'Add your todo'
//                         )
//                       ),
//                       new Padding(
//                         padding: const EdgeInsets.only(bottom: 20.0),
//                       ),
//                       new TextField(
//                         controller: _titleEditingController,
//                         autofocus: true,
//                         decoration: new InputDecoration(
//                           labelText: 'title todo',
//                         )
//                       ),
//                       new TextField(
//                         controller: _notesEditingController,
//                         maxLines: 5,
//                         decoration: new InputDecoration(
//                           labelText: 'notes todo',
//                         )
//                       ),
//                     ],
//                   )
//                 )
//               ]
//             ),
//             actions: <Widget>[
//               new FlatButton(
//                   child: Text(
//                     'Cancel',
//                     style: TextStyle(
//                       color: Colors.amber[800]
//                     )
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   }),
//               new FlatButton(
//                   child: Text('Save'),
//                   onPressed: () {
//                     _addNewTodo(
//                       _titleEditingController.text.toString(),
//                       _notesEditingController.text.toString()
//                     );
//                     Navigator.pop(context);
//                   })
//             ],
//           );
//       }
//     );
//   }

//   Widget _showTodoList() {
//     if (_todoList.length > 0) {
//       return ListView.builder(
//           shrinkWrap: true,
//           itemCount: _todoList.length,
//           itemBuilder: (BuildContext context, int index) {
//             String todoId = _todoList[index].key;
//             String todoTitle = _todoList[index].todoTitle;
//             bool todoCompleted = _todoList[index].todoCompleted;
            
//             return Dismissible(
//               key: Key(todoId),
//               background: Container(
//                 color: Colors.red,
//                 child: Center(
//                   child: Text(
//                     'Delete',
//                     style: TextStyle(
//                       color: Colors.white
//                     ),
//                   ),
//                 ),
//               ),
//               onDismissed: (direction) async {
//                 _deleteTodo(todoId, index);
//               },
//               child: Card(
//                 child: ListTile(
//                   title: Text(
//                     todoTitle,
//                     style: TextStyle(fontSize: 20.0),
//                   ),
//                   trailing: IconButton(
//                     icon: (todoCompleted)
//                       ? Icon(
//                           Icons.done_outline,
//                           color: Colors.green,
//                           size: 20.0,
//                         )
//                       : Icon(
//                           Icons.done, 
//                           color: Colors.grey, 
//                           size: 20.0
//                     ),
//                     onPressed: () {
//                       _updateTodo(_todoList[index]);
//                     }
//                   )
//                 ),
//               )
//             );
//           });
//     } else {
//       return Center(
//         child: Text(
//           "no list to do...",
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 16.0
//           )
//         )
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         appBar: new AppBar(
//           title: new Text('My List'),
//           actions: <Widget>[
//             FlatButton(
//                 child: Text(
//                   'Logout',
//                   style: TextStyle(
//                     fontSize: 16.0, 
//                     color: Colors.white
//                   )
//                 ),
//                 onPressed: _signOut
//             )
//           ]
//         ),
//         body: _showTodoList(),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             _showDialog(context);
//           },
//           tooltip: 'Increment',
//           child: Icon(Icons.add),
//         )
//     );
//   }
// }
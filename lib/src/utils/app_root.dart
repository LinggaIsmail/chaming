// import 'package:flutter/material.dart';
// import 'package:chaming/src/screens/sign.dart';
// import 'package:chaming/src/services/authentication.dart';
// import 'package:chaming/src/screens/home.dart';

// class Root extends StatefulWidget {
//   Root({this.auth});

//   final BaseAuth auth;

//   @override
//   State<StatefulWidget> createState() => new RootState();
// }

// enum AuthStatus {
//   NOT_DETERMINED,
//   NOT_SIGN_IN,
//   SIGN_IN,
// }

// class RootState extends State<Root> {
//   AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
//   String _userId = "";

//   @override
//   void initState() {
//     super.initState();
//     widget.auth.getCurrentUser().then((user) {
//       setState(() {
//         if (user != null) {
//           _userId = user?.uid;
//         }
//         authStatus =
//             user?.uid == null ? AuthStatus.NOT_SIGN_IN : AuthStatus.SIGN_IN;
//       });
//     });
//   }

//   void _onSignIn() {
//     widget.auth.getCurrentUser().then((user){
//       setState(() {
//         _userId = user.uid.toString();
//       });
//     });
//     setState(() {
//       authStatus = AuthStatus.SIGN_IN;

//     });
//   }

//   void _onSignedOut() {
//     setState(() {
//       authStatus = AuthStatus.NOT_SIGN_IN;
//       _userId = "";
//     });
//   }

//   Widget _buildWaitingScreen() {
//     return Scaffold(
//       body: Container(
//         alignment: Alignment.center,
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     switch (authStatus) {
//       case AuthStatus.NOT_DETERMINED:
//         return _buildWaitingScreen();
//         break;
//       case AuthStatus.NOT_SIGN_IN:
//         return new Sign(
//           auth: widget.auth,
//           onSignedIn: _onSignIn,
//         );
//         break;
//       case AuthStatus.SIGN_IN:
//         if (_userId.length > 0 && _userId != null) {
//           return new Home(
//             userId: _userId,
//             auth: widget.auth,
//             onSignedOut: _onSignedOut,
//           );
//         } else return _buildWaitingScreen();
//         break;
//       default:
//         return _buildWaitingScreen();
//     }
//   }
// }
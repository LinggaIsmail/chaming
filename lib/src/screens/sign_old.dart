// import 'package:flutter/material.dart';
// import 'package:chaming/src/services/authentication.dart';

// class Sign extends StatefulWidget {
//   Sign({this.auth, this.onSignedIn});

//   final BaseAuth auth;
//   final VoidCallback onSignedIn;

//   @override
//   State<StatefulWidget> createState() => new SignState();
// }

// enum SignMode { SIGNIN, SIGNUP }

// class SignState extends State<Sign> {
//   final _formKey = new GlobalKey<FormState>();

//   String _email;
//   String _password;
//   String _errorMessage;

//   // Initial form is signin form
//   SignMode _signMode = SignMode.SIGNIN;
//   bool _isIos;
//   bool _isLoading;

//   // Check if form is valid before perform signin or signup
//   bool _validateAndSave() {
//     final form = _formKey.currentState;
//     if (form.validate()) {
//       form.save();
//       return true;
//     }
//     return false;
//   }

//   // Perform signin or signup
//   void _validateAndSubmit() async {
//     setState(() {
//       _errorMessage = "";
//       _isLoading = true;
//     });
//     if (_validateAndSave()) {
//       String userId = "";
//       try {
//         if (_signMode == SignMode.SIGNIN) {
//           userId = await widget.auth.signIn(_email, _password);
//           print('Signed in: $userId');
//         } else {
//           userId = await widget.auth.signUp(_email, _password);
//           widget.auth.sendEmailVerification();
//           _showVerifyEmailSentDialog();
//           print('Signed up user: $userId');
//         }
//         setState(() {
//           _isLoading = false;
//         });

//         if (userId.length > 0 && userId != null && _signMode == SignMode.SIGNIN) {
//           widget.onSignedIn();
//         }

//       } catch (e) {
//         print('Error: $e');
//         setState(() {
//           _isLoading = false;
//           if (_isIos) {
//             _errorMessage = e.details;
//           } else
//             _errorMessage = e.message;
//         });
//       }
//     } else {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }


//   @override
//   void initState() {
//     _errorMessage = "";
//     _isLoading = false;
//     super.initState();
//   }

//   void _changeFormToSignUp() {
//     _formKey.currentState.reset();
//     _errorMessage = "";
//     _isLoading = false;
//     setState(() {
//       _signMode = SignMode.SIGNUP;
//     });
//   }

//   void _changeFormToSignIn() {
//     _formKey.currentState.reset();
//     _errorMessage = "";
//     _isLoading = false;
//     setState(() {
//       _signMode = SignMode.SIGNIN;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     _isIos = Theme.of(context).platform == TargetPlatform.iOS;
//     return new Scaffold(
//         appBar: new AppBar(
//           title: _signMode == SignMode.SIGNIN
//             ? new Text('Sign In')
//             : new Text('Sign Up'),
//         ),
//         body: Stack(
//           children: <Widget>[
//             _showBody(),
//             _showCircularProgress(),
//           ],
//         ));
//   }

//   Widget _showCircularProgress(){
//     if (_isLoading) {
//       return Center(child: CircularProgressIndicator());
//     } return Container(height: 0.0, width: 0.0,);

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
//                 _changeFormToSignIn();
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _showBody(){
//     return new Container(
//         padding: EdgeInsets.all(16.0),
//         child: new Form(
//           key: _formKey,
//           child: new ListView(
//             shrinkWrap: true,
//             children: <Widget>[
//               _showLogo(),
//               _showEmailInput(),
//               _showPasswordInput(),
//               _showPrimaryButton(),
//               _showSecondaryButton(),
//               _showErrorMessage(),
//             ],
//           ),
//         ));
//   }

//   Widget _showErrorMessage() {
//     if (_errorMessage.length > 0 && _errorMessage != null) {
//       return Padding(
//         padding: const EdgeInsets.only(top: 20.0),
//         child: new Text(
//           _errorMessage,
//           style: TextStyle(
//               fontSize: 13.0,
//               color: Colors.red,
//               height: 1.0,
//               fontWeight: FontWeight.w300),
//         ),
//       );
//     } else {
//       return new Container(
//         height: 0.0,
//       );
//     }
//   }

//   Widget _showLogo() {
//     return new Hero(
//       tag: 'hero',
//       child: Padding(
//         padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
//         child: CircleAvatar(
//           backgroundColor: Colors.transparent,
//           radius: 48.0,
//           child: Icon(
//             Icons.layers,
//             size: 100.0,
//           )
//         ),
//       ),
//     );
//   }

//   Widget _showEmailInput() {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
//       child: new TextFormField(
//         maxLines: 1,
//         keyboardType: TextInputType.emailAddress,
//         autofocus: false,
//         decoration: new InputDecoration(
//             hintText: 'Email',
//             icon: new Icon(
//               Icons.mail,
//               color: Colors.grey,
//             )),
//         validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
//         onSaved: (value) => _email = value,
//       ),
//     );
//   }

//   Widget _showPasswordInput() {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
//       child: new TextFormField(
//         maxLines: 1,
//         obscureText: true,
//         autofocus: false,
//         decoration: new InputDecoration(
//             hintText: 'Password',
//             icon: new Icon(
//               Icons.lock,
//               color: Colors.grey,
//             )),
//         validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
//         onSaved: (value) => _password = value,
//       ),
//     );
//   }

//   Widget _showSecondaryButton() {
//     return new FlatButton(
//       child: _signMode == SignMode.SIGNIN
//           ? new Text('Create an account',
//               style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300))
//           : new Text('Have an account? Sign in',
//               style:
//                   new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
//       onPressed: _signMode == SignMode.SIGNIN
//           ? _changeFormToSignUp
//           : _changeFormToSignIn,
//     );
//   }

//   Widget _showPrimaryButton() {
//     return new Padding(
//         padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
//         child: SizedBox(
//           height: 40.0,
//           child: new RaisedButton(
//             elevation: 5.0,
//             shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
//             color: Colors.blue,
//             child: _signMode == SignMode.SIGNIN
//                 ? new Text('Sign In',
//                     style: new TextStyle(fontSize: 20.0, color: Colors.white))
//                 : new Text('Create account',
//                     style: new TextStyle(fontSize: 20.0, color: Colors.white)),
//             onPressed: _validateAndSubmit,
//           ),
//         ));
//   }
// }
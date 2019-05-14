import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:chaming/src/utils/firebase_listenter.dart';

class FirebaseEmail {
  static final FirebaseEmail _instance =
      new FirebaseEmail.internal();

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseAuthListener _view;

  FirebaseEmail.internal();

  factory FirebaseEmail() {
    return _instance;
  }

  setScreenListener(FirebaseAuthListener view) {
    _view = view;
  }

  Future<FirebaseUser> signIn(String email, String password) async {

    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user;
  }

  Future<String> createUser(String email, String password) async {

    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return user.uid;
  }

  Future<String> currentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user != null ? user.uid : null;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  void onLoginUserVerified(FirebaseUser currentUser) {
    _view.onLoginUserVerified(currentUser);
  }

  onTokenError(String string) {
    _view.onError(string);
  }

}
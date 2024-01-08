import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// create a class to handle all methods about Auth and manage Authentication

class AuthService extends ChangeNotifier { // this ChangeNotifier is thanks to Provider:

  // instance of auth, to know, if we're logged in or not
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign in user method
  // user WILL sign in, so it has to be Future
  // required info are email and password
  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    // try to sign in first, then if couldn't sign up
    try {
      // sign in
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email,
          password: password,
      );

      // add a new document for the user in collection (users), if it does not already exist!
      _firestore.collection('users').doc(userCredential.user!.uid).set({ // here has created a collection which is called "users" and under that
        // there are a documentation with two parameters: User ID (uid) and User E-Mail (email)
        'uid' : userCredential.user!.uid,
        'email' : userCredential.user!.email,
      }, SetOptions(merge: true)); // thank to merge we can avoid the duplicate

      // one we sign in, we should also return the user
      return userCredential;
    }
    // catch any errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // create a new user
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // after creating the user, create a new document for the user in the users collection
      _firestore.collection('users').doc(userCredential.user!.uid).set({ // here has created a collection which is called "users" and under that
        // there are a documentation with two parameters: User ID (uid) and User E-Mail (email)
        'uid' : userCredential.user!.uid,
        'email' : userCredential.user!.email,
      });
      

      // once we sign up, we should also return the user
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // sign user out method
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}

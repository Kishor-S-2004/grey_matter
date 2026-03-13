import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationRepositories {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthenticationRepositories({FirebaseAuth? auth, FirebaseFirestore? fireStore})
    : _auth = auth ?? FirebaseAuth.instance,
      _firestore = fireStore ?? FirebaseFirestore.instance;

  Future<void> registerUser({
    required String userName,
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await _firestore.collection('Users').doc(userCredential.user?.uid).set({
      'uid': userCredential.user?.uid,
      'Username': userName,
      'Email': email,
      'Created At': FieldValue.serverTimestamp(),
    });
  }

  Future<void> loginUser({required String email,required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    final doc = await _firestore.collection('Users').doc(uid).get();
    return doc.data();
  }

  Future<void> logout()async{
    await _auth.signOut();
  }
}

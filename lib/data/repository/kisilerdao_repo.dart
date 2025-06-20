import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:itshop/data/entity/kisiler.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUpUser(Kullanicilar kullanici, String password) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: kullanici.email,
      password: password,
    );
    await _firestore
        .collection("kullanicilar")
        .doc(userCredential.user!.uid)
        .set({...kullanici.toJson(), "rol": "kullanici"});
  }
  Future<bool> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }
  User? getCurrentUser() {
    return _auth.currentUser;
  }
  Future<void> signOut() async {
    await _auth.signOut();
  }
  Future <String?> getuserRole() async {
    final user = _auth.currentUser;
    if(user!=null)
      {
        final doc = await _firestore.collection("kullanicilar").doc(user.uid).get();
        return doc.data()?["rol"];
      }
    return null;
  }

  Future <bool> getUserEmail( String email) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('kullanicilar') // ya da koleksiyon adın neyse
        .where('email', isEqualTo: email)
        .get();

      return snapshot.docs.isNotEmpty;


  }










}

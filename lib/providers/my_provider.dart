import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_c9_friday/models/user_model.dart';
import 'package:todo_c9_friday/shared/network/firebase_functions.dart';

class MyProvider extends ChangeNotifier {
  UserModel? userModel;
  User? firebaseUser;

  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initMyUser();
    }
  }

  void initMyUser() async {
    firebaseUser=FirebaseAuth.instance.currentUser;
    userModel = await FirebaseFunctions.readUser(
        firebaseUser!.uid);
    notifyListeners();
  }
}

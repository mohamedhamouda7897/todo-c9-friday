import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_c9_friday/models/task_model.dart';
import 'package:todo_c9_friday/models/user_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    );
  }

  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    );
  }

  static Future<void> addTask(TaskModel taskModel) {
    var collection = getTasksCollection();
    var docRef = collection.doc();
    taskModel.id = docRef.id;
    return docRef.set(taskModel);
  }

  static void addUserToFirestore(UserModel userModel) {
    var collection = getUsersCollection();
    var docRef = collection.doc(userModel.id);
    docRef.set(userModel);
  }

  static Stream<QuerySnapshot<TaskModel>> getTasksFromFirestore(DateTime date) {
    return getTasksCollection()
        .orderBy("date", descending: false)
        .orderBy("title", descending: false)
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("date",
            isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(String id) {
    return getTasksCollection().doc(id).delete();
  }

  static Future<void> updateTask(TaskModel task) {
    return getTasksCollection().doc(task.id).update(task.toJson());
  }

  static createUser(int age, String name, String email, String password,
      Function onSuccess, Function onError) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((cred) {
        UserModel userModel =
            UserModel(id: cred.user!.uid, email: email, name: name, age: age);
        addUserToFirestore(userModel);
        onSuccess();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);
        print('The account already exists for that email.');
      }
    } catch (e) {
      onError(e.toString());
      print(e);
    }
  }

  static void loginUser(String email, String password, Function onSuccess,
      Function onError) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        onSuccess();
      });
    } on FirebaseAuthException catch (e) {
      onError("wrong mail or password");
    }
  }

  static Future<UserModel?> readUser(String id) async {
    DocumentSnapshot<UserModel> userDoc =
        await getUsersCollection().doc(id).get();
    return userDoc.data();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/auth/signup/data/model/user_model.dart';

class FirebaseFunctions {
  // static CollectionReference<TaskModel> getTasksCollection() {
  //   return FirebaseFirestore.instance
  //       .collection("Tasks")
  //       .withConverter<TaskModel>(
  //     fromFirestore: (snapshot, _) {
  //       return TaskModel.fromJson(snapshot.data()!);
  //     },
  //     toFirestore: (value, _) {
  //       return value.toJson();
  //     },
  //   );
  // }
  //
  // static Future<void> addTask(TaskModel task) {
  //   var collection = getTasksCollection();
  //   var docRef = collection.doc();
  //   task.id = docRef.id;
  //   return docRef.set(task);
  // }
  //
  // static Stream<QuerySnapshot<TaskModel>> getTask(DateTime date) {
  //   return getTasksCollection()
  //       .where("userId",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //       .where("date",
  //       isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
  //       .orderBy("title")
  //       .snapshots();
  // }
  //
  // static Future<void> daleteTask(String id) {
  //   return getTasksCollection().doc(id).delete();
  // }
  //
  // static Future<void> updateTask(String id, TaskModel task) {
  //   return getTasksCollection().doc(id).update(task.toJson());
  // }

  static creatAccount(
      {required String email,
        required String password,
        required String userName,
        required String phone,
        required Function onSuccess,
        required Function onError}) async {
    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      credential.user!.sendEmailVerification();
      UserModel usermodel=UserModel(id: credential.user!.uid, email: email, userName: userName,phone: phone);
      addUser(usermodel);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);
        print('The account already exists for that email.');
      }
      onError(e.message);
    } catch (e) {
      print(e);
      onError(e.toString());
    }
  }

   login(String email, String password, Function onSuccess,
      Function onError) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // if (credential.user!.emailVerified) {
      onSuccess();
      // }
      // else {onError("please verify your account");}
    } on FirebaseAuthException catch (e) {
      onError(e.code);
    }
  }

  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (user, _) {
        return user.toJson();
      },
    );
  }
  static Future<void> addUser(UserModel user) {
    var collection = getUsersCollection();
    var docRef = collection.doc(user.id);
    return docRef.set(user);
  }

  static Future<UserModel?> readUser() async {
    String id = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot<UserModel> documentSnapshot =
    await getUsersCollection().doc(id).get();
    return documentSnapshot.data();
  }

  static void logOut() async{
    await FirebaseAuth.instance.signOut();
  }
}
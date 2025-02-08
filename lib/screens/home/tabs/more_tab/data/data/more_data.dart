import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../auth/signup/data/model/user_model.dart';

class MoreData{
  CollectionReference<UserModel> getUsersCollection() {
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
  Future<UserModel?> readUser() async {
    String id = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot<UserModel> documentSnapshot =
    await getUsersCollection().doc(id).get();
    return documentSnapshot.data();
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
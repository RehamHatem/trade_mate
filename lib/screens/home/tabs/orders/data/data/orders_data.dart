import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../../utils/failures.dart';
import '../../../bill/data/model/bill_model.dart';

class OrdersData{
  CollectionReference<BillModel> getBillsCollection() {
    return FirebaseFirestore.instance
        .collection("Bills")
        .withConverter<BillModel>(
      fromFirestore: (snapshot, _) {
        return BillModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

  Stream<Either<Failures, QuerySnapshot<BillModel>>> getBills() {
    try {
      final customersStream = FirebaseFirestore.instance
          .collection("Bills")
          .withConverter<BillModel>(
        fromFirestore: (snapshot, _) => BillModel.fromJson(snapshot.data()!),
        toFirestore: (bill, _) => bill.toJson(),
      )
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .orderBy("date",descending: true)
          .snapshots();
      return customersStream.map<Either<Failures, QuerySnapshot<BillModel>>>(
            (snapshot) => right(snapshot),
      ).handleError(
            (error) {
          return left(Failures(errorMsg: error.toString()));
        },
      );
    } catch (e) {
      return Stream.value(left(Failures(errorMsg: e.toString())));
    }
  }

  Future<void> deleteBill(String id) {

    try {
      print("Bill deleted successfully!");
      return getBillsCollection().doc(id).delete();

    } catch (e) {
      print("Error deleting bill: $e");
      throw Exception("Failed to update bill: ${e.toString()}");
    }


  }

  Future<void> updateBill(String id, BillModel bill) async {
    try {
      await getBillsCollection().doc(id).update(bill.toJson());
      print("bill updated successfully!");
    } catch (e) {
      print("Error updating bill: $e");
      throw Exception("Failed to update bill: ${e.toString()}");
    }
  }
}
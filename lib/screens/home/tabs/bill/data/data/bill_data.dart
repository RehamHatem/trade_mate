import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../../utils/failures.dart';
import '../../../suppliers/data/model/supplier_model.dart';
import '../model/bill_model.dart';

class BillData{
  Future<void> addBill(BillModel bill) async{
    var collection = getBillsCollection();
    var docRef = collection.doc();
    bill.id = docRef.id;
    print("Generated Bill ID: ${bill.id}");
    return await docRef.set(bill);
  }
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




}
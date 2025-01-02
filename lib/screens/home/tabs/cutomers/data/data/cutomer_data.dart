import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/data/model/supplier_model.dart';

import '../../../../../../utils/failures.dart';

class CustomerData {

  CollectionReference<SupplierModel> getCustomersCollection() {
    return FirebaseFirestore.instance
        .collection("Customers")
        .withConverter<SupplierModel>(
      fromFirestore: (snapshot, _) {
        return SupplierModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

  Stream<Either<Failures, QuerySnapshot<SupplierModel>>> getCustomers() {
    try {
      final customersStream = FirebaseFirestore.instance
          .collection("Customers")
          .withConverter<SupplierModel>(
        fromFirestore: (snapshot, _) => SupplierModel.fromJson(snapshot.data()!),
        toFirestore: (customer, _) => customer.toJson(),
      )
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .orderBy("date")
          .snapshots();
      return customersStream.map<Either<Failures, QuerySnapshot<SupplierModel>>>(
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
  Future<void> addCustomer(SupplierModel customer) {
    var collection = getCustomersCollection();
    var docRef = collection.doc();
    customer.id = docRef.id;
    return docRef.set(customer);
  }
    Future<void> deleteCustomer(String id) {

    try {
      print("Customer deleted successfully!");
      return getCustomersCollection().doc(id).delete();

    } catch (e) {
      print("Error deleting Customer: $e");
      throw Exception("Failed to update Customer: ${e.toString()}");
    }


  }

  Future<void> updateCustomer(String id, SupplierModel customer) async {
    try {
      await getCustomersCollection().doc(id).update(customer.toJson());
      print("Customer updated successfully!");
    } catch (e) {
      print("Error updating Customer: $e");
      throw Exception("Failed to update Customer: ${e.toString()}");
    }
  }


}
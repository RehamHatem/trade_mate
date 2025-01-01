import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/data/model/supplier_model.dart';

import '../../../../../../utils/failures.dart';
import '../../../../../../utils/shared_preference.dart';

class SupplierData {

  CollectionReference<SupplierModel> getProductsCollection() {
    return FirebaseFirestore.instance
        .collection("Suppliers")
        .withConverter<SupplierModel>(
      fromFirestore: (snapshot, _) {
        return SupplierModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

  Stream<Either<Failures, QuerySnapshot<SupplierModel>>> getSuppliers() {
    try {
      final productsStream = FirebaseFirestore.instance
          .collection("Suppliers")
          .withConverter<SupplierModel>(
        fromFirestore: (snapshot, _) => SupplierModel.fromJson(snapshot.data()!),
        toFirestore: (product, _) => product.toJson(),
      )
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .orderBy("date")
          .snapshots();
      return productsStream.map<Either<Failures, QuerySnapshot<SupplierModel>>>(
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
  Future<void> addSupplier(SupplierModel supplier) {
    var collection = getProductsCollection();
    var docRef = collection.doc();
    supplier.id = docRef.id;
    return docRef.set(supplier);
  }
    Future<void> deleteSupplier(String id) {

    try {
      print("Supplier deleted successfully!");
      return getProductsCollection().doc(id).delete();

    } catch (e) {
      print("Error deleting Supplier: $e");
      throw Exception("Failed to update Supplier: ${e.toString()}");
    }


  }

  Future<void> updateSupplier(String id, SupplierModel product) async {
    try {
      await getProductsCollection().doc(id).update(product.toJson());
      print("Supplier updated successfully!");
    } catch (e) {
      print("Error updating Supplier: $e");
      throw Exception("Failed to update Supplier: ${e.toString()}");
    }
  }




  // static const String boxName = 'suppliers';
  // Box? box;
  // final StreamController<List<SupplierModel>> supplierStreamController =
  // StreamController.broadcast();
  //
  // Future<Box> getBox() async {
  //   box ??= await Hive.openBox(boxName);
  //   return box!;
  // }
  //
  // void addSupplier(SupplierModel supplier) async {
  //   final box = await getBox();
  //   List<dynamic> suppliers = (box.get('suppliers') as List<dynamic>?) ?? [];
  //   suppliers.add(supplier.toJson());
  //   await box.put('suppliers', suppliers);
  //
  // }
  //
  // Future<List<SupplierModel>> getSuppliers() async {
  //   try {
  //     var box = await getBox();
  //     final suppliersData = box.get('suppliers', defaultValue: []);
  //     await SharedPreference.init();
  //     var user=SharedPreference.getData(key: 'email' );
  //
  //     if (suppliersData is List<dynamic>) {
  //       return suppliersData
  //           .whereType<Map>().where((supplier) => supplier['id'] == user)
  //           .map((json) {
  //         try {
  //
  //           final correctedJson = Map<String, dynamic>.from(json);
  //           return SupplierModel.fromJson(correctedJson);
  //         } catch (e) {
  //           print("Error parsing supplier data: $e");
  //           return null;
  //         }
  //       })
  //           .whereType<SupplierModel>()
  //           .toList();
  //
  //     }
  //     return [];
  //   } catch (e, stackTrace) {
  //     print("Error accessing Hive: $e\n$stackTrace");
  //     throw Exception("Failed to fetch suppliers: $e");
  //   }
  //
  //
  // }
  // void removeSupplier(String index) async{
  //   final box = await getBox();
  //   return box.delete(index);
  // }


}
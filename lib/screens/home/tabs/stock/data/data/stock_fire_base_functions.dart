import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trade_mate/utils/failures.dart';

import '../../../add_product/data/model/product_model.dart';

class StockFireBaseFunctions{
 CollectionReference<ProductModel> getProductsCollection() {
    return FirebaseFirestore.instance
        .collection("Products")
        .withConverter<ProductModel>(
      fromFirestore: (snapshot, _) {
        return ProductModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

 Stream<Either<Failures, QuerySnapshot<ProductModel>>> getProducts() {
   try {
     final productsStream = FirebaseFirestore.instance
         .collection("Products")
         .withConverter<ProductModel>(
       fromFirestore: (snapshot, _) => ProductModel.fromJson(snapshot.data()!),
       toFirestore: (product, _) => product.toJson(),
     )
         .where("userId", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
         .orderBy("date")
         .snapshots();
     return productsStream.map<Either<Failures, QuerySnapshot<ProductModel>>>(
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
 Future<void> daleteProduct(String id) {
  return getProductsCollection().doc(id).delete();
}

 Future<void> updateProduct(String id, ProductModel product) async {
   try {
     await getProductsCollection().doc(id).update(product.toJson());
     print("Product updated successfully!");
   } catch (e) {
     print("Error updating product: $e");
     throw Exception("Failed to update product: ${e.toString()}");
   }
 }

}
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

}
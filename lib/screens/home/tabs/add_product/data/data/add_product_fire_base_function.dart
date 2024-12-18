import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/product_model.dart';

class AddProductFireBaseFunction{
  static CollectionReference<ProductModel> getProductsCollection() {
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

   Future<void> addProduct(ProductModel product) {
    var collection = getProductsCollection();
    var docRef = collection.doc();
    product.id = docRef.id;
    return docRef.set(product);
  }


}
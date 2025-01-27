import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trade_mate/screens/home/tabs/categories/data/model/category_model.dart';

import '../../../../../../utils/failures.dart';

class CategoryData{
  CollectionReference<CategoryModel> getCategoriesCollection() {
    return FirebaseFirestore.instance
        .collection("Categories")
        .withConverter<CategoryModel>(
      fromFirestore: (snapshot, _) {
        return CategoryModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

  Stream<Either<Failures, QuerySnapshot<CategoryModel>>> getCategories() {
    try {
      final productsStream = FirebaseFirestore.instance
          .collection("Categories")
          .withConverter<CategoryModel>(
        fromFirestore: (snapshot, _) => CategoryModel.fromJson(snapshot.data()!),
        toFirestore: (category, _) => category.toJson(),
      )
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .orderBy("date")
          .snapshots();
      return productsStream.map<Either<Failures, QuerySnapshot<CategoryModel>>>(
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
  Future<void> addCategory(CategoryModel category) {
    var collection = getCategoriesCollection();
    var docRef = collection.doc();
    category.id = docRef.id;
    return docRef.set(category);
  }
  Future<void> deleteCategory(String id) {

    try {
      print("category deleted successfully!");
      return getCategoriesCollection().doc(id).delete();

    } catch (e) {
      print("Error deleting category: $e");
      throw Exception("Failed to delete category: ${e.toString()}");
    }


  }

  Future<void> updateCategory(String id, CategoryModel category) async {
    try {
      await getCategoriesCollection().doc(id).update(category.toJson());
      print("category updated successfully!");
    } catch (e) {
      print("Error updating category: $e");
      throw Exception("Failed to update category: ${e.toString()}");
    }
  }
}
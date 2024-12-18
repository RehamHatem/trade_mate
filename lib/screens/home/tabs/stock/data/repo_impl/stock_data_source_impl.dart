import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/home/tabs/stock/data/data/stock_fire_base_functions.dart';
import 'package:trade_mate/screens/home/tabs/stock/domain/repo/stock_data_source.dart';
import 'package:trade_mate/utils/failures.dart';

import '../../../add_product/data/model/product_model.dart';
import '../../../add_product/domain/entity/product_entity.dart';

class StockDataSourceImpl implements StockDataSource{
  StockFireBaseFunctions stockFireBaseFunctions;
  StockDataSourceImpl({required this.stockFireBaseFunctions});

  @override
  Stream<Either<Failures, List<ProductEntity>>> getProducts() {
    return stockFireBaseFunctions.getProducts().map((either) {
      return either.fold(
            (failure) => left(failure),
            (snapshot) {
          try {
            // Convert Firestore ProductModel to ProductEntity
            final entityList = snapshot.docs.map((doc) {
              final model = doc.data();
              return ProductEntity(
                id: doc.id,
                name: model.name,
                notes: model.notes,
                category: model.category,
                supplier: model.supplier,
                quantity: model.quantity,
                price: model.price,
                total: model.total,
                date: model.date,
                userId: model.userId,
              );
            }).toList();
print(entityList);
            return right<Failures, List<ProductEntity>>(entityList);
          } catch (e) {
            return left<Failures, List<ProductEntity>>(Failures(errorMsg: e.toString()));
          }
        },
      );
    });
  }

  @override
  Future<void> deleteProduct(String id) {
    return stockFireBaseFunctions.daleteTask(id);
  }


}
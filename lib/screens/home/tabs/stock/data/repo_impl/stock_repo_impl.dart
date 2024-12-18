import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/home/tabs/add_product/data/model/product_model.dart';
import 'package:trade_mate/screens/home/tabs/stock/domain/repo/stock_data_source.dart';
import 'package:trade_mate/screens/home/tabs/stock/domain/repo/stock_repository.dart';
import 'package:trade_mate/utils/failures.dart';

import '../../../add_product/domain/entity/product_entity.dart';

class StockRepoImpl implements StockRepository{
  StockDataSource stockDataSource;
  StockRepoImpl({required this.stockDataSource});
  @override
  Stream<Either<Failures,List<ProductEntity>>> getProducts() {
    return stockDataSource.getProducts();
  }

  @override
  Future<void> deleteProduct(String id) {
    return stockDataSource.deleteProduct(id);
  }

  @override
  Future<void> updateProduct(String id, ProductEntity product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }


}
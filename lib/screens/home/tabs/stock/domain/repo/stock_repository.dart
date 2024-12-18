import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/entity/product_entity.dart';
import 'package:trade_mate/utils/failures.dart';

import '../../../add_product/data/model/product_model.dart';

abstract class StockRepository{
  Stream<Either<Failures,List<ProductEntity>>>getProducts();
}
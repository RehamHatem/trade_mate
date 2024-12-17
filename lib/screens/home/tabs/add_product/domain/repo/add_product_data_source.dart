import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/entity/product_entity.dart';
import 'package:trade_mate/utils/failures.dart';

abstract class AddProductDataSource{
  Future<Either<Failures,void>>addProduct(ProductEntity product);
}
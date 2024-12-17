import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/entity/product_entity.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/repo/add_product_repository.dart';
import 'package:trade_mate/utils/failures.dart';

class AddProductUseCase{
  AddProductRepository addProductRepository;
  AddProductUseCase({required this.addProductRepository});
  Future<Either<Failures,void>>addProduct(ProductEntity product) async{
    return addProductRepository.addProduct(product);
  }
}
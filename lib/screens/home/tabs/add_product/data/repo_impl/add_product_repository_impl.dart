import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/entity/product_entity.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/repo/add_product_data_source.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/repo/add_product_repository.dart';
import 'package:trade_mate/utils/failures.dart';

class AddProductRepositoryImpl implements AddProductRepository{
  AddProductDataSource addProductDataSource;
  AddProductRepositoryImpl({required this.addProductDataSource});
  @override
  Future<Either<Failures, void>> addProduct(ProductEntity product) async{
    try{
      var either= await addProductDataSource.addProduct(product.fromEntity(product));
      return right(null);
    }catch(e){
      return left(Failures(errorMsg: e.toString()));
    }
  }

}
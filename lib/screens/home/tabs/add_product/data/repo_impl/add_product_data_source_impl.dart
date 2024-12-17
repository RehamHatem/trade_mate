import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/home/tabs/add_product/data/data/add_product_fire_base_function.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/entity/product_entity.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/repo/add_product_data_source.dart';
import 'package:trade_mate/utils/failures.dart';

class AddProductDataSourceImpl implements AddProductDataSource{
  @override
  AddProductFireBaseFunction addProductFireBaseFunction;
  AddProductDataSourceImpl({required this.addProductFireBaseFunction});
  Future<Either<Failures, void>> addProduct(ProductEntity product)async {
   try{
     var either= await addProductFireBaseFunction.addProduct(product.fromEntity(product));
     return right(null);
   }catch(e){
     return left(Failures(errorMsg: e.toString()));
   }

  }

}
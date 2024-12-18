import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/home/tabs/stock/domain/repo/stock_repository.dart';
import 'package:trade_mate/utils/failures.dart';

import '../../../add_product/domain/entity/product_entity.dart';

class StockUseCases{
  StockRepository stockRepository;
  StockUseCases({required this.stockRepository});
  Stream<Either<Failures,List<ProductEntity>>>getProducts(){
    return stockRepository.getProducts();

}
Future<void>deleteProduct(String id){
    return stockRepository.deleteProduct(id);
}
  Future<void>updateProduct(String id,ProductEntity product){
    return stockRepository.updateProduct(id, product);
  }
}
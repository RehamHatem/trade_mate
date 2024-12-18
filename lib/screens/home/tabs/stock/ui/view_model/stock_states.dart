import '../../../../../../utils/failures.dart';
import '../../../add_product/domain/entity/product_entity.dart';

abstract class StockStates{

}
class StockInitState extends StockStates{

}
class StockLoadingState extends StockStates{
  String load;
  StockLoadingState({required this.load});

}
class StockSuccessState extends StockStates{
  List<ProductEntity> products;
  StockSuccessState({required this.products});

}
class StockErrorState extends StockStates {
  Failures error;

  StockErrorState({required this.error});
}
  class DeleteProductLoadingState extends StockStates{
  String load;
  DeleteProductLoadingState({required this.load});

  }
  class DeleteProductSuccessState extends StockStates{
  String success;
  DeleteProductSuccessState({required this.success});

  }
  class DeleteProductErrorState extends StockStates{
  String error;
  DeleteProductErrorState({required this.error});
}
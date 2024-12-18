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
class StockErrorState extends StockStates{
  Failures error;
  StockErrorState({required this.error});


}
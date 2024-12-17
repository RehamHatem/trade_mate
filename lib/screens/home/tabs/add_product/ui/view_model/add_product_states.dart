import 'package:trade_mate/screens/home/tabs/add_product/domain/entity/product_entity.dart';
import 'package:trade_mate/utils/failures.dart';

abstract class AddProductStates{

}
class AddProductInitState extends AddProductStates{

}
class AddProductLoadingState extends AddProductStates{
  String load;
  AddProductLoadingState({required this.load});

}
class AddProductSuccessState extends AddProductStates{
  ProductEntity productEntity;
  AddProductSuccessState({required this.productEntity});

}
class AddProductErrorState extends AddProductStates{
  Failures error;
  AddProductErrorState({required this.error});


}
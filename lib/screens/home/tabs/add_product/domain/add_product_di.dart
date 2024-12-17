import 'package:trade_mate/screens/home/tabs/add_product/data/data/add_product_fire_base_function.dart';
import 'package:trade_mate/screens/home/tabs/add_product/data/repo_impl/add_product_data_source_impl.dart';
import 'package:trade_mate/screens/home/tabs/add_product/data/repo_impl/add_product_repository_impl.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/repo/add_product_data_source.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/repo/add_product_repository.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/use_case/add_product_use_case.dart';



  AddProductUseCase injectAddProductUseCase(){
    return AddProductUseCase(addProductRepository: injectAddProductRepository());
  }
  AddProductRepository injectAddProductRepository(){
    return AddProductRepositoryImpl(addProductDataSource:injectAddProductDataSource() );
  }
  AddProductDataSource injectAddProductDataSource(){
    return AddProductDataSourceImpl(addProductFireBaseFunction: injectAddProductFireBaseFunction());

  }
  AddProductFireBaseFunction injectAddProductFireBaseFunction(){
    return AddProductFireBaseFunction();
  }

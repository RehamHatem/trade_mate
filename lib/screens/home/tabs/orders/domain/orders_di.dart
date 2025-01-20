import 'package:trade_mate/screens/home/tabs/orders/data/data/orders_data.dart';
import 'package:trade_mate/screens/home/tabs/orders/data/repo_impl/orders_data_source_impl.dart';
import 'package:trade_mate/screens/home/tabs/orders/data/repo_impl/orders_repository_impl.dart';
import 'package:trade_mate/screens/home/tabs/orders/domain/repo/orders_data_source.dart';
import 'package:trade_mate/screens/home/tabs/orders/domain/repo/orders_repository.dart';
import 'package:trade_mate/screens/home/tabs/orders/domain/use_case/orders_use_cases.dart';

OrdersUseCases injectOrdersUseCases(){
  return OrdersUseCases(ordersRepository: injectOrdersRepository());
}
OrdersRepository injectOrdersRepository(){
  return OrdersRepositoryImpl(ordersDataSource:injectOrdersDataSource() );
}
OrdersDataSource injectOrdersDataSource(){
  return OrdersDataSourceImpl(ordersData: injectOrdersData());
}
OrdersData injectOrdersData(){
  return OrdersData();

}
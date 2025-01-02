import 'package:trade_mate/screens/home/tabs/cutomers/domain/repo/customer_data_source.dart';
import 'package:trade_mate/screens/home/tabs/cutomers/domain/repo/customer_repository.dart';
import 'package:trade_mate/screens/home/tabs/cutomers/domain/use_case/customer_use_cases.dart';

import '../data/data/cutomer_data.dart';
import '../data/repo_impl/customer_data_source_impl.dart';
import '../data/repo_impl/customer_repo_impl.dart';

CustomerUseCases injectCustomerUseCases(){
  return CustomerUseCases(customerRepository: injectCustomerRepository());
}
CustomerRepository injectCustomerRepository(){
  return CustomerRepoImpl(customerDataSource: injectCustomerDataSource());
}
CustomerDataSource injectCustomerDataSource(){
  return CustomerDataSourceImpl(customerData: injectCustomerData());
}
CustomerData injectCustomerData(){
  return CustomerData();
}
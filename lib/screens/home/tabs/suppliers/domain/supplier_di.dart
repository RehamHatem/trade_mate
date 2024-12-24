import 'package:trade_mate/screens/home/tabs/suppliers/data/data/supplier_data.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/data/repo_impl/supplier_data_source_impl.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/data/repo_impl/supplier_repo_impl.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/repo/supplier_data_source.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/repo/supplier_repository.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/use_case/supplier_use_cases.dart';

SupplierUseCases injectSupplierUseCases(){
  return SupplierUseCases(supplierRepository: injectSupplierRepository());
}
SupplierRepository injectSupplierRepository(){
  return SupplierRepoImpl(supplierDataSource: injectSupplierDataSource());
}
SupplierDataSource injectSupplierDataSource(){
  return SupplierDataSourceImpl(supplierData: injectSupplierData());
}
SupplierData injectSupplierData(){
  return SupplierData();
}
import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/data/model/supplier_model.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/entity/supplier_entity.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/repo/supplier_data_source.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/repo/supplier_repository.dart';
import 'package:trade_mate/utils/failures.dart';

import '../../domain/repo/customer_data_source.dart';
import '../../domain/repo/customer_repository.dart';

class CustomerRepoImpl implements CustomerRepository{
  CustomerDataSource customerDataSource;
  CustomerRepoImpl({required this.customerDataSource});

  @override
  Future<Either<Failures, void>> addCustomer(SupplierEntity customer)async {
    try{
      var either= await customerDataSource.addCustomer(customer.fromEntity(customer));
      return right(null);
    }catch(e){
      return left(Failures(errorMsg: e.toString()));
    }
  }
  @override
  Future<void> deleteCustomer(String id) {
    return customerDataSource.deleteCustomer(id);
  }

  @override
  Stream<Either<Failures, List<SupplierEntity>>> getCustomer() {
    return customerDataSource.getCustomer();
  }

  @override
  Future<void> updateCustomer(String id, SupplierEntity customer) {
    return customerDataSource.updateCustomer(id, customer);
  }


  }

  // @override
  // void addSupplier( SupplierEntity supplier) {
  //   return supplierDataSource.addSupplier(supplier);
  // }
  //
  // @override
  // Future<List<SupplierEntity>> getSuppliers() {
  //
  //  return supplierDataSource.getSuppliers();
  // }
  //
  // @override
  // void removeSupplier(String index) {
  //   return supplierDataSource.removeSupplier(index);
  // }



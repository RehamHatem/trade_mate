import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/entity/supplier_entity.dart';

import '../../../../../../utils/failures.dart';
import '../repo/customer_repository.dart';

class CustomerUseCases{
  CustomerUseCases({required this.customerRepository});
  CustomerRepository customerRepository;
  Future<Either<Failures,void>>addCustomer(SupplierEntity customer) async{
    return customerRepository.addCustomer(customer);
  }
  Stream<Either<Failures,List<SupplierEntity>>>getCustomers(){
    return customerRepository.getCustomer();

  }
  Future<void>deleteCustomer(String id){
    return customerRepository.deleteCustomer(id);
  }
  Future<void>updateCustomer(String id,SupplierEntity customer){
    return customerRepository.updateCustomer(id, customer);
  }



  // void addSupplier(SupplierEntity supplier){
  //   return supplierRepository.addSupplier(supplier);
  // }
  // Future<List<SupplierEntity>>getSupplier(){
  //   return supplierRepository.getSuppliers();
  // }
  // void removeSupplier(String index){
  //   return supplierRepository.removeSupplier(index);
  // }

}
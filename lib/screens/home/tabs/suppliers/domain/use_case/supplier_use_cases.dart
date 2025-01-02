import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/entity/supplier_entity.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/repo/supplier_repository.dart';

import '../../../../../../utils/failures.dart';

class SupplierUseCases{
  SupplierUseCases({required this.supplierRepository});
  SupplierRepository supplierRepository;
  Future<Either<Failures,void>>addSupplier(SupplierEntity supplier) async{
    return supplierRepository.addSupplier(supplier);
  }
  Stream<Either<Failures,List<SupplierEntity>>>getSuppliers(){
    return supplierRepository.getSuppliers();

  }
  Future<void>deleteSupplier(String id){
    return supplierRepository.deleteSupplier(id);
  }
  Future<void>updateProduct(String id,SupplierEntity supplier){
    return supplierRepository.updateSupplier(id, supplier);
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
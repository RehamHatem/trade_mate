import 'package:trade_mate/screens/home/tabs/suppliers/domain/entity/supplier_entity.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/repo/supplier_repository.dart';

class SupplierUseCases{
  SupplierUseCases({required this.supplierRepository});
  SupplierRepository supplierRepository;
  void addSupplier(SupplierEntity supplier){
    return supplierRepository.addSupplier(supplier);
  }
  Future<List<SupplierEntity>>getSupplier(){
    return supplierRepository.getSuppliers();
  }

}
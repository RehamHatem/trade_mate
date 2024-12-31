import 'package:trade_mate/screens/home/tabs/suppliers/data/model/supplier_model.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/entity/supplier_entity.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/repo/supplier_data_source.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/repo/supplier_repository.dart';

class SupplierRepoImpl implements SupplierRepository{
  SupplierDataSource supplierDataSource;
  SupplierRepoImpl({required this.supplierDataSource});

  @override
  void addSupplier( SupplierEntity supplier) {
    return supplierDataSource.addSupplier(supplier);
  }

  @override
  Future<List<SupplierEntity>> getSuppliers() {

   return supplierDataSource.getSuppliers();
  }

  @override
  void removeSupplier(String index) {
    return supplierDataSource.removeSupplier(index);
  }


}
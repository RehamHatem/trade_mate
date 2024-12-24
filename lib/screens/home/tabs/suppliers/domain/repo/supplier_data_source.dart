import '../entity/supplier_entity.dart';

abstract class SupplierDataSource{
  void addSupplier(SupplierEntity supplier);
  Future<List<SupplierEntity>> getSuppliers();

}
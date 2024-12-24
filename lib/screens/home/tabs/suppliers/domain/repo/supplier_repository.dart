import 'package:trade_mate/screens/home/tabs/suppliers/domain/entity/supplier_entity.dart';

abstract class SupplierRepository{
  void addSupplier(SupplierEntity supplier);
  Future<List<SupplierEntity>> getSuppliers();

}
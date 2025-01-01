import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/entity/supplier_entity.dart';

import '../../../../../../utils/failures.dart';

abstract class SupplierRepository{
  Future<Either<Failures,void>>addSupplier(SupplierEntity supplier);
  Stream<Either<Failures,List<SupplierEntity>>>getSuppliers();
  Future<void>deleteSupplier(String id);
  Future<void>updateSupplier(String id,SupplierEntity supplier);

  // void addSupplier(SupplierEntity supplier);
  // Future<List<SupplierEntity>> getSuppliers();
  // void removeSupplier(String index);

}
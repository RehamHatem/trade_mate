import 'package:dartz/dartz.dart';

import '../../../../../../utils/failures.dart';
import '../entity/supplier_entity.dart';

abstract class SupplierDataSource{
  Future<Either<Failures,void>>addSupplier(SupplierEntity supplier);
  Stream<Either<Failures,List<SupplierEntity>>>getSuppliers();
  Future<void>deleteSupplier(String id);
  Future<void>updateSupplier(String id,SupplierEntity supplier);


  // void addSupplier(SupplierEntity supplier);
  // Future<List<SupplierEntity>> getSuppliers();
  // void removeSupplier(String index);


}
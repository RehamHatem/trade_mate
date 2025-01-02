import 'package:dartz/dartz.dart';

import '../../../../../../utils/failures.dart';
import '../../../suppliers/domain/entity/supplier_entity.dart';

abstract class CustomerDataSource{
  Future<Either<Failures,void>>addCustomer(SupplierEntity customer);
  Stream<Either<Failures,List<SupplierEntity>>>getCustomer();
  Future<void>deleteCustomer(String id);
  Future<void>updateCustomer(String id,SupplierEntity customer);

}
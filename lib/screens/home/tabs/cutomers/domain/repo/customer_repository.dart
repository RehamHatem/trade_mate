import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/entity/supplier_entity.dart';

import '../../../../../../utils/failures.dart';

abstract class CustomerRepository{
  Future<Either<Failures,void>>addCustomer(SupplierEntity customer);
  Stream<Either<Failures,List<SupplierEntity>>>getCustomer();
  Future<void>deleteCustomer(String id);
  Future<void>updateCustomer(String id,SupplierEntity customer);

}
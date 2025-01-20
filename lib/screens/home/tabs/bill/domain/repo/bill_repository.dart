import 'package:dartz/dartz.dart';

import '../../../../../../utils/failures.dart';
import '../entity/bill_entity.dart';

abstract class BillRepository{
  Future<Either<Failures,void>>addBill(BillEntity bill);

}
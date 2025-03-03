import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/home/tabs/bill/domain/entity/bill_entity.dart';

import '../../../../../../utils/failures.dart';

abstract class BillDataSource {
  Future<Either<Failures,void>>addBill(BillEntity bill);


}
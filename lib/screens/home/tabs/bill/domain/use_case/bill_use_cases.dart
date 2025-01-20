import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/home/tabs/bill/domain/repo/bill_repository.dart';

import '../../../../../../utils/failures.dart';
import '../entity/bill_entity.dart';

class BillUseCases{
  BillUseCases({required this.billRepository});
  BillRepository billRepository;
  Future<Either<Failures,void>>addBill(BillEntity bill) async{
    return billRepository.addBill(bill);
  }

}
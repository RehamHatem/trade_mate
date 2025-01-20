import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/home/tabs/bill/domain/entity/bill_entity.dart';
import 'package:trade_mate/screens/home/tabs/bill/domain/repo/bill_data_source.dart';
import 'package:trade_mate/screens/home/tabs/bill/domain/repo/bill_repository.dart';

import '../../../../../../utils/failures.dart';

class BillRepoImpl implements BillRepository{
  BillRepoImpl({required this.billDataSource});
  BillDataSource billDataSource;
  @override
  Future<Either<Failures, void>> addBill(BillEntity bill)async {
    try{
     await billDataSource.addBill(bill.fromEntity(bill));
      return right(null);
    }catch(e){
      return left(Failures(errorMsg: e.toString()));
    }
  }



}
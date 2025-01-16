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
  @override
  Future<void> deleteBill(String id) {
    return billDataSource.deleteBill(id);
  }

  @override
  Stream<Either<Failures, List<BillEntity>>> getBills() {
    return billDataSource.getBills();
  }

  @override
  Future<void> updateBill(String id, BillEntity bill) {
    return billDataSource.updateBill(id, bill);
  }


}
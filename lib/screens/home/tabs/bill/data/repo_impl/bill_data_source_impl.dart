import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/home/tabs/bill/data/data/bill_data.dart';
import 'package:trade_mate/screens/home/tabs/bill/domain/entity/bill_entity.dart';
import 'package:trade_mate/screens/home/tabs/bill/domain/repo/bill_data_source.dart';

import '../../../../../../utils/failures.dart';

class BillDataSourceImpl implements BillDataSource{
  BillDataSourceImpl({required this.billData});
  BillData billData;
  @override
  Future<Either<Failures, void>> addBill(BillEntity bill) async{
    try{
     await billData.addBill(bill.fromEntity(bill));
      return right(null);
    }catch(e){
      return left(Failures(errorMsg: e.toString()));
    }
  }

}
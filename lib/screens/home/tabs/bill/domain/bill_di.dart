import 'package:trade_mate/screens/home/tabs/bill/domain/repo/bill_data_source.dart';
import 'package:trade_mate/screens/home/tabs/bill/domain/repo/bill_repository.dart';
import 'package:trade_mate/screens/home/tabs/bill/domain/use_case/bill_use_cases.dart';

import '../data/data/bill_data.dart';
import '../data/repo_impl/bill_data_source_impl.dart';
import '../data/repo_impl/bill_repo_impl.dart';

BillUseCases injectBillUseCases(){
  return BillUseCases(billRepository: injectBillRepository());
}
BillRepository injectBillRepository(){
  return BillRepoImpl(billDataSource: injectBillDataSource());
}
BillDataSource injectBillDataSource(){
  return BillDataSourceImpl(billData: injectBillData());
}
BillData injectBillData(){
  return BillData();
}
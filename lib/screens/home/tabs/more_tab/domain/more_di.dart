import 'package:trade_mate/screens/home/tabs/more_tab/data/data/more_data.dart';
import 'package:trade_mate/screens/home/tabs/more_tab/data/repo_impl/more_data_source_impl.dart';
import 'package:trade_mate/screens/home/tabs/more_tab/data/repo_impl/more_repo_impl.dart';
import 'package:trade_mate/screens/home/tabs/more_tab/domain/repo/more_data_source.dart';
import 'package:trade_mate/screens/home/tabs/more_tab/domain/repo/more_repository.dart';
import 'package:trade_mate/screens/home/tabs/more_tab/domain/use_case/more_use_cases.dart';

MoreUseCases injectMoreUseCases(){
  return MoreUseCases(moreRepository: injectMoreRepository());
}
MoreRepository injectMoreRepository(){
  return MoreRepoImpl(moreDataSource: injectMoreDataSource());
}
MoreDataSource injectMoreDataSource(){
  return MoreDataSourceImpl(moreData: injectMoreData());
}
MoreData injectMoreData(){
  return MoreData();
}
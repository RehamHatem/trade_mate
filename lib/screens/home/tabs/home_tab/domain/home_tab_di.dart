import 'package:trade_mate/screens/home/tabs/home_tab/domain/repo/home_tab_data_source.dart';
import 'package:trade_mate/screens/home/tabs/home_tab/domain/repo/home_tab_repository.dart';
import 'package:trade_mate/screens/home/tabs/home_tab/domain/use_case/home_tab_use_cases.dart';

import '../data/data/home_tab_data.dart';
import '../data/repo_impl/home_tab_data_source_impl.dart';
import '../data/repo_impl/home_tab_repo_impl.dart';

HomeTabUseCases injectHomeTabUseCases(){
  return HomeTabUseCases(homeTabRepository: injectHomeTabRepository());
}
HomeTabRepository injectHomeTabRepository(){
  return HomeTabRepoImpl(homeTabDataSource:injectAddProductDataSource() );
}
HomeTabDataSource injectAddProductDataSource(){
  return HomeTabDataSourceImpl(homeTabData: injectHomeTabData());

}
HomeTabData injectHomeTabData(){
  return HomeTabData();
}
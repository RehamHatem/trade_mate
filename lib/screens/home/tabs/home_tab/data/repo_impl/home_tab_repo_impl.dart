import 'package:trade_mate/screens/auth/signup/data/model/user_model.dart';
import 'package:trade_mate/screens/home/tabs/home_tab/domain/repo/home_tab_data_source.dart';
import 'package:trade_mate/screens/home/tabs/home_tab/domain/repo/home_tab_repository.dart';

import '../../../../../auth/login/data/model/user_login_model.dart';

class HomeTabRepoImpl implements HomeTabRepository{
  HomeTabDataSource homeTabDataSource;
  HomeTabRepoImpl({required this.homeTabDataSource});
  @override
  Future<void> updateBalance(String id,double balance) {
    return homeTabDataSource.updateBalance(id, balance);
  }

  @override
  Future<double> getUserBalance(String userId) {
   return homeTabDataSource.getUserBalance(userId);
  }

}
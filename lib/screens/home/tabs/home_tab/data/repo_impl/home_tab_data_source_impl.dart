import 'package:trade_mate/screens/auth/signup/data/model/user_model.dart';
import 'package:trade_mate/screens/home/tabs/home_tab/data/data/home_tab_data.dart';
import 'package:trade_mate/screens/home/tabs/home_tab/domain/repo/home_tab_data_source.dart';

import '../../../../../auth/login/data/model/user_login_model.dart';

class HomeTabDataSourceImpl implements HomeTabDataSource{
  HomeTabData homeTabData;
  HomeTabDataSourceImpl({required this.homeTabData});
  @override
  Future<void> updateBalance(String id, double balance) async{
   return await homeTabData.updateBalance(id, balance);
  }

  @override
  Future<double> getUserBalance(String userId)async {
   return await homeTabData.getUserBalance(userId);
  }

}
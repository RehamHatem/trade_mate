import 'package:trade_mate/screens/auth/signup/data/model/user_model.dart';
import 'package:trade_mate/screens/home/tabs/more_tab/data/data/more_data.dart';

import '../../domain/repo/more_data_source.dart';

class MoreDataSourceImpl implements MoreDataSource{
  MoreDataSourceImpl({required this.moreData});
  MoreData moreData;
  @override
  Future<UserModel?> readUser() {
    return moreData.readUser();
  }

  @override
  void logOut() {
   return moreData.logOut();
  }

}
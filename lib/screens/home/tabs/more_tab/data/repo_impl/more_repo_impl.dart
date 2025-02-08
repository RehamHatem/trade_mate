import 'package:trade_mate/screens/auth/signup/data/model/user_model.dart';
import 'package:trade_mate/screens/home/tabs/more_tab/domain/repo/more_data_source.dart';
import 'package:trade_mate/screens/home/tabs/more_tab/domain/repo/more_repository.dart';

class MoreRepoImpl implements MoreRepository{
  MoreRepoImpl({required this.moreDataSource});
  MoreDataSource moreDataSource;
  @override
  Future<UserModel?> readUser() {
    return moreDataSource.readUser();
  }

  @override
  void logOut() {
return moreDataSource.logOut();
  }

}
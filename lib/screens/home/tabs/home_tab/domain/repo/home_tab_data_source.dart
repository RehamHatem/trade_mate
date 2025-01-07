import '../../../../../auth/login/data/model/user_login_model.dart';
import '../../../../../auth/signup/data/model/user_model.dart';

abstract class HomeTabDataSource{
  Future<void>updateBalance(String id, double balance);
  Future<double>getUserBalance (String userId);

}
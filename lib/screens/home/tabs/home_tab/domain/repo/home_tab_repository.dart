import 'package:trade_mate/screens/auth/signup/data/model/user_model.dart';

import '../../../../../auth/login/data/model/user_login_model.dart';

abstract class HomeTabRepository{
Future<void>updateBalance(String id, double balance);
Future<double>getUserBalance (String userId);
}
// FirebaseAuth.instance.currentUser?.uid
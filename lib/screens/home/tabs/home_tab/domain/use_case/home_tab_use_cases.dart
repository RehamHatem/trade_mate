import 'package:trade_mate/screens/home/tabs/home_tab/domain/repo/home_tab_repository.dart';

import '../../../../../auth/login/data/model/user_login_model.dart';
import '../../../../../auth/signup/data/model/user_model.dart';

class HomeTabUseCases{
  HomeTabRepository homeTabRepository;
  HomeTabUseCases({required this.homeTabRepository});
  Future<void>updateBalance(String id, double balance){
    return homeTabRepository.updateBalance(id,  balance);

  }
  Future<double>getUserBalance (String userId){
    return homeTabRepository.getUserBalance(userId);
  }

}
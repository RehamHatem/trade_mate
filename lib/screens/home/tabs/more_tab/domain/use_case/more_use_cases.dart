import 'package:trade_mate/screens/home/tabs/more_tab/domain/repo/more_repository.dart';

import '../../../../../auth/signup/data/model/user_model.dart';

class MoreUseCases{
  MoreUseCases({required this.moreRepository});
  MoreRepository moreRepository;
  Future<UserModel?> readUser(){
    return moreRepository.readUser();
}
 void logOut(){
    return moreRepository.logOut();
 }

}
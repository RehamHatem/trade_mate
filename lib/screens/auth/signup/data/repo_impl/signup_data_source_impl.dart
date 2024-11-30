import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/auth/signup/data/data/firebase_signup.dart';
import 'package:trade_mate/screens/auth/signup/data/model/user_model.dart';
import 'package:trade_mate/screens/auth/signup/domain/entity/user_entity.dart';
import 'package:trade_mate/screens/auth/signup/domain/repository/signup_data_source.dart';
import 'package:trade_mate/utils/failures.dart';

class SignupDataSourceImpl implements SignupDataSource{
  FirebaseSignup firebaseSignup;
  SignupDataSourceImpl({required this.firebaseSignup});
  @override
  Future<Either<Failures, void>> signUp(UserModel user, String password) async {

    try {
      // Interact with Firebase
      await firebaseSignup.creatAccount(
        email: user.email,
        password: password,
        userName: user.userName,
        phone: user.phone,
        onSuccess: () => {},
        onError: (message) => throw Exception(message),
      );

      return right(null);
    } catch (e) {
      return left(Failures(errorMsg: e.toString()));
    }
  }
}
  

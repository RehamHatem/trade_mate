class UserEntity{
  static const String collectionName="Users";
  String id;
  String email;
  String phone;
  String userName;
  double balance;
  bool emailVerified;

  UserEntity({
    required this.id,
    required this.email,
    this.phone = "",
    this.emailVerified = false,
    required this.userName,
    this.balance=0,

  });

}
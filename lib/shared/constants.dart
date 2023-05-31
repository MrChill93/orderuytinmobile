import 'package:firebase_database/firebase_database.dart';

import '../presentation/features/user/data/model/user_model.dart';

class OrderuytinConfig {
  String? dbUrl;
  late FirebaseDatabase? database;
  FirebaseDatabase get database$ => database!;

  OrderuytinConfig._internal();
  static OrderuytinConfig? _instance;
  static OrderuytinConfig get shared {
    _instance ??= OrderuytinConfig._internal();

    return _instance!;
  }
}

class UserRepoX {
  UserRepoX._internal();
  static UserRepoX? _instance;
  static UserRepoX get shared {
    _instance ??= UserRepoX._internal();

    return _instance!;
  }

  UserModel? signedInUser;
  UserModel get user => signedInUser!;

  String? userId;
  String get userId$ => userId!;
}

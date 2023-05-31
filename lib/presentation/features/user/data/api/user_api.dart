import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

import '../../../../../shared/constants.dart';
import '../model/user_model.dart';

class UserApi {
  UserApi();

  static Future<void> getInforUser(
    String id,
    void Function(UserModel user) onSuccess,
  ) async {
    try {
      final starCountRef = OrderuytinConfig.shared.database$.ref('users/$id');
      late final UserModel user;
      starCountRef.onValue.listen((DatabaseEvent event) {
        final data = event.snapshot.value;
        user = UserModel.fromJson(jsonDecode(jsonEncode(data)));
        onSuccess.call(user);
      });

      return;
    } catch (e) {
      return;
    }
  }

  static Future<UserModel?> getAuthUser(
    String id,
  ) async {
    final starCountRef = OrderuytinConfig.shared.database$.ref('users/$id');

    late final UserModel? user;
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;

      user = UserModel.fromJson(jsonDecode(jsonEncode(data)));
    });

    return user;
  }

  static Future<void> updateUser({
    required UserModel userModel,
    required String userId,
    required void Function(bool result) onSuccess,
  }) async {
    try {
      final ref = OrderuytinConfig.shared.database$.ref('users/$userId');
      await ref.update(userModel.toJson());
      onSuccess.call(true);
    } catch (e) {}
    // await UserRepo.getUserData(id, (user2) {
    //   UserRepoX.shared.signedInUser = user2;
    // });
  }
  // static Future<UserModel> getUser(String? userName) async {
  //   // cityName = 'Hue';
  //   final Dio dio = Dio();
  //   dio.interceptors.add(loggerInterceptor);
  //   final userResponse = await dio.get(userName??"");

  //   if (userResponse.statusCode != 200) {
  //     throw UserRequestFailure();
  //   }

  //   final userJson = userResponse.data as Map;

  //   if (!userJson.containsKey('results')) throw UserNotFoundFailure();

  //   final results = userJson['results'] as List;

  //   if (results.isEmpty) throw UserNotFoundFailure();

  //   return UserModel.fromJson(results.first as Map<String, dynamic>);
  // }
}

class UserNotFoundFailure implements Exception {}

class UserRequestFailure {}

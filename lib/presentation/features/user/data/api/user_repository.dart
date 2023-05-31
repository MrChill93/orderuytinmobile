import 'package:orderuytinmobile/presentation/features/user/data/api/user_api.dart';
import '../../../../../service/firebase/fir_api_helper.dart';
import '../../../../../shared/network/data_state.dart';
import '../model/user_model.dart';

class UserRepo {
  UserRepo();

  static Future<DataState<void>> getUserData(
      String id, void Function(UserModel user) onSuccess) async {
    final FirebaseApiHelperConfig<void> config = FirebaseApiHelperConfig<void>(
      apiFunction: UserApi.getInforUser(id, onSuccess),
      type: FirebaseApiEnum.auth,
    );

    final DataState<void> response =
        await firebaseApiHelper<void>(config: config);

    if (response is DataSuccess<UserModel?> && response.data != null) {
      return DataSuccess<UserModel>(data: response.data!, originResponse: null);
    }

    return DataFailed();
  }

  static Future<DataState<void>> updateUserData(
      {required UserModel userModel,
      required String id,
      required void Function(bool result) onSuccess}) async {
    final FirebaseApiHelperConfig<void> config = FirebaseApiHelperConfig<void>(
      apiFunction: UserApi.updateUser(
          userModel: userModel, userId: id, onSuccess: onSuccess),
      type: FirebaseApiEnum.auth,
    );

    final DataState<void> response =
        await firebaseApiHelper<void>(config: config);

    if (response is DataSuccess<UserModel?> && response.data != null) {
      return DataSuccess<UserModel>(data: response.data!, originResponse: null);
    }

    return DataFailed();
  }

  static Future<DataState<UserModel>> getUserAuth(String id) async {
    final FirebaseApiHelperConfig<UserModel?> config =
        FirebaseApiHelperConfig<UserModel?>(
      apiFunction: UserApi.getAuthUser(id),
      type: FirebaseApiEnum.auth,
    );

    final DataState<void> response =
        await firebaseApiHelper<UserModel?>(config: config);

    if (response is DataSuccess<UserModel?> && response.data != null) {
      return DataSuccess<UserModel>(data: response.data!, originResponse: null);
    }

    return DataFailed();
  }
}

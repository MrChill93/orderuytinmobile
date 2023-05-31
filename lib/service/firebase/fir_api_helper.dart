// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../shared/app_logger.dart';
import '../../shared/network/data_state.dart';

Future<DataState<T?>> firebaseApiHelper<T>({
  required FirebaseApiHelperConfig<T> config,
}) async {
  try {
    if (config.isShowLoading) {
      EasyLoading.show(dismissOnTap: false);
      await Future.delayed(const Duration(milliseconds: 300));
    }

    final response = await config.apiFunction;

    if (response != null) {
      config.onSuccess?.call(
        DataSuccess(data: response, originResponse: null),
      );
      if (config.isShowLoading) {
        EasyLoading.dismiss();
      }
      return DataSuccess(data: response, originResponse: null);
    }
  } on FirebaseAuthException catch (err) {
    AppLogger.shared
        .logException("Firebase", "${config.type.prefixPath}${err.code}");
    config.onFailure?.call("${config.type.prefixPath}${err.code}");
    if (config.isShowLoading) {
      EasyLoading.dismiss();
    }
  } catch (err) {
    AppLogger.shared
        .logException("Firebase", "${config.type.prefixPath}${err.toString()}");
  }
  if (config.isShowLoading) {
    EasyLoading.dismiss();
  }
  return DataFailed(dioError: null);
}

class FirebaseApiHelperConfig<T> {
  final Future<T?> apiFunction;
  final FirebaseApiEnum type;
  final bool isShowLoading;
  final bool isShowDefaultErrorDialog;
  final Function(DataSuccess<T?>)? onSuccess;
  final Function(String errorCode)? onFailure;
  final String? cachedUuid;
  FirebaseApiHelperConfig({
    required this.apiFunction,
    required this.type,
    this.isShowLoading = true,
    this.isShowDefaultErrorDialog = true,
    this.onSuccess,
    this.onFailure,
    this.cachedUuid,
  });
}

enum FirebaseApiEnum {
  auth("auth-");

  final String prefixPath;
  const FirebaseApiEnum(this.prefixPath);
}

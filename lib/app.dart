import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:orderuytinmobile/presentation/features/login/login_page.dart';
import 'package:orderuytinmobile/presentation/features/register/register_page.dart';
import 'package:orderuytinmobile/presentation/features/splash/splash_page_0.dart';
import 'package:orderuytinmobile/presentation/features/user/presentations/change_password/change_password_page.dart';
import 'package:orderuytinmobile/presentation/features/user/presentations/change_password/forcechange_password_page.dart';
import 'package:orderuytinmobile/presentation/features/user/presentations/change_user_profile/change_user_profile.dart';

import 'USER/home/home.dart';

class OrderuytinApp extends StatelessWidget {
  const OrderuytinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        if (settings.name == "/") {
          return MaterialPageRoute(builder: (_) => const SplashPage0());
        }

        if (settings.name == LoginPage.routeName) {
          return MaterialPageRoute(builder: (_) => const LoginProvider());
        }

        if (settings.name == HomeScreen.nameRoute) {
          final String id = settings.arguments as String;
          return MaterialPageRoute<String>(
              builder: (_) => HomeScreen(
                    id: id,
                  ));
        }

        if (settings.name == RegisterPage.nameRoute) {
          return MaterialPageRoute<String>(
              builder: (_) => const RegisterPage());
        }

        if (settings.name == ChangePasswordPage.nameRoute) {
          return MaterialPageRoute<String>(
              builder: (_) => const ChangePasswordPage());
        }

        if (settings.name == ForceChangePasswordPage.nameRoute) {
          return MaterialPageRoute<String>(
              builder: (_) => const ForceChangePasswordPage());
        }

        if (settings.name == ChangeUserProfilePage.nameRoute) {
          final Map<String, dynamic> argument =
              settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute<String>(
              builder: (_) => ChangeUserProfilePage(null, argument["user"]));
        }
        return null;
      },
      // initialRoute: '/',
      builder: EasyLoading.init(),
    );
  }
}

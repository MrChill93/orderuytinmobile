import 'package:flutter/material.dart';

import '../../../register/register_page.dart';
import '../../shared_ui/btn/btn_default/btn_default.dart';
import '../../shared_ui/themes/colors.dart';
import '../../shared_ui/themes/text_styles.dart';
import '../login/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/imageLogin.png"),
                Text(
                  "ghichu",
                  style: tStyle.paragraph18().w700().copyWith(
                        color: Hcm23Colors.colorBrand,
                      ),
                ),
                Text(
                  "Ứng dụng ghi chú tốt nhất cho bạn",
                  style: tStyle
                      .paragraph14()
                      .w400()
                      .copyWith(color: Hcm23Colors.colorTextPhude),
                ),
                const SizedBox(
                  height: 32,
                ),
                //sign in splash
                BtnDefault(
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const LoginPage(),
                      ),
                    );
                  },
                  customDecoration: const BoxDecoration(
                    color: Hcm23Colors.color3,
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  customChild: Center(
                    child: Text(
                      "Đăng nhập",
                      style: tStyle.display14().w500().copyWith(
                            color: Hcm23Colors.colorWhite,
                          ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                //sign up splash
                BtnDefault(
                  type: BtnDefaultType.secondary,
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const RegisterPage(),
                      ),
                    );
                  },
                  title: "Đăng ký",
                ),
              ],
            ),
          ),
          // const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Hcm23_demo_prj"),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Về chúng tôi",
                    style: tStyle
                        .paragraph14()
                        .w500()
                        .copyWith(color: Hcm23Colors.color3),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}

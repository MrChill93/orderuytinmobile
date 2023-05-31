// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../USER/home/home.dart';
import '../presentation/features/user/data/model/user_model.dart';
import '../presentation/shared_ui/btn/btn_default/btn_default.dart';
import '../presentation/shared_ui/inputs/input_clear/input_clear.dart';
import '../presentation/shared_ui/inputs/input_normal/input_normal_layout_mixin.dart';
import '../presentation/shared_ui/themes/colors.dart';
import '../presentation/shared_ui/themes/text_styles.dart';
import '../service/firebase/auth/fir_auth_repo.dart';
import '../shared/constants.dart';

class RegisterPage extends StatefulWidget {
  static const nameRoute = 'RegisterPage';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _hidePw = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void _showHidePw() {
    setState(() {
      _hidePw = !_hidePw;
    });
  }

  FeedbackType passwordFeedbackType = FeedbackType.none;
  String? feedbackMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Đăng ký"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Image.asset("assets/images/register.png"),
              ),
              Text(
                "Xin chào Người dùng!",
                style: tStyle.paragraph18().w500().copyWith(
                      color: Hcm23Colors.colorTextTitle,
                    ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "Vui lòng điền thông tin tài khoản để đăng ký!",
                style: tStyle
                    .paragraph14()
                    .w400()
                    .copyWith(color: Hcm23Colors.colorTextPhude),
              ),
              const SizedBox(
                height: 20,
              ),
              InputClear(
                controller: _usernameController,
                placeholderText: "Tài khoản",
                clearButton: SvgPicture.asset(
                  "assets/icons/ui_kit/bold/close_square.svg",
                  fit: BoxFit.scaleDown,
                ),
                decoration: InputDecoration(
                  prefixIcon: SvgPicture.asset(
                    "assets/icons/ui_kit/normal/user.svg",
                    color: const Color(0XFFA2AEBD),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              InputClear(
                controller: _passwordController,
                placeholderText: "Mật khẩu",
                obscureText: _hidePw,
                decoration: InputDecoration(
                  prefixIcon: SvgPicture.asset(
                    "assets/icons/ui_kit/bold/lock.svg",
                    fit: BoxFit.scaleDown,
                  ),
                  suffixIcon: InkWell(
                    onTap: _showHidePw,
                    child: SvgPicture.asset(
                      _hidePw
                          ? "assets/icons/ui_kit/bold/hide.svg"
                          : "assets/icons/ui_kit/bold/show.svg",
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                clearButton: SvgPicture.asset(
                  "assets/icons/ui_kit/bold/close_square.svg",
                  fit: BoxFit.scaleDown,
                ),
                feedBackType: passwordFeedbackType,
                feedbackMessage: feedbackMessage,
              ),
              const SizedBox(
                height: 32,
              ),
              BtnDefault(
                title: "Đăng ký",
                onTap: () async {
                  await FirAuthRepo.createUserWithEmailAndPassword(
                    email: _usernameController.text,
                    password: _passwordController.text,
                    onFailure: (p0) {
                      setState(() {
                        passwordFeedbackType = FeedbackType.error;
                        feedbackMessage = p0;
                      });
                    },
                    onSuccess: (p0) async {
                      final ref = OrderuytinConfig.shared.database$
                          .ref("users/${p0.data?.user?.uid}");

                      await ref.set(UserModel(
                        email: _usernameController.text,
                        userName: _usernameController.text,
                      ).toJson());

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (_) => HomePageOrder(
                                    id: p0.data?.user?.uid ?? "",
                                  )),
                          (route) => false);
                    },
                  );
                },
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "Hoặc",
                style: tStyle
                    .paragraph14()
                    .w400()
                    .copyWith(color: Hcm23Colors.colorTextPhude),
              ),
              const SizedBox(
                height: 4,
              ),
              BtnDefault(
                type: BtnDefaultType.secondary,
                title: "Đăng nhập",
                onTap: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

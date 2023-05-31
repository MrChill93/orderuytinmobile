// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../shared_ui/inputs/base_input/base_input.dart';
import '../../../../shared_ui/inputs/base_input/base_input_configs.dart';
import '../../../../shared_ui/themes/colors.dart';
import '../../../../shared_ui/themes/text_styles.dart';

class ForceChangePasswordPage extends StatefulWidget {
  static const nameRoute = 'ForceChangePasswordPage';

  const ForceChangePasswordPage({super.key});

  @override
  State<ForceChangePasswordPage> createState() =>
      _ForceChangePasswordPageState();
}

class _ForceChangePasswordPageState extends State<ForceChangePasswordPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    // usernameController.dispose();
    // emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Expanded(
          child: Center(
            child: Text(
              'Đổi lại mật khẩu',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Hcm23BaseInput(
                baseConfigs: BaseInputConfigs(
                  controller: emailController,
                  decoration:
                      const InputDecoration(prefixIcon: Icon(Icons.email)),
                  placeholderText: "Email/Số điện thoại",
                  maxLines: 1,
                  //  feedBackType: FeedbackType.none
                ),
              ),

              // username
              Hcm23BaseInput(
                baseConfigs: BaseInputConfigs(
                  controller: usernameController,
                  decoration: InputDecoration(
                    prefixIcon: SvgPicture.asset(
                      "assets/icons/ui_kit/normal/user.svg",
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  placeholderText: "Tên tài khoản",
                  maxLines: 1,
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomPopup(
                        phoneNumber: usernameController.text,
                        email: emailController.text,
                      ); // CustomDialog là widget hiển thị popup
                    },
                  );
                },
                child: Ink(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 211, 211, 231),
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: Center(
                      child: Text("Tiếp theo",
                          style: tStyle.display14().w500().copyWith(
                                color: Hcm23Colors.colorBrand,
                              )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomPopup extends StatelessWidget {
  final String phoneNumber;
  final String email;

  const CustomPopup(
      {super.key, required this.email, required this.phoneNumber});
  bool checkPhone(String? phoneNumber) {
    if ((phoneNumber ?? "").isEmpty) {
      return false;
    }
    return true;
  }

  bool checkEmail(String? email) {
    if ((email ?? "").isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Center(
        child: Container(
          width: 324,
          height: 229,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 241, 229, 228),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                  checkPhone(phoneNumber) == true
                      ? "assets/images/mobie.png"
                      : (checkEmail(email) == true
                          ? "assets/images/gmail.png"
                          : "assets/images/erro.png"),
                  fit: BoxFit.fitHeight,
                  width: 100,
                  height: 100),
              const SizedBox(height: 16),
              Text(
                  checkPhone(phoneNumber) == true
                      ? "Mật khẩu của bạn đá đực gửi đến SĐT"
                      : (checkEmail(email) == true
                          ? "Mật khẩu của bạn đã được gửi đến email"
                          : "Rỗng"),
                  style: tStyle.paragraph16().w500().copyWith(
                        color: Hcm23Colors.colorTextTitle,
                      )),
              const SizedBox(height: 8),
              Text(
                  checkPhone(phoneNumber) == true
                      ? phoneNumber
                      : (checkEmail(email) == true ? email : "Rỗng"),
                  style: tStyle.paragraph16().w500().copyWith(
                        color: Hcm23Colors.colorBrand,
                      )),
              // const SizedBox(height: 16),
              // ElevatedButton(
              //   onPressed: () => Navigator.pop(context),
              //   child: const Text('Close'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../shared_ui/themes/colors.dart';
import '../../shared_ui/themes/text_styles.dart';

class LoginSuccessPopup extends StatelessWidget {
  const LoginSuccessPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 189,
      width: 342,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        // color: Colors.grey,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Đăng nhập không thành công",
            style: tStyle.paragraph18().w500().copyWith(
                  color: Hcm23Colors.colorTextTitle,
                ),
          ),
          Text(
            "Chức năng đăng nhập bằng TouchID/FaceID\ntạm thời không khả dụng! Bạn vui lòng sử dụng\nmật khẩu để đăng nhập.",
            textAlign: TextAlign.center,
            style: tStyle
                .paragraph14()
                .w400()
                .copyWith(color: Hcm23Colors.colorTextContent),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {},
            child: Ink(
              color: Hcm23Colors.colorBrand.withOpacity(0.1),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4.0),
                  ),
                ),
                width: 163,
                height: 40,
                child: Center(
                  child: Text("Đóng",
                      style: tStyle.display14().w500().copyWith(
                            color: Hcm23Colors.colorBrand,
                          )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

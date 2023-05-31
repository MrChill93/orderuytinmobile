// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../shared_ui/themes/colors.dart';
import '../../shared_ui/themes/text_styles.dart';

class UpdatePasswordPopup extends StatelessWidget {
  const UpdatePasswordPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 189,
      width: 342,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        // color: Colors.red,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/icons/update_password.svg"),
          const SizedBox(
            height: 32,
          ),
          Text(
            "Tài khoản hiện không tồn tại",
            style: tStyle.paragraph18().w500().copyWith(
                  color: Hcm23Colors.colorTextTitle,
                ),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../USER/home/home.dart';
import '../../../../../shared/constants.dart';
import '../../../../shared_ui/inputs/base_input/base_input.dart';
import '../../../../shared_ui/inputs/base_input/base_input_configs.dart';
import '../../../../shared_ui/themes/colors.dart';
import '../../../../shared_ui/themes/text_styles.dart';
import '../../data/api/user_repository.dart';
import '../../data/model/user_model.dart';

class ChangeUserProfilePage extends StatefulWidget {
  static const nameRoute = 'ChangeUserProfilePage';

  const ChangeUserProfilePage(
    Key? key,
    this.user,
  ) : super(key: key);
  final UserModel? user;

  @override
  State<ChangeUserProfilePage> createState() => _ChangeUserProfilePageState();
}

class _ChangeUserProfilePageState extends State<ChangeUserProfilePage> {
  late final TextEditingController birthday;
  late final TextEditingController userName;
  late final TextEditingController phone;
  late final TextEditingController age;
  late final TextEditingController address;
  late UserModel user; // sử dụng late-init property

  @override
  void initState() {
    userName = TextEditingController(text: widget.user?.userName);
    phone = TextEditingController(text: widget.user?.phone);
    address = TextEditingController(text: widget.user?.address);
    super.initState();
  }

  @override
  void dispose() {
    birthday.dispose();
    userName.dispose();
    phone.dispose();
    age.dispose();
    address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          title: const Center(
            child: Text(
              'Thay đổi thông tin cá nhân',
              style: TextStyle(color: Colors.black),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Avatar
                      Container(
                        height: 100,
                        width: 100,
                        color: Colors.black,
                      ),

                      // name
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Hcm23BaseInput(
                          baseConfigs: BaseInputConfigs(
                            customLabel: const Align(
                                alignment: Alignment.topLeft,
                                child: Text("Họ tên:")),
                            placeholderText: "Họ tên",
                            maxLines: 1,
                            controller: userName,
                          ),
                        ),
                      ),

                      // email
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Hcm23BaseInput(
                          baseConfigs: BaseInputConfigs(
                            customLabel: const Align(
                                alignment: Alignment.topLeft,
                                child: Text("Email:")),
                            placeholderText: "Email",
                            maxLines: 1,
                            enable: false,
                            // controller: email,
                            initialValue: widget.user?.email,
                          ),
                        ),
                      ),

                      // age
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Hcm23BaseInput(
                          baseConfigs: BaseInputConfigs(
                            customLabel: const Align(
                                alignment: Alignment.topLeft,
                                child: Text("Số điện thoại:")),
                            placeholderText: "0123456789",
                            maxLines: 1,
                            controller: phone,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                          ),
                        ),
                      ),

                      // dateofbirth
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Hcm23BaseInput(
                          baseConfigs: BaseInputConfigs(
                            customLabel: const Align(
                                alignment: Alignment.topLeft,
                                child: Text("Ngày sinh:")),
                            placeholderText: "dd/mm/yy",
                            maxLines: 1,
                            controller: birthday,
                          ),
                        ),
                      ),

                      // age
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Hcm23BaseInput(
                          baseConfigs: BaseInputConfigs(
                            customLabel: const Align(
                                alignment: Alignment.topLeft,
                                child: Text("Tuổi")),
                            placeholderText: "Age",
                            maxLines: 1,
                            enable: false,
                            controller: age,
                          ),
                        ),
                      ),

                      // creatday
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Hcm23BaseInput(
                          baseConfigs: BaseInputConfigs(
                            customLabel: const Align(
                                alignment: Alignment.topLeft,
                                child: Text("Ngày tạo:")),
                            placeholderText: "dd/mm/yy",
                            maxLines: 1,
                            enable: false,
                          ),
                        ),
                      ),

                      // address
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Hcm23BaseInput(
                          baseConfigs: BaseInputConfigs(
                            customLabel: const Align(
                                alignment: Alignment.topLeft,
                                child: Text("Địa chỉ:")),
                            maxLines: 1,
                            controller: address,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final now = DateTime.now();
                        final String id = UserRepoX.shared.userId$;
                        final currentUser = UserRepoX.shared.user;
                        final ref =
                            OrderuytinConfig.shared.database$.ref('users/$id');
                        final newUser = UserModel(
                          userName: userName.text,
                          email: currentUser.email,
                          address: address.text,
                          phone: phone.text,
                        );
                        await UserRepo.updateUserData(
                          userModel: newUser,
                          id: id,
                          onSuccess: (result) {
                            Navigator.of(context).pop(newUser);
                            Navigator.of(context).pushNamed(
                              HomePageOrder.nameRoute,
                              arguments: {'user': newUser},
                            );
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
                          width: 163,
                          height: 48,
                          child: Center(
                            child: Text("Cập Nhật",
                                style: tStyle.display14().w500().copyWith(
                                      color: Hcm23Colors.colorBrand,
                                    )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Ink(
                        decoration: const BoxDecoration(
                          color: Hcm23Colors.colorBrand,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                        ),
                        child: SizedBox(
                          width: 163,
                          height: 48,
                          child: Center(
                            child: Text("Tiếp theo",
                                style: tStyle.display14().w500().copyWith(
                                      color: Hcm23Colors.colorWhite,
                                    )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

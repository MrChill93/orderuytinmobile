// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';

import '../../../USER/home/home.dart';
import '../../../service/firebase/auth/fir_auth_repo.dart';
import '../../../shared/constants.dart';
import '../../shared_ui/btn/btn_default/btn_default.dart';
import '../../shared_ui/inputs/input_normal/input_normal_layout_mixin.dart';
import '../../shared_ui/themes/colors.dart';
import '../../shared_ui/themes/text_styles.dart';
import '../user/data/model/user_model.dart';
import 'bloc/register_bloc.dart';

class RegisterProvider extends StatelessWidget {
  const RegisterProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: const RegisterPage(),
    );
  }
}

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

// Getting value from TextField widget.
  late var phoneCtr = TextEditingController();
  late var addressCtr = TextEditingController();
  late var userNameCtr = TextEditingController();
  late var emailCtr = TextEditingController();
  late var passWordCtr = TextEditingController();
  late var rePassCtr = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _showHidePw() {
    setState(() {
      _hidePw = !_hidePw;
    });
  }

  Future<void> postData() async {
    String phone = phoneCtr.text;
    String address = addressCtr.text;
    String userName = userNameCtr.text;
    String rePassword = rePassCtr.text;
    String role = 'ROLE_USER';
    int STATUS = 1;
    // num? price = num.tryParse(priceCtr.text);
    // num? quantity = num.tryParse(qtyCtr.text);

    String url = 'http://localhost:8080/createAccount';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json =
        '{ "userId": null, "userName": "$userName", "rate":3500, "rateKg":30000,"rateM3" : 3200000,"address":"$addressCtr", "phone":"$phoneCtr","role":"ROLE_USER", "email":"$emailCtr", "password":"$passWordCtr", "rePassword" :"$rePassCtr", "STATUS" :1, "chargMoneyList": null,}';

    Response response =
        await post(Uri.parse(url), headers: headers, body: json);

    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  refresh() {
    setState(() {
      phoneCtr = TextEditingController();
      addressCtr = TextEditingController();
      userNameCtr = TextEditingController();
      emailCtr = TextEditingController();
      passWordCtr = TextEditingController();
      rePassCtr = TextEditingController();
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
                child: Image.asset(
                  "assets/images/register.png",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 150,
                ),
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
              TextFormField(
                controller: phoneCtr,
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.mobile_friendly),
                  labelText: 'Số điện thoại',
                  floatingLabelStyle:
                      TextStyle(color: Colors.black, fontSize: 20),
                  labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                  hintStyle: TextStyle(fontSize: 20.0, color: Colors.black),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black,
                  )),
                ),
                validator: (value) {
                  return (value!.isEmpty)
                      ? 'Số điện thoại không thể bỏ trống.'
                      : null;
                },
              ),
              TextFormField(
                controller: emailCtr,
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email',
                  floatingLabelStyle:
                      TextStyle(color: Colors.black, fontSize: 20),
                  labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                  hintStyle: TextStyle(fontSize: 20.0, color: Colors.black),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black,
                  )),
                ),
                validator: (value) {
                  return (value!.isEmpty) ? 'Email không thể bỏ trống.' : null;
                },
              ),
              TextFormField(
                controller: userNameCtr,
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Tên khách hàng',
                  floatingLabelStyle:
                      TextStyle(color: Colors.black, fontSize: 20),
                  labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                  hintStyle: TextStyle(fontSize: 20.0, color: Colors.black),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black,
                  )),
                ),
                validator: (value) {
                  return (value!.isEmpty)
                      ? 'Tên khách hàng không thể bỏ trống.'
                      : null;
                },
              ),
              TextFormField(
                controller: addressCtr,
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.home),
                  labelText: 'Địa chỉ ',
                  floatingLabelStyle:
                      TextStyle(color: Colors.black, fontSize: 20),
                  labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                  hintStyle: TextStyle(fontSize: 20.0, color: Colors.black),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black,
                  )),
                ),
                validator: (value) {
                  return (value!.isEmpty)
                      ? 'Địa chỉ khách hàng không thể bỏ trống.'
                      : null;
                },
              ),
              TextFormField(
                controller: passWordCtr,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password),
                  labelText: 'Mật khẩu',
                  suffixIcon: InkWell(
                    onTap: _showHidePw,
                    child: SvgPicture.asset(
                      _hidePw
                          ? "assets/icons/ui_kit/bold/hide.svg"
                          : "assets/icons/ui_kit/bold/show.svg",
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  floatingLabelStyle:
                      const TextStyle(color: Colors.black, fontSize: 20),
                  labelStyle:
                      const TextStyle(color: Colors.black, fontSize: 20),
                  hintStyle:
                      const TextStyle(fontSize: 20.0, color: Colors.black),
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black,
                  )),
                ),
                validator: (value) {
                  return (value!.isEmpty)
                      ? 'Mật khẩu không thể bỏ trống.'
                      : null;
                },
              ),
              TextFormField(
                controller: rePassCtr,
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  labelText: 'Nhập lại mật khẩu',
                  floatingLabelStyle:
                      TextStyle(color: Colors.black, fontSize: 20),
                  labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                  hintStyle: TextStyle(fontSize: 20.0, color: Colors.black),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black,
                  )),
                ),
                validator: (value) {
                  return (value!.isEmpty) ? 'Hãy nhập lại mật khẩu.' : null;
                },
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
            ],
          ),
        ),
      ),
    );
  }
}

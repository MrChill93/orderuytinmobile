// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orderuytinmobile/USER/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../service/firebase/auth/fir_auth_repo.dart';
import '../../../shared/global_bloclistener.dart';
import '../../shared_ui/btn/btn_default/btn_default.dart';
import '../../shared_ui/inputs/input_clear/input_clear.dart';
import '../../shared_ui/inputs/input_normal/input_normal_layout_mixin.dart';
import '../../shared_ui/themes/colors.dart';
import '../../shared_ui/themes/text_styles.dart';
import '../auth/auth_bloc.dart';
import 'bloc/login_bloc.dart';

class LoginProvider extends StatelessWidget {
  const LoginProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  // final int id;
  static const routeName = '/LoginPage';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final _bloc = context.read<LoginBloc>();
  //input controller
  final TextEditingController _usernameController =
      TextEditingController(text: "tung1234@gmail.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "123123");
  String _username = "";
  String _password = "";

  @override
  void initState() {
    super.initState();
    _loadAccount();
  }

  // Loading account value on start
  void _loadAccount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = (prefs.getString('_username') ?? "");
      _password = (prefs.getString('_password') ?? "");
    });
  }

  void saveAccountToLocaldb() async {
// Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

// Save an integer value to 'counter' key.
    await prefs.setString('_username', _usernameController.text);
    await prefs.setString('_password', _passwordController.text);
  }

  //hide and show password
  final bool _hidePw = false;
  final bool _isChecked = false;
//checked the store account checkbox
  // bool isChecked = false;

  void _showHidePw() {
    // setState(() {
    //   _hidePw = !_hidePw;
    // });
    _bloc.add(ToggleHidePwValue());
  }

  @override
  void dispose() {
    super.dispose();
  }

  FeedbackType feedbackType = FeedbackType.none;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  String? feedbackMessage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginInitial) {
          return GlobalBlocListener(
            child: Scaffold(
              appBar: AppBar(
                //make appbar transparent and hide shadow
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //image and title
                      Image.asset("assets/images/login.png"),
                      Text(
                        "Xin chào",
                        style: tStyle.paragraph18().w500().copyWith(
                              color: Hcm23Colors.colorTextTitle,
                            ),
                      ),
                      Text(
                        "Vui lòng đăng nhập để sử dụng ứng dụng",
                        style: tStyle
                            .paragraph14()
                            .w400()
                            .copyWith(color: Hcm23Colors.colorTextPhude),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //input username
                      InputClear(
                        controller: _usernameController,
                        placeholderText:
                            "Tài khoản là email bạn dùng để đăng kí tài khoản",
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
                        obscureText: state.hidePw,
                        decoration: InputDecoration(
                          prefixIcon: SvgPicture.asset(
                            "assets/icons/ui_kit/bold/lock.svg",
                            fit: BoxFit.scaleDown,
                          ),
                          suffixIcon: InkWell(
                            onTap: _showHidePw,
                            child: SvgPicture.asset(
                              (state.hidePw)
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
                        feedBackType: feedbackType,
                        feedbackMessage: feedbackMessage,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Quên mật khẩu?",
                                style: tStyle
                                    .display14()
                                    .w500()
                                    .copyWith(color: Hcm23Colors.color2),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                fillColor:
                                    MaterialStateProperty.resolveWith(getColor),
                                value: state.isChecked,
                                onChanged: (bool? value) {
                                  // setState(() {
                                  //   // state.isChecked = value!;
                                  //   saveAccountToLocaldb();
                                  // });
                                  // _bloc.add(ToggleIsCheckedValue());
                                  _bloc.add(ChangeIsCheckedValue(
                                      newCheckedState: value ?? false));
                                },
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Ghi nhớ tài khoản.",
                                  style: tStyle
                                      .display14()
                                      .w500()
                                      .copyWith(color: Hcm23Colors.color2),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      BtnDefault(
                        onTap: () async {
                          context.read<AuthBloc>().add(
                                AuthLoginEvent(
                                  email: _usernameController.text,
                                  password: _passwordController.text,
                                ),
                              );
                          await FirAuthRepo.signInWithEmailAndPassword(
                            email: _usernameController.text,
                            password: _passwordController.text,
                            onFailure: (p0) {
                              setState(() {
                                feedbackType = FeedbackType.error;
                                feedbackMessage = p0;
                              });
                            },
                            onSuccess: (p0) {
                              final id = p0.data?.user?.uid;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen(
                                          id: _usernameController.text)));
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => HomeScreen(
                                      id: _usernameController.text),
                                ),
                              );
                            },
                          );
                        },
                        title: "Đăng nhập",
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      RichText(
                          text: TextSpan(
                        text: "Chưa có tài khoản? ",
                        style: tStyle
                            .paragraph14()
                            .w400()
                            .copyWith(color: Hcm23Colors.colorTextPhude),
                        children: [
                          TextSpan(
                              text: "Đăng ký",
                              style: tStyle
                                  .display14()
                                  .w500()
                                  .copyWith(color: Hcm23Colors.color2),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _bloc.add(
                                      NavigateToRegisterPage(context: context));
                                }),
                        ],
                      )),

                      //face id and fingerprint
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //fingerprint
                          GestureDetector(
                            onTap: () {},
                            onTapCancel: () {},
                            child: Ink(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                                color: Hcm23Colors.color3.withOpacity(0.1),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          //face id
                          GestureDetector(
                            onTap: () {},
                            onTapCancel: () {},
                            child: Ink(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                                color: Hcm23Colors.color3.withOpacity(0.1),
                              ),
                              child: SvgPicture.asset(
                                "assets/icons/face_id.svg",
                                fit: BoxFit.scaleDown,
                                color: Hcm23Colors.color3,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(List<String> args) {
  runApp(const loginScreen());
}

class loginScreen extends StatelessWidget {
  const loginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
        iconTheme: const IconThemeData(color: Colors.purpleAccent),
        primaryTextTheme:
            const TextTheme(titleLarge: TextStyle(color: Colors.yellowAccent)),
        textTheme: Theme.of(context)
            .textTheme
            .apply(bodyColor: Colors.cyan, displayColor: Colors.yellowAccent),
        fontFamily: 'Monotype Coursiva',
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var dropdownvalue;

// Getting value from TextField widget.
  late var accountCtr = TextEditingController();
  late var passWordCtr = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final snackBar = const SnackBar(
    content: Text("Please fix the errors in red before submitting."),
  );

  @override
  void initState() {
    super.initState();
  }

  void login() async {
    if (accountCtr.text.isNotEmpty && passWordCtr.text.isNotEmpty) {
      var response =
          await http.post(Uri.parse('https://reqres.in/api/login'), body: {
        'email': accountCtr.text,
        'password': passWordCtr.text,
      });
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        // print("Login token" + body["token"]);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login token" + body["token"])));
        // Navigator.push(
        //     context, MaterialPageRoute(builder: ((context) => const Mine())));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Black Field Not Allowed"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // key: _formKey,
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: Container(
            color: Colors.black,
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: accountCtr,
                          style: const TextStyle(fontSize: 20),
                          decoration: const InputDecoration(
                            hintText:
                                "Hãy nhập số điện thoại đăng ký tài khoản zô đây !!!.",
                            labelText: 'Số điện thoại',
                            floatingLabelStyle: TextStyle(
                                color: Colors.yellowAccent, fontSize: 20),
                            labelStyle: TextStyle(
                                color: Colors.yellowAccent, fontSize: 20),
                            hintStyle: TextStyle(
                                fontSize: 20.0, color: Colors.yellowAccent),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.yellowAccent,
                            )),
                          ),
                          validator: (value) {
                            return (value!.isEmpty)
                                ? 'Số điện thoại không thể bỏ trống.'
                                : null;
                          },
                        ),
                        TextFormField(
                          controller: passWordCtr,
                          style: const TextStyle(fontSize: 20),
                          decoration: const InputDecoration(
                            hintText: "Hãy nhập mật khẩu zô đây !!!.",
                            labelText: 'Mật khẩu',
                            floatingLabelStyle: TextStyle(
                                color: Colors.yellowAccent, fontSize: 20),
                            labelStyle: TextStyle(
                                color: Colors.yellowAccent, fontSize: 20),
                            hintStyle: TextStyle(
                                fontSize: 20.0, color: Colors.yellowAccent),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.yellowAccent,
                            )),
                          ),
                          validator: (value) {
                            return (value!.isEmpty)
                                ? 'Mật khẩu không thể bỏ trống.'
                                : null;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.cyanAccent),
                          ),
                          onPressed: () {
                            login();
                          },
                          child: Container(
                            child: const Text(
                              'Đăng nhập',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ));
  }
}

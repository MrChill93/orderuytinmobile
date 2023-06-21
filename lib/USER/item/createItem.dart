import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../../presentation/features/auth/auth_bloc.dart';

class createItemPage extends StatefulWidget {
  const createItemPage({Key? key}) : super(key: key);

  @override
  State<createItemPage> createState() => _createItemPageState();
}

class _createItemPageState extends State<createItemPage> {
  // List<String> list = [];

  // Future<List<String>> getList() async {
  //   http.Response response =
  //       await http.get(Uri.parse("http://localhost:8080/users"));
  //   if (response.statusCode == 200) {
  //     var jsonData = json.decode(utf8.decode(response.bodyBytes)) as List;
  //     setState(() {
  //       for (var element in jsonData) {
  //         list.add(element["userName"]);
  //       }
  //     });

  //     return list;
  //   } else {
  //     throw response.statusCode;
  //   }
  // }

  // var dropdownvalue;

// Getting value from TextField widget.
  late var linkCtr = TextEditingController();
  late var desCtr = TextEditingController();
  late var priceCtr = TextEditingController();
  late var qtyCtr = TextEditingController();
  late var rateCtr = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  num rate = 3430;

  Future<void> buyNow(String userName) async {
    String link = linkCtr.text;
    String describle = desCtr.text;
    num? price = num.tryParse(priceCtr.text);
    num? quantity = num.tryParse(qtyCtr.text);

    String url = 'http://localhost:8080/createItem';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json =
        '{ "link": "$link",  "describle": "$describle", "price": $price, "quantity": $quantity, "itemStatus": "Cho xu ly", "image": "1686899092086image.png",  "CNYrateVND": 3430,"itemUserName": "$userName","userNote": null,"adminNote": null, "refundDate": null, "quantityRefund": null, "orderId": null} ';
    Response response =
        await post(Uri.parse(url), headers: headers, body: json);

    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
    setState(() {});
  }

Future<void> addCart(String userName) async {
    String link = linkCtr.text;
    String describle = desCtr.text;
    num? price = num.tryParse(priceCtr.text);
    num? quantity = num.tryParse(qtyCtr.text);

    String url = 'http://localhost:8080/addCart';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json =
        '{ "link": "$link",  "describle": "$describle", "price": $price, "quantity": $quantity, "itemStatus": "Gio hang", "image": "1686899092086image.png",  "CNYrateVND": 3430,"itemUserName": "$userName","userNote": null,"adminNote": null, "refundDate": null, "quantityRefund": null, "orderId": null} ';
    Response response =
        await post(Uri.parse(url), headers: headers, body: json);

    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    priceCtr.addListener(changesOnField);
    qtyCtr.addListener(changesOnField);
    // getList();
  }

  changesOnField() {
    setState(() {});
  }

  refresh() {
    setState(() {
      linkCtr = TextEditingController();
      desCtr = TextEditingController();
      priceCtr = TextEditingController();
      qtyCtr = TextEditingController();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
  final screenWidth = screenSize.width;
  final screenHeight = screenSize.height;
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthenticatedState) {
          return Scaffold(
            body: Container(
              color: Colors.black,
              child: Center(
                child: Form(
                  // key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 5, right: 35, left: 35),
                        margin: const EdgeInsets.all(5),
                        child: TextFormField(
                          controller: linkCtr,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.cyanAccent),
                          decoration: const InputDecoration(
                            hintText: "Hãy dán link zô đây !!!.",
                            labelText: 'Link',
                            floatingLabelStyle: TextStyle(color: Colors.yellowAccent, fontSize: 20),
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
                            return (value!.isEmpty)? 'Link sản phẩm không thể bỏ trống.': null;
                          },
                           keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.always,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 5, right: 35, left: 35),
                        margin: const EdgeInsets.all(5),
                        child: TextFormField(
                          controller: desCtr,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.cyanAccent),
                          decoration: const InputDecoration(
                            hintText:
                                "Hãy miêu tả sản phẩm rõ ràng , ngắn gọn.",
                            labelText: 'Miêu tả',
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
                                ? 'Miêu tả sản phẩm bắt buộc phải nhập .'
                                : null;
                          },
                              keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.always,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 5, right: 35, left: 35),
                        margin: const EdgeInsets.all(5),
                        child: TextFormField(
                          controller: priceCtr,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.cyanAccent),
                          decoration: const InputDecoration(
                            labelText: 'Giá (¥)',
                            hintText: "Hãy điền giá sản phẩm ",
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
                          // onSaved: (String? value) {},
                          validator: (value) {
                            return (value!.isEmpty)
                                ? 'Giá sản phẩm bắt buộc phải nhập .'
                                : null;
                          },
                          keyboardType: TextInputType.number,

                          autovalidateMode: AutovalidateMode.always,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 5, right: 35, left: 35),
                        margin: const EdgeInsets.all(5),
                        child: TextFormField(
                          controller: qtyCtr,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.cyanAccent),
                          decoration: const InputDecoration(
                            labelText: 'Số lượng',
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
                          // onSaved: (String? value) {},
                          validator: (value) {
                            return (value!.isEmpty)
                                ? 'Số lượng sản phẩm bắt buộc phải nhập.'
                                : null;
                          },
                          keyboardType: TextInputType.number,

                          autovalidateMode: AutovalidateMode.always,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 5, right: 35, left: 35),
                        margin: const EdgeInsets.all(5),
                        child: Text("Tỉ giá :         $rate  (VNĐ/¥)",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.yellowAccent,
                            )),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 5),
                        margin: const EdgeInsets.only(
                            top: 5, bottom: 5),
                        child: Row(
                          children: [
                            const Text("Thành tiền (tệ):       ",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.yellowAccent,
                                )),
                            SizedBox(
                              width: screenWidth * 0.59,
                              height: 28,
                              child: Text(
                                  "${(double.tryParse(priceCtr.text.trim()) ?? 1) * (double.tryParse(qtyCtr.text.trim()) ?? 1)} ",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellowAccent,
                                  )),
                            ),
                            const Text("¥ ",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.yellowAccent,
                                )),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 5),
                        margin: const EdgeInsets.only(
                            top: 5, bottom: 5),
                        child: Row(
                          children: [
                            const Text("Thành tiền (Việt): ",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.yellowAccent,
                                )),
                            SizedBox(
                                width: screenWidth * 0.59,
                                height: 28,
                                child: Text(
                                    "${(double.tryParse(priceCtr.text.trim()) ?? 1) * (double.tryParse(qtyCtr.text.trim()) ?? 1) * rate} ",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.yellowAccent,
                                    ))),
                            const Text("     đ",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.yellowAccent,
                                )),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.yellowAccent),
                            ),
                            onPressed: () {
                              addCart(state.user.userName ?? "");
                              refresh();
                            },
                            child: Container(
                              child: const Text(
                                'Thêm giỏ hàng',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.cyanAccent),
                            ),
                            onPressed: () {
                              buyNow(state.user.userName ?? "");
                              refresh();
                            },
                            child: Container(
                              child: const Text(
                                'Mua ngay ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
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

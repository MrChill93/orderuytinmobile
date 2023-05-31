import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main(List<String> args) {
  runApp(const createItem());
}

class createItem extends StatelessWidget {
  const createItem({super.key});

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
      home: const createItemPage(),
    );
  }
}

class createItemPage extends StatefulWidget {
  const createItemPage({Key? key}) : super(key: key);

  @override
  State<createItemPage> createState() => _createItemPageState();
}

class _createItemPageState extends State<createItemPage> {
  List<String> list = [];

  Future<List<String>> getList() async {
    http.Response response =
        await http.get(Uri.parse("http://localhost:8080/users"));
    if (response.statusCode == 200) {
      var jsonData = json.decode(utf8.decode(response.bodyBytes)) as List;
      setState(() {
        for (var element in jsonData) {
          list.add(element["userName"]);
        }
      });

      return list;
    } else {
      throw response.statusCode;
    }
  }

  var dropdownvalue;

// Getting value from TextField widget.
  late var linkCtr = TextEditingController();
  late var desCtr = TextEditingController();
  late var priceCtr = TextEditingController();
  late var qtyCtr = TextEditingController();
  late var rateCtr = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  num rate = 3500;

  Future<void> postData() async {
    String link = linkCtr.text;
    String describle = desCtr.text;
    num? price = num.tryParse(priceCtr.text);
    num? quantity = num.tryParse(qtyCtr.text);

    String url = 'http://localhost:8080/createItem';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json =
        '{ "link": "$link",  "describle": "$describle", "price": $price, "quantity": $quantity, "itemStatus": "Cho xu ly", "image": null,  "cnYrateVnd": 3500,"itemUserName": "$dropdownvalue","userNote": null,"adminNote": null, "refundDate": null, "quantityRefund": null, "orderId": null} ';
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
    getList();
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
    return Expanded(
      child: Scaffold(
        body: Container(
          color: Colors.black,
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(right: 30, left: 30),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: DropdownButton(
                        hint: const Text('Hãy chọn khách hàng'),
                        value: dropdownvalue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 12,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownvalue = value!;
                          });
                        },
                        items: list.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 5, right: 35, left: 35),
                    margin: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: linkCtr,
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                        hintText: "Hãy paste link zô đây !!!.",
                        labelText: 'Link',
                        floatingLabelStyle:
                            TextStyle(color: Colors.yellowAccent, fontSize: 20),
                        labelStyle:
                            TextStyle(color: Colors.yellowAccent, fontSize: 20),
                        hintStyle: TextStyle(
                            fontSize: 20.0, color: Colors.yellowAccent),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.yellowAccent,
                        )),
                      ),
                      validator: (value) {
                        return (value!.isEmpty)
                            ? 'Link sản phẩm không thể bỏ trống.'
                            : null;
                      },
                      autovalidateMode: AutovalidateMode.always,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 5, right: 35, left: 35),
                    margin: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: desCtr,
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                        hintText: "Hãy miêu tả sản phẩm rõ ràng , ngắn gọn.",
                        labelText: 'Miêu tả',
                        floatingLabelStyle:
                            TextStyle(color: Colors.yellowAccent, fontSize: 20),
                        labelStyle:
                            TextStyle(color: Colors.yellowAccent, fontSize: 20),
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
                      autovalidateMode: AutovalidateMode.always,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 5, right: 35, left: 35),
                    margin: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: priceCtr,
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                        labelText: 'Giá (¥)',
                        hintText: "Hãy điền giá sản phẩm ",
                        floatingLabelStyle:
                            TextStyle(color: Colors.yellowAccent, fontSize: 20),
                        labelStyle:
                            TextStyle(color: Colors.yellowAccent, fontSize: 20),
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
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                        labelText: 'Số lượng',
                        floatingLabelStyle:
                            TextStyle(color: Colors.yellowAccent, fontSize: 20),
                        labelStyle:
                            TextStyle(color: Colors.yellowAccent, fontSize: 20),
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
                    child: TextFormField(
                      controller: rateCtr,
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                        labelText: 'Tỉ giá',
                        floatingLabelStyle:
                            TextStyle(color: Colors.yellowAccent, fontSize: 20),
                        labelStyle:
                            TextStyle(color: Colors.yellowAccent, fontSize: 20),
                        hintStyle: TextStyle(
                            fontSize: 20.0, color: Colors.yellowAccent),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.yellowAccent,
                        )),
                      ),
                      validator: (value) {
                        return (value!.isEmpty)
                            ? 'Tỉ giá bắt buộc phải nhập.'
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
                    child: Row(
                      children: [
                        const Text("Thành tiền (tệ): ",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.yellowAccent,
                            )),
                        SizedBox(
                          width: 120,
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
                        top: 5, bottom: 5, right: 35, left: 35),
                    margin: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        const Text("Thành tiền (Việt): ",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.yellowAccent,
                            )),
                        SizedBox(
                            width: 120,
                            height: 28,
                            child: Text(
                                "${(double.tryParse(priceCtr.text.trim()) ?? 1) * (double.tryParse(qtyCtr.text.trim()) ?? 1) * rate} ",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellowAccent,
                                ))),
                        const Text(" đ ",
                            style: TextStyle(
                              fontSize: 20,
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
                        onPressed: () {},
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
                          postData();
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
      ),
    );
  }
}

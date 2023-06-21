import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../../models/Item.dart';

class complainItemScreen extends StatefulWidget {
  final int itemId;
  complainItemScreen({required this.itemId});

  @override
  State<complainItemScreen> createState() => _complainItemScreenState();
}

class _complainItemScreenState extends State<complainItemScreen> {
  // Getting value from TextField widget.
  late var userNoteCtr = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> complainOrder(int itemId) async {
    String userNote = userNoteCtr.text;

    String url =
        'http://localhost:8080/complainItem?itemId=$itemId&userNote=$userNote';

    try {
      final Response response = await http.put(Uri.parse(url));
      print(response.body);
    } catch (er) {}
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () { Navigator.of(context).pop();},
          color: Colors.black,
        ),
        backgroundColor: Colors.yellowAccent,
        title: const Text(
          'KHIẾU NẠI',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: 5, bottom: 5, right: 35, left: 35),
              margin: const EdgeInsets.all(5),
              child: TextFormField(
                controller: userNoteCtr,
                style:
                    const TextStyle(fontSize: 20, color: Colors.cyanAccent),
                decoration: const InputDecoration(
                  labelText: 'Nội dung khiếu nại',
                  floatingLabelStyle:
                      TextStyle(color: Colors.yellowAccent, fontSize: 20),
                  labelStyle:
                      TextStyle(color: Colors.yellowAccent, fontSize: 20),
                  hintStyle:
                      TextStyle(fontSize: 20.0, color: Colors.yellowAccent),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.yellowAccent,
                  )),
                ),
              
                // onSaved: (String? value) {},
                validator: (value) {
                  return (value!.isEmpty)
                      ? 'Hãy điền nội dung khiếu nại .'
                      : null;
                },
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.always,
              ),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.redAccent),
              ),
              onPressed: () {
                complainOrder(widget.itemId);
                Navigator.of(context).pop();
              },
              child: Container(
                child: const Text(
                  'Nộp khiếu nại ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

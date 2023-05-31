import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../models/orders.dart';
import '../../models/ordersmodel.dart';
import 'package:intl/intl.dart';

import '../../presentation/features/auth/auth_bloc.dart';

final oCcy = NumberFormat("###.00", "en_US");
final oCcVN = NumberFormat("###,###", "en_US");

class pendingOrderUserScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _pendingOrderUserScreenState();
  }
}

class _pendingOrderUserScreenState extends State<pendingOrderUserScreen> {
  List<Item>? items;
  // ItemList({super.key, required this.items});
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    setState(() {});
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthenticatedState) {
          return
          Scaffold(
        body: FutureBuilder(
      future: fetchDataPendingOrder(http.Client(),state.user.userName ?? ""),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            padding: const EdgeInsets.all(2.0),
            color: Colors.black,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                List<Item>? items = snapshot.data;
                num? itemPrice = items?[index].price;
                num? itemQuantity = items?[index].quantity;
                num? itemCNYrateVND = items?[index].cnYrateVnd;
                num? xiaojiYuan = itemPrice! * (itemQuantity!);
                num? xiaojiDun = itemPrice * (itemQuantity) * (itemCNYrateVND!);
                return Container(
                  margin: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(1.0),
                        child: Image.network(
                          fit: BoxFit.cover,
                          'http://www.orderuytin.com/image/item/${items?[index].image}',
                          width: 80,
                          height: 100,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                  
                            SizedBox(
                              width: 220,
                              child: Text("${items?[index].link}",
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Color.fromARGB(255, 243, 232, 200),
                                    fontSize: 12,
                                  )),
                            ),
                            Text("${items?[index].describle}",
                                style: const TextStyle(
                                  color: Colors.yellowAccent,
                                )),
                            Text(
                                "${oCcy.format(items?[index].price)}¥ x ${items?[index].quantity}  = ${oCcy.format(xiaojiYuan)} ¥ \n x ${items?[index].cnYrateVnd} đ/¥ = ${oCcVN.format(xiaojiDun)} đ",
                                style: const TextStyle(
                                    color: Colors.amber,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      }),
    ));

  } else {
          return Container();
        }
      },
    );
  }
}

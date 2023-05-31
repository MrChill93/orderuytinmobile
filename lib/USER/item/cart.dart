import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:orderuytinmobile/models/ordersmodel.dart';
import '../../models/orders.dart';
import '../../presentation/features/auth/auth_bloc.dart';

// void main(List<String> args) {
//   runApp(const Mine());
// }

// class Mine extends StatelessWidget {
//   const Mine({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.amber,
//         iconTheme: const IconThemeData(color: Colors.amber),
//         primaryTextTheme:
//             const TextTheme(titleLarge: TextStyle(color: Colors.black)),
//         textTheme: Theme.of(context)
//             .textTheme
//             .apply(bodyColor: Colors.black, displayColor: Colors.black),
//         fontFamily: 'Monotype Coursiva',
//       ),
//       home: const CartScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthenticatedState) {
          return Scaffold(
              body: SingleChildScrollView(
            child: FutureBuilder(
              future:
                  fetchDataItemInCart(http.Client(), state.user.userName ?? ""),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return ItemList(items: snapshot.data);
                }
                return const Center(child: CircularProgressIndicator());
              }),
            ),
          ));
        } else {
          return Container();
        }
      },
    );
  }
}

class ItemList extends StatelessWidget {
  List<Item>? items;

  //contructor
  ItemList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: items!.length,
        itemBuilder: (context, idx) {
          final oCcy = NumberFormat("###.00", "en_US");
          final oCcVN = NumberFormat("###,###", "en_US");
          final Item? item = items?[idx];
          num? itemPrice = item?.price;
          num? itemQuantity = item?.quantity;
          num? itemCNYrateVND = item?.cnYrateVnd;
          num? xiaojiYuan = itemPrice! * (itemQuantity!);
          num? xiaojiDun = itemPrice * (itemQuantity) * (itemCNYrateVND!);

          return GestureDetector(
              child: Container(
            padding: const EdgeInsets.all(2.0),
            color: Colors.black,
            child: Container(
                margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(1.0),
                      child: Image.network(
                        fit: BoxFit.cover,
                        'http://www.orderuytin.com/image/item/${item?.image}',
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
                            child: Text("${item?.link}",
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Color.fromARGB(255, 243, 232, 200),
                                  fontSize: 12,
                                )),
                          ),
                          Text("${item?.describle}",
                              style: const TextStyle(
                                color: Colors.yellowAccent,
                              )),
                          Text(
                              "${oCcy.format(item?.price)}¥ x ${item?.quantity}  = ${oCcy.format(xiaojiYuan)} ¥ \n x ${item?.cnYrateVnd} đ/¥ = ${oCcVN.format(xiaojiDun)} đ",
                              style: const TextStyle(
                                  color: Colors.amber,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                )),
          ));
        });
  }
}

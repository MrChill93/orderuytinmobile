import 'package:flutter/material.dart';
import 'package:orderuytinmobile/searchPage.dart';
import '../ADMIN/orderAdmin/fixOrderAdminScreen.dart';
import 'orderUser/arriveredOrderUserScreen.dart';
import 'orderUser/boughtOrderUserScreen.dart';
import 'orderUser/cancelOrderUserScreen.dart';
import 'orderUser/complainOrderUserScreen.dart';
import 'orderUser/deleveriedOrderUserScreen.dart';
import 'orderUser/finishedOrderUserScreen.dart';
import 'orderUser/pendingOrderUserScreen.dart';

void main(List<String> args) {
  runApp(const Mine());
}

class Mine extends StatelessWidget {
  const Mine({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
        iconTheme: const IconThemeData(color: Colors.amber),
        primaryTextTheme:
            const TextTheme(titleLarge: TextStyle(color: Colors.black)),
        textTheme: Theme.of(context)
            .textTheme
            .apply(bodyColor: Colors.black, displayColor: Colors.black),
        fontFamily: 'Monotype Coursiva',
      ),
      home: const OrdersPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  int currentTab = 0;
  late var findOrderCtr = TextEditingController();

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 8,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.yellowAccent,
                  ),
                  onPressed: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchPage()),
                    );
                  })),
            ],
            bottom: const TabBar(
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              labelColor: Colors.yellowAccent,
              tabs: [
                Tab(text: 'Tất\n cả'),
                Tab(text: 'Đợi\n nmua'),
                Tab(text: 'Đã\n mua'),
                Tab(text: 'Đã\n phát'),
                Tab(text: 'Về\n kho'),
                Tab(text: 'Khiếu\n nại'),
                Tab(text: 'Thành\n công'),
                Tab(text: 'Đơn\n huỷ'),
              ],
            ),
            backgroundColor: Colors.black,
          ),
          body: Container(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: TabBarView(
              children: [
                Center(
                  child: fixOrderAdminScreen(),
                ),
                Center(
                  child: pendingOrderUserScreen(),
                ),
                Center(
                  child: boughtOrderUserScreen(),
                ),
                Center(
                  child: deleveriedOrderUserScreen(),
                ),
                Center(
                  child: arriveredOrderUserScreen(),
                ),
                Center(
                  child: complainOrderUserScreen(),
                ),
                Center(
                  child: finishedOrderUserScreen(),
                ),
                Center(
                  child: cancelOrderUserScreen(),
                ),
              ],
            ),
          ),
        ),
      );
}

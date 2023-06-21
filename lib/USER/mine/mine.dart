import 'package:flutter/material.dart';
import 'package:infinite_scroll_tab_view/infinite_scroll_tab_view.dart';
import '../orderUser/arriveredOrderUserScreen.dart';
import '../orderUser/boughtOrderUserScreen.dart';
import '../orderUser/cancelOrderUserScreen.dart';
import '../orderUser/complainOrderUserScreen.dart';
import '../orderUser/deleveriedOrderUserScreen.dart';
import '../orderUser/finishedOrderUserScreen.dart';
import '../orderUser/pendingOrderUserScreen.dart';
import '../orderUser/wholeOrderUserScreen.dart';

class Mine extends StatelessWidget {
  const Mine({super.key});

  @override
  Widget build(BuildContext context) {
    return OrdersPage();
  }
}

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  int currentTab = 0;
  late var findOrderCtr = TextEditingController();
  final List<String> categories = [
    ' Đã\nphát',
    ' Về\nkho',
    'Thành\ncông',
    'Khiếu\n nại',
    'Đơn\nhuỷ',
    'Tất\n cả',
    'Đợi\nmua',
    ' Đã\nmua',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
        title: const Text(
          "ORDER UY TÍN",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: InfiniteScrollTabView(
          contentLength: categories.length,
          backgroundColor: Colors.black,
          tabBuilder: (index, isSelected) => Text(categories[index],
              style: TextStyle(
                  color: isSelected ? Colors.pink : Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          pageBuilder: (context, index, _) {
            if (index == 0) {
              return deleveriedOrderUserScreen();
            }
            if (index == 1) {
              return arriveredOrderUserScreen();
            }
            if (index == 2) {
              return finishedOrderUserScreen();
            }
            if (index == 3) {
              return complainOrderUserScreen();
            }
            if (index == 4) {
              return cancelOrderUserScreen();
            }
            if (index == 5) {
              return wholeOrdeUserScreen();
            }
            if (index == 6) {
              return pendingOrderUserScreen();
            }
            if (index == 7) {
              return boughtOrderUserScreen();
            }
            return const Text('HAHA');
          }),
    );
  }
}
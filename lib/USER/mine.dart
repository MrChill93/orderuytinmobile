import 'package:flutter/material.dart';
import 'package:infinite_scroll_tab_view/infinite_scroll_tab_view.dart';
import 'package:orderuytinmobile/searchPage.dart';
import 'orderUser/arriveredOrderUserScreen.dart';
import 'orderUser/boughtOrderUserScreen.dart';
import 'orderUser/cancelOrderUserScreen.dart';
import 'orderUser/complainOrderUserScreen.dart';
import 'orderUser/deleveriedOrderUserScreen.dart';
import 'orderUser/finishedOrderUserScreen.dart';
import 'orderUser/pendingOrderUserScreen.dart';
import 'orderUser/wholeOrderUserScreen.dart';

void main(List<String> args) {
  runApp(const Mine());
}

class Mine extends StatelessWidget {
  const Mine({super.key});

  @override
  Widget build(BuildContext context) {
    return OrdersPage();
  }
}

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key}) ;

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  int currentTab = 0;
  late var findOrderCtr = TextEditingController();
  final List<String> categories = [
    'Tất\n cả',
    'Đợi\nmua',
    ' Đã\nmua',
    ' Đã\nphát',
    ' Về\nkho',
    'Khiếu\n  nại',
    'Thành\ncông',
    'Đơn\nhuỷ'
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
     appBar: AppBar(
      backgroundColor: Colors.amber,
              title: const Text("ORDER UY TÍN",
              style:TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),),
            ),
      backgroundColor: Colors.black,
      body: InfiniteScrollTabView(
          contentLength: categories.length,
          backgroundColor: Colors.black,
          // onTabTap: (index) {
          //   debugPrint('You tapped: $index ');
          // },
          tabBuilder: (index, isSelected) => Text(categories[index],
              style: TextStyle(
                  color: isSelected ? Colors.pink : Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          pageBuilder: (context, index, _) {
            if (index == 0) {
              return  wholeOrdeUserScreen();
            }
            if (index == 1) {
              return  pendingOrderUserScreen();
            }
            if (index == 2) {
              return  boughtOrderUserScreen();
            }
            if (index == 3) {
              return  deleveriedOrderUserScreen();
            }
            if (index == 4) {
              return  arriveredOrderUserScreen();
            }
            if (index == 5) {
              return  complainOrderUserScreen();
            }
            if (index == 6) {
              return  finishedOrderUserScreen();
            }
             if (index == 7) {
              return  cancelOrderUserScreen();
            }
            return const Text('HAHA');
          }),
    );
  }
  // => DefaultTabController(
  //       length: 5,
  //       child: Scaffold(
  //         appBar: AppBar(
  //           actions: [
  //             IconButton(
  //                 icon: const Icon(
  //                   Icons.search,
  //                   color: Colors.yellowAccent,
  //                 ),
  //                 onPressed: (() {
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                         builder: (context) => const SearchPage()),
  //                   );
  //                 })),
  //           ],
  //           bottom:  const TabBar(
  //             labelStyle: TextStyle(fontWeight: FontWeight.w200,fontSize: 10),
  //             labelColor: Colors.yellowAccent,
  //             tabs: [
  //               Tab(text: "Tất\ncả"),
  //               Tab(text: 'Đợi\nmua'),
  //               Tab(text: 'Đã\nmua'),
  //               Tab(text: 'Đã\nphát'),
  //               Tab(text: 'Về\nkho'),
  //               Tab(text: 'Khiếu\nnại'),
  //               Tab(text: 'Thành\ncông'),
  //               Tab(text: 'Đơn\nhuỷ'),
  //             ],
  //           ),
  //           backgroundColor: Colors.black,
  //         ),
  //         body: Container(
  //           decoration: const BoxDecoration(
  //             color: Colors.black,
  //           ),
  //           child: TabBarView(
  //             children: [
  //               Center(
  //                 child: wholeOrdeUserScreen(),
  //               ),
  //               Center(
  //                 child: pendingOrderUserScreen(),
  //               ),
  //               Center(
  //                 child: boughtOrderUserScreen(),
  //               ),
  //               Center(
  //                 child: deleveriedOrderUserScreen(),
  //               ),
  //               Center(
  //                 child: arriveredOrderUserScreen(),
  //               ),
  //               Center(
  //                 child: complainOrderUserScreen(),
  //               ),
  //               Center(
  //                 child: finishedOrderUserScreen(),
  //               ),
  //               Center(
  //                 child: cancelOrderUserScreen(),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/features/auth/auth_bloc.dart';
import '../item/cart.dart';
import '../item/createItem.dart';
import '../mine.dart';

// void main(List<String> args) {
//   runApp(const homePageOrder());
// }

// class homePageOrder extends StatelessWidget {

//   const homePageOrder({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.amber,
//         iconTheme: const IconThemeData(color: Colors.purpleAccent),
//         primaryTextTheme:
//             const TextTheme(titleLarge: TextStyle(color: Colors.yellowAccent)),
//         textTheme: Theme.of(context)
//             .textTheme
//             .apply(bodyColor: Colors.cyan, displayColor: Colors.yellowAccent),
//         fontFamily: 'Monotype Coursiva',
//       ),
//       home: const HomePageOrder(),
//     );
//   }
// }

class HomePageOrder extends StatefulWidget {
  static const nameRoute = 'HomePage';
  final String id;
  const HomePageOrder({
    Key? key,
    required this.id,
    // required this.id,
  }) : super(key: key);

  @override
  State<HomePageOrder> createState() => _HomePageOrderState();
}

class _HomePageOrderState extends State<HomePageOrder> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> _screen = [
    const CartScreen(),
    const createItemPage(),
    const OrdersPage()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.black,
            key: _scaffoldKey,
            body: _screen[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.yellow,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart), label: "Giỏ hàng"),
            
                BottomNavigationBarItem(
                    icon: Icon(Icons.create), label: "Tạo đơn hàng"),
          
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Của tôi"),
              ],
              selectedItemColor: Colors.red,
              currentIndex: _currentIndex,
              unselectedItemColor: Colors.black,
              onTap: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
            ),
          );
      
  }
}

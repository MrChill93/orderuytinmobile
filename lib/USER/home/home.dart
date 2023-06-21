import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../models/orders.dart';
import '../../models/statistic.dart';
import '../../presentation/features/auth/auth_bloc.dart';
import '../item/cart.dart';
import '../item/createItem.dart';
import '../mine/home_of_mine.dart';
import '../mine/mine.dart';
import '../SpotgoodsPage/SpotgoodsPage.dart';

class HomeScreen extends StatefulWidget {
  static const nameRoute = 'HomeScreen';
  final String id;
  const HomeScreen({
    Key? key,
    required this.id,
    // required this.id,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;
  final GlobalKey<ScaffoldState> _scafKey = GlobalKey<ScaffoldState>();
  final List<Widget> _screen = [
    const SpotgoodsPage(),
    const CartScreen(),
    const createItemPage(),
    const HomeOfMine()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthenticatedState) {
          return   Container(
color:Colors.black,
      child: FutureBuilder(
      future: fetchStatisticsClient(http.Client(),state.user.userName ?? ""),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return  Scaffold(
      key: _scafKey,
      body: _screen[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.yellow,
        items: [
BottomNavigationBarItem(
            icon: Column(
              children: [
              Container(
                  width: 30,
                  child: const Text(''),
                ),
                const Icon(Icons.store, size: 32),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(text: 'Hàng sẵn' , style: TextStyle(fontWeight:FontWeight.bold,fontSize: 12.0)),
                    ],
                  ),
                ),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: [
                Container(
                  width: 30,
                  child:  Text((snapshot.data?.countCartItem??0).toString(),
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.red, fontWeight:FontWeight.bold,fontSize: 12.0)),
                ),
                const Icon(Icons.shopping_cart),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(text: 'Giỏ hàng',  style: TextStyle(fontWeight:FontWeight.bold,fontSize: 12.0)),
                    ],
                  ),
                ),
              ],
            ),
            label: '',
          ),
         BottomNavigationBarItem(
            icon: Column(
              children: [
             Container(
                  width: 30,
                  child: const Text('')
                ),
                const Icon(Icons.create),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(text: 'Tạo đơn hàng' , style: TextStyle(fontWeight:FontWeight.bold,fontSize: 12.0)),
                    ],
                  ),
                ),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: [
                Container(
                  width: 30,
                  child: const Text(''),
                ),
                const Icon(Icons.person),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(text: 'Của tôi' , style: TextStyle(fontWeight:FontWeight.bold,fontSize: 12.0)),
                    ],
                  ),
                ),
              ],
            ),
            label: '',
          ),
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
    
  Widget _buildCustomItem(Container icon) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () {
        // Xử lý sự kiện khi mục được nhấn
      },
      child: Padding(
        padding: EdgeInsets.all(0), // Bỏ padding
        child: icon,
      ),
    ),
  );
}
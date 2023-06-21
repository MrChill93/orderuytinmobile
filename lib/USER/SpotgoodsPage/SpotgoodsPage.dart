import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:orderuytinmobile/models/statistic.dart';
import 'package:http/http.dart' as http;
import '../../models/orders.dart';
import '../../presentation/features/auth/auth_bloc.dart';
import '../orderUser/cancelOrderUserScreen.dart';

class SpotgoodsPage extends StatefulWidget {
  const SpotgoodsPage({super.key});

  @override
  State<SpotgoodsPage> createState() => _SpotgoodsPageState();
}

class _SpotgoodsPageState extends State<SpotgoodsPage> {
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthenticatedState) {
          return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text("ORDER UY TÍN" ,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold, color: Colors.black)),
      ),
      body: FutureBuilder(
      future: fetchStatisticsClient(http.Client(),state.user.userName ?? ""),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body:Container(
              color: Colors.black,
              child:Center(child: Text('Tính năng này đang được phát triền ', style: TextStyle(color:Colors.yellowAccent,fontWeight:FontWeight.bold,fontSize: 12.0)))
            )
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

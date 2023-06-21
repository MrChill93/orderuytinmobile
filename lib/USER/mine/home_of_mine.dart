import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:orderuytinmobile/USER/mine/mine.dart';
import '../../models/orders.dart';
import '../../models/statistic.dart';
import '../../presentation/features/auth/auth_bloc.dart';
import '../SpotgoodsPage/SpotgoodsPage.dart';

class HomeOfMine extends StatefulWidget {
  const HomeOfMine({super.key});

  @override
  State<HomeOfMine> createState() => _HomeOfMineState();
}

class _HomeOfMineState extends State<HomeOfMine> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthenticatedState) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.yellow,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_rounded),
                  onPressed: () {},
                  color: Colors.yellow,
                ),
                title: const Text("ORDER UY TÍN",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ),
              body: FutureBuilder(
                future: fetchStatisticsClient(
                    http.Client(), state.user.userName ?? ""),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return StatisticScreen(
                      statistic: snapshot.data,
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

class StatisticScreen extends StatelessWidget {
  Statistic? statistic;
  StatisticScreen({super.key, required this.statistic});
  final vnd = NumberFormat("###,###", "vi_VI");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const Text('ĐƠN HÀNG',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellowAccent)),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Xử lý sự kiện khi phần tử được nhấn
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Mine()),
                    );
                  },
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 40,
                                child: Text(
                                    (statistic?.countWholeOrder ?? 0)
                                        .toString(),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent)),
                              ),
                              const Icon(Icons.window_sharp,
                                  color: Colors.yellow),
                              const Text('Tất cả',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber)),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: 40,
                                child: Text(
                                    (statistic?.countPendingItem ?? 0)
                                        .toString(),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent)),
                              ),
                              const Icon(Icons.alarm, color: Colors.yellow),
                              const Text('Chờ mua',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber)),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: 40,
                                child: Text(
                                    (statistic?.countBoughtOrder ?? 0)
                                        .toString(),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent)),
                              ),
                              const Icon(Icons.check, color: Colors.yellow),
                              const Text('Đã mua',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber)),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: 40,
                                child: Text(
                                    (statistic?.countDeliveredOrder ?? 0)
                                        .toString(),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent)),
                              ),
                              const Icon(Icons.local_shipping_outlined,
                                  color: Colors.yellow),
                              const Text('Đã phát',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 40,
                                child: Text(
                                    (statistic?.countArriveredOrder ?? 0)
                                        .toString(),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent)),
                              ),
                              const Icon(Icons.warehouse_outlined,
                                  color: Colors.yellow),
                              const Text('Về kho',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber)),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: 40,
                                child: Text(
                                    (statistic?.countComplainOrder ?? 0)
                                        .toString(),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent)),
                              ),
                              const Icon(Icons.feedback_outlined,
                                  color: Colors.yellow),
                              const Text('Khiếu nại',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber)),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: 40,
                                child: Text(
                                    (statistic?.countFinishedOrder ?? 0)
                                        .toString(),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent)),
                              ),
                              const Icon(Icons.emoji_emotions_outlined,
                                  color: Colors.yellow),
                              const Text('Thành công',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber)),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: 40,
                                child: Text(
                                    ((statistic?.countCancelOrder ?? 0) +
                                            (statistic?.countCancelItem ?? 0))
                                        .toString(),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent)),
                              ),
                              const Icon(Icons.delete_outline_outlined,
                                  color: Colors.yellow),
                              const Text('Đơn huỷ',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('THỐNG KÊ CÔNG NỢ',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow)),
              const SizedBox(height: 20),
                const Text('Từ ngày 01/01/02023 đến nay ',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow)),
                       const SizedBox(height: 10),
              Table(
                border: TableBorder.all(
                    color: Colors.white, style: BorderStyle.solid, width: 2),
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('TIỀN HÀNG',
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow)),
                          Text(' (CHI TIỂT)',
                              style: TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('TIỀN CƯỚC',
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow)),
                          Text(' (CHI TIỂT)',
                              style: TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Center(
                        child: Text('TỔNG PHÍ',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent)),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                            "${vnd.format((statistic!.sumTotalVNUser))}",
                            style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                            "${vnd.format((statistic!.sumTotalFreightUser))}",
                            style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                            "${vnd.format(((statistic!.sumTotalVNUser) + (statistic!.sumTotalFreightUser)))}",
                            style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow)),
                      ),
                    ),
                  ]),
                ],
              ),
              const SizedBox(height: 50),
              Table(
                border: TableBorder.all(
                    color: Colors.white, style: BorderStyle.solid, width: 2),
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('TIỀN ĐÃ NẠP',
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow)),
                          Text(' (CHI TIỂT)',
                              style: TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('TIỀN HOÀN',
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow)),
                          Text(' (CHI TIỂT)',
                              style: TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Center(
                        child: Text('TỔNG CÓ',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent)),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Text("${vnd.format((statistic!.sumAmountUser))}",
                            style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                            "${vnd.format((statistic!.sumReFundVNUser ?? 0))}",
                            style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                            "${vnd.format(((statistic!.sumAmountUser) + (statistic!.sumReFundVNUser ?? 0)))}",
                            style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow)),
                      ),
                    ),
                  ]),
                ],
              ),
              const SizedBox(height: 20),
              Table(
                border: TableBorder.all(
                    color: Colors.white, style: BorderStyle.solid, width: 2),
                children: [
                  TableRow(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 2),
                        color: Colors.red,
                      ),
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Center(
                            child: Text('CÒN NỢ',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellow)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Center(
                            child: Text(
                                "${vnd.format(((statistic!.sumTotalVNUser) + (statistic!.sumTotalFreightUser) - (statistic!.sumAmountUser) + (statistic!.sumReFundVNUser ?? 0)))}",
                                style: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellow)),
                          ),
                        ),
                      ]),
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

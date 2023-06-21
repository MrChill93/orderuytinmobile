import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../models/orders.dart';
import '../../models/ordersmodel.dart';
import 'package:intl/intl.dart';

import '../../presentation/features/auth/auth_bloc.dart';

class wholeOrdeUserScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _wholeOrdeUserScreenState();
}

class _wholeOrdeUserScreenState extends State<wholeOrdeUserScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthenticatedState) {
          return Scaffold(
            
              body: FutureBuilder(
            future: fetchDataOrder(http.Client(), state.user.userName ?? ""),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return OrdersList(orders: snapshot.data);
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

class OrdersList extends StatelessWidget {
  List<Order>? orders;

  //contructor
  OrdersList({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
     final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    // TODO: implement build
    return ListView.builder(
        shrinkWrap: true,
        itemCount: orders!.length,
        itemBuilder: (context, idx) {
          final oCcy = NumberFormat("###.00", "en_US");
          final oCcVN = NumberFormat("###,###", "en_US");
          num? totalItemCny = 0;
          num? totalItemVnd = 0;
          num? totalFreight = 0;
          num? shipFeeCny = orders![idx].shipFeeCny;
          num? shipFeeVnd = orders![idx].shipFeeVnd;
          num? total;
          num? totalVN = orders![idx].totalVn;

          if (shipFeeCny == null) {
            shipFeeCny = 0;
          } else {
            shipFeeCny = orders![idx].shipFeeCny;
          }

          if (shipFeeVnd == null) {
            shipFeeVnd = 0;
          } else {
            shipFeeVnd = orders![idx].shipFeeVnd;
          }

          for (int i = 0; i < orders![idx].items.length; i++) {
            num? orderPrice = orders?[idx].items[i].price;
            num? orderQuantity = orders?[idx].items[i].quantity;
            num? ordercnYrateVnd = orders?[idx].items[i].cnYrateVnd;
            totalItemCny = totalItemCny! + orderPrice! * orderQuantity!;
            totalItemVnd = totalItemCny * ordercnYrateVnd!;
          }

          for (int j = 0; j < orders![idx].waybills.length; j++) {
            num? freight = orders?[idx].waybills[j].freight;
            if (freight == null) {
              freight = 0;
            } else {
              if (totalFreight == null) {
                totalFreight = 0;
              } else {
                totalFreight = totalFreight + freight;
              }
            }
          }

          if (totalVN == null) {
            totalVN = 0;
          } else {
            total = totalFreight! + totalVN;
          }

          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return Container(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.95),
                      padding: const EdgeInsets.all(5.0),
                      color: Colors.black,
                      child: Container(
                        margin: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        DateFormat('yyyy-MM-dd')
                                            .format(orders?[idx].receivedDate),
                                        style: const TextStyle(
                                            color: Colors.yellowAccent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.0)),
                                            Text(
                                        '${orders?[idx].orderStatus}',
                                        style: const TextStyle(
                                            color: Colors.yellowAccent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.0)),
                                    Text('${orders?[idx].orderNo}',
                                        style: const TextStyle(
                                            color: Colors.yellowAccent,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.0)),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Table(
                                  border: TableBorder.all(
                                      color: Colors.white,
                                      style: BorderStyle.solid,
                                      width: 2),
                                  children: const [
                                    TableRow(children: [
                                      Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Center(
                                          child: Text('MÃ VĐ',
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.amber)),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Center(
                                          child: Text('Thành tiền',
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.amber)),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(3.0),
                                        child: Center(
                                          child: Text('KG',
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.amber)),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(3.0),
                                        child: Center(
                                          child: Text('M3',
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.amber)),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(3.0),
                                        child: Center(
                                          child: Text(
                                            'Ngày về ',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.amber),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ]),
                              SizedBox(
                                width: 400,
                                child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: orders?[idx].waybills.length,
                                    itemBuilder: (context, index) {
                                      num? freight =
                                          orders![idx].waybills[index].freight;
                                      if (freight == null) {
                                        freight = 0;
                                      } else {
                                        freight = orders![idx]
                                            .waybills[index]
                                            .freight;
                                      }
                                      final WayBills? waybill =
                                          orders?[idx].waybills[index];
                                      return Table(
                                        border: TableBorder.all(
                                            color: Colors.white,
                                            style: BorderStyle.solid,
                                            width: 2),
                                        children: [
                                          TableRow(children: [
                                            Column(children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                    '${orders?[idx].waybills[index].wayBillCode}',
                                                    style: const TextStyle(
                                                        fontSize: 9.0,
                                                        color: Colors.amber)),
                                              )
                                            ]),
                                            Column(children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: Text(
                                                      oCcVN.format(freight),
                                                      style: const TextStyle(
                                                          fontSize: 12.0,
                                                          color: Colors.amber)),
                                                ),
                                              )
                                            ]),
                                            Column(children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Text(
                                                    '${orders?[idx].waybills[index].kg}',
                                                    style: const TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.amber)),
                                              )
                                            ]),
                                            Column(children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Text(
                                                    '${orders?[idx].waybills[index].cubic}',
                                                    style: const TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.amber)),
                                              )
                                            ]),
                                            Column(children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Text(
                                                    (orders![idx]
                                                                .waybills[index]
                                                                .arriveredDate
                                                                .toString() ==
                                                            'null')
                                                        ? 'Chưa về'
                                                        : orders![idx]
                                                            .waybills[index]
                                                            .arriveredDate
                                                            .toString()
                                                            .substring(0, 10),
                                                    style: const TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.amber)),
                                              )
                                            ]),
                                          ]),
                                        ],
                                      );
                                    }),
                              ),
                              Row(
                                children: [
                                  const Text('Tổng cước',
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.amber)),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(oCcVN.format(totalFreight),
                                      style: const TextStyle(
                                          fontSize: 12.0, color: Colors.amber))
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: screenWidth * 0.9,
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: orders?[idx].items.length,
                                      itemBuilder: (context, index) {
                                        final Item? item =
                                            orders?[idx].items[index];
                                        num? itemPrice = item?.price;
                                        num? itemQuantity = item?.quantity;
                                        num? itemQuantityRefund =
                                            item?.quantityRefund;
                                        num? itemCNYrateVND = item?.cnYrateVnd;
                                        num? xiaojiYuan =
                                            itemPrice! * (itemQuantity!);
                                        num? xiaojiDun = itemPrice *
                                            (itemQuantity) *
                                            (itemCNYrateVND!);
                                        num? tuikuanDun = itemPrice *
                                            (itemQuantityRefund ?? 0) *
                                            (itemCNYrateVND);
                                        return Container(
                                          margin: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: Row(
                                            children: [
                                              Container(
                                                margin:
                                                    const EdgeInsets.all(1.0),
                                                child: Image.network(
                                                  fit: BoxFit.cover,
                                                  'http://www.orderuytin.com/image/item/${item?.image}',
                                                  width: 80,
                                                  height: 120,
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: 220,
                                                      child: Text(
                                                          "${item?.link}",
                                                          style:
                                                              const TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    243,
                                                                    232,
                                                                    200),
                                                            fontSize: 12,
                                                          )),
                                                    ),
                                                    Text("${item?.describle}",
                                                        style: const TextStyle(
                                                          color: Colors
                                                              .yellowAccent,
                                                        )),
                                                    Text(
                                                        "${oCcy.format(item?.price)}¥ x ${item?.quantity}  = ${oCcy.format(xiaojiYuan)} ¥ \n x ${item?.cnYrateVnd} đ/¥ = ${oCcVN.format(xiaojiDun)} đ",
                                                        style: const TextStyle(
                                                            color: Colors.amber,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    
                                                    Text(
                                                        "Số lg hoàn tiền: ${item?.quantityRefund ?? 0}",
                                                        style: const TextStyle(
                                                          color: Colors
                                                              .yellowAccent,
                                                        )),
                                                    Text(
                                                        "Giá trị tiền hoàn: ${oCcVN.format(tuikuanDun)} đ",
                                                        style: const TextStyle(
                                                          color: Colors
                                                              .yellowAccent,
                                                        )),
                                                        Text(
                                                        item?.userNote == null
                                                            ? ''
                                                            : ('Khiếu nại :' +
                                                                '${item?.userNote}'),
                                                        style: const TextStyle(
                                                          color: Colors.red,
                                                        )),
                                                    Text(
                                                        item?.adminNote == null
                                                            ? ''
                                                            : ('Phản hồi :' +
                                                                '${item?.adminNote}'),
                                                        style: const TextStyle(
                                                          color:
                                                              Colors.cyanAccent,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                              "TỔNG đơn hàng ( KHÔNG Ship nđ)",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                              " ${oCcy.format(totalItemCny)}¥ ",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Text(
                                              " ( ${oCcVN.format(totalItemVnd)} đ )",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              )),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Text("Ship nđ  ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold)),
                                          Text("${oCcy.format(shipFeeCny)} ¥  ",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Text(
                                              " ( ${oCcVN.format(shipFeeVnd)} đ )",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              )),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Text(
                                              "TỔNG đơn hàng (CÓ Ship nđ) ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                              " ${oCcy.format(orders?[idx].totalCn)}¥ ",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Text(
                                              "(${oCcVN.format(orders?[idx].totalVn)}đ) ",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              )),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Text(
                                              "TỔNG giá trị đơn hàng (+cước) ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold)),
                                          Text("${oCcVN.format(total)}đ ",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
            child: Container(
              padding: const EdgeInsets.all(5.0),
              color: Colors.black,
              child: Container(
                margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              DateFormat('yyyy-MM-dd')
                                  .format(orders?[idx].receivedDate),
                              style: const TextStyle(
                                  color: Colors.yellowAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0)),
                                   Text(
                             '${orders?[idx].orderStatus}',
                              style: const TextStyle(
                                  color: Colors.yellowAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0)),
                          Text('${orders?[idx].orderNo}',
                              style: const TextStyle(
                                  color: Colors.yellowAccent,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0)),
                        ],
                      ),
                    ),
                  
                   
                     Row(
                      children: [
                        const Text('Tổng cước',
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.amber)),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(oCcVN.format(totalFreight),
                            style: const TextStyle(
                                fontSize: 12.0, color: Colors.amber))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: screenWidth*0.9,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: orders?[idx].items.length,
                            itemBuilder: (context, index) {
                              final Item? item = orders?[idx].items[index];
                              num? itemPrice = item?.price;
                              num? itemQuantity = item?.quantity;
                              num? itemCNYrateVND = item?.cnYrateVnd;
                              num? xiaojiYuan = itemPrice! * (itemQuantity!);
                              num? xiaojiDun = itemPrice *
                                  (itemQuantity) *
                                  (itemCNYrateVND!);
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(1.0),
                                        child: Image.network(
                                          fit: BoxFit.cover,
                                          'http://www.orderuytin.com/image/item/${item?.image}',
                                          width: 60,
                                          height: 80,
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                           
                                            Text("${item?.describle}",
                                                style: const TextStyle(
                                                  color: Colors.yellowAccent,
                                                )),
                                            Text(
                                                "${oCcy.format(item?.price)}¥x ${item?.quantity} =${oCcy.format(xiaojiYuan)}¥ \nx ${item?.cnYrateVnd} đ/¥ = ${oCcVN.format(xiaojiDun)}đ",
                                                style: const TextStyle(
                                                    color: Colors.amber,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                ],
                              );
                            },
                          ),
                        ),
                       
                         
                     
                      ],
                    ),
                     Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                              "TỔNG đơn hàng ( KHÔNG Ship nđ)",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                              " ${oCcy.format(totalItemCny)}¥ ",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Text(
                                              " ( ${oCcVN.format(totalItemVnd)} đ )",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              )),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Text("Ship nđ  ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold)),
                                          Text("${oCcy.format(shipFeeCny)} ¥  ",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Text(
                                              " ( ${oCcVN.format(shipFeeVnd)} đ )",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              )),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Text(
                                              "TỔNG đơn hàng (CÓ Ship nđ) ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                              " ${oCcy.format(orders?[idx].totalCn)}¥ ",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Text(
                                              "(${oCcVN.format(orders?[idx].totalVn)}đ) ",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              )),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Text(
                                              "TỔNG giá trị đơn hàng (+cước) ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold)),
                                          Text("${oCcVN.format(total)}đ ",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

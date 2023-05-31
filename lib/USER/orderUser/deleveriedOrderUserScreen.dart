import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/orders.dart';
import '../../models/ordersmodel.dart';
import 'package:intl/intl.dart';

class deleveriedOrderUserScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _deleveriedOrderUserScreenState();
}

class _deleveriedOrderUserScreenState extends State<deleveriedOrderUserScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: FutureBuilder(
      future: fetchDataDeleveriedOrder(http.Client()),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return OrdersList(orders: snapshot.data);
        }
        return const Center(child: CircularProgressIndicator());
      }),
    ));
  }
}

class OrdersList extends StatelessWidget {
  List<Order>? orders;

  //contructor
  OrdersList({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
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
                    Row(
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
                        Text('${orders?[idx].orderNo}',
                            style: const TextStyle(
                                color: Colors.yellowAccent,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0)),
                        Text('${orders?[idx].orderUserName}',
                            style: const TextStyle(
                                color: Colors.yellowAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0)),
                      ],
                    ),
                    SizedBox(
                      width: 400,
                      child: Table(
                          border: TableBorder.all(
                              color: Colors.white,
                              style: BorderStyle.solid,
                              width: 2),
                          children: [
                            TableRow(children: [
                              Column(children: const [
                                Text('运单号',
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.amber))
                              ]),
                              Column(children: const [
                                Text('小计',
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.amber))
                              ]),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Column(children: const [
                                  Text('KG',
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.amber))
                                ]),
                              ),
                              Column(children: const [
                                Text('M3',
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.amber))
                              ]),
                              Column(children: const [
                                Text(
                                  'KG汇率',
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.amber),
                                )
                              ]),
                              Column(children: const [
                                Text('M3汇率',
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.amber))
                              ]),
                              Column(children: const [
                                Text('',
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.amber))
                              ]),
                            ]),
                          ]),
                    ),
                    SizedBox(
                      width: 400,
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: orders?[idx].waybills.length,
                          itemBuilder: (context, index) {
                            num? freight = orders![idx].waybills[index].freight;
                            if (freight == null) {
                              freight = 0;
                            } else {
                              freight = orders![idx].waybills[index].freight;
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
                                    Text(
                                        '${orders?[idx].waybills[index].wayBillCode}',
                                        style: const TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.amber))
                                  ]),
                                  Column(children: [
                                    Text(oCcVN.format(freight),
                                        style: const TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.amber))
                                  ]),
                                  Column(children: [
                                    Text('${orders?[idx].waybills[index].kg}',
                                        style: const TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.amber))
                                  ]),
                                  Column(children: [
                                    Text(
                                        '${orders?[idx].waybills[index].cubic}',
                                        style: const TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.amber))
                                  ]),
                                  Column(children: [
                                    Text(
                                        oCcVN.format(orders?[idx]
                                            .waybills[index]
                                            .rateKg),
                                        style: const TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.amber))
                                  ]),
                                  Column(children: [
                                    Text(
                                        oCcVN.format(orders?[idx]
                                            .waybills[index]
                                            .rateCubic),
                                        style: const TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.amber))
                                  ]),
                                  Column(children: const [
                                    Text('取消',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.amber))
                                  ]),
                                ]),
                              ],
                            );
                          }),
                    ),
                    SizedBox(
                      width: 400,
                      child: Table(
                          border: TableBorder.all(
                              color: Colors.white,
                              style: BorderStyle.solid,
                              width: 2),
                          children: [
                            TableRow(children: [
                              Column(children: const [
                                Text('合计',
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.amber))
                              ]),
                              Column(children: [
                                Text(oCcVN.format(totalFreight),
                                    style: const TextStyle(
                                        fontSize: 12.0, color: Colors.amber))
                              ]),
                              Column(children: const [
                                Text('',
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.amber))
                              ]),
                              Column(children: const [
                                Text('',
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.amber))
                              ]),
                              Column(children: const [
                                Text('',
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.amber))
                              ]),
                              Column(children: const [
                                Text('',
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.amber))
                              ]),
                              Column(children: const [
                                Text('',
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.amber))
                              ]),
                            ]),
                          ]),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 280,
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
                                          width: 80,
                                          height: 100,
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 220,
                                              child: Text("${item?.link}",
                                                  style: const TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    color: Color.fromARGB(
                                                        255, 243, 232, 200),
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
                        SizedBox(
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      const Text("商品总价:",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 8,
                                          )),
                                      Text(" ${oCcy.format(totalItemCny)}¥ ",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ],
                                  ),
                                  Text(" ( ${oCcVN.format(totalItemVnd)} đ )",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      )),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text("运费 :  ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      )),
                                  Text("${oCcy.format(shipFeeCny)} ¥  ",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                              Text(" ( ${oCcVN.format(shipFeeVnd)} đ )",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  )),
                              Row(
                                children: [
                                  const Text("合计 :  ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      )),
                                  Text(
                                      " ${oCcy.format(orders?[idx].totalCn)}¥ ",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                              Text("(${oCcVN.format(orders?[idx].totalVn)}đ) ",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  )),
                              Row(
                                children: [
                                  const Text("总计 : ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      )),
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

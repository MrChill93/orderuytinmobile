import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/orders.dart';
import '../../models/ordersmodel.dart';
import 'package:intl/intl.dart';

final oCcy = NumberFormat("###.00", "en_US");
final oCcVN = NumberFormat("###,###", "en_US");

class cancelOrderUserScreen extends StatefulWidget {
  @override
  State<cancelOrderUserScreen> createState() => _cancelOrderUserScreenState();
}

class _cancelOrderUserScreenState extends State<cancelOrderUserScreen> {
  List<Item>? items;
  List<Order>? orders;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    setState(() {});
  }

  onDeleteItem(int itemId) async {
    await fetchDeleteItem(http.Client(), itemId);

    setState(() {
      fetchDataCancelItem(http.Client());
      fetchDataCancelOrder(http.Client());
    });
  }

  onDeleteOrder(int orderId) async {
    await fetchDeleteOrder(http.Client(), orderId);

    setState(() {
      fetchDataCancelItem(http.Client());
      fetchDataCancelOrder(http.Client());
    });
  }

  onRefundItem(int itemId) async {
    await putRefundItem(itemId);

    setState(() {
      fetchDataCancelOrder(http.Client());
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FutureBuilder(
            future: fetchDataCancelItem(http.Client()),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  padding: const EdgeInsets.all(2.0),
                  color: Colors.black,
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          List<Item>? items = snapshot.data;
                          num? itemPrice = items?[index].price;
                          num? itemQuantity = items?[index].quantity;
                          num? itemCNYrateVND = items?[index].cnYrateVnd;
                          num? xiaojiYuan = itemPrice! * (itemQuantity!);
                          num? xiaojiDun =
                              itemPrice * (itemQuantity) * (itemCNYrateVND!);
                          return Container(
                            margin: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(1.0),
                                  child: Image.network(
                                    fit: BoxFit.cover,
                                    'http://www.orderuytin.com/image/item/${items?[index].image}',
                                    width: 80,
                                    height: 100,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                              style: ButtonStyle(
                                                foregroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Colors.redAccent),
                                              ),
                                              onPressed: () async {
                                                onDeleteItem(
                                                    items![index].itemId);
                                              },
                                              child: const Text('取消')),
                                          TextButton(
                                              style: ButtonStyle(
                                                foregroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.green),
                                              ),
                                              onPressed: () async {
                                                onRefundItem(
                                                    items![index].itemId);
                                              },
                                              child: const Text('恢复')),
                                          Text("${items?[index].itemUserName}",
                                              style: const TextStyle(
                                                color: Colors.amber,
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 220,
                                        child: Text("${items?[index].link}",
                                            style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: Color.fromARGB(
                                                  255, 243, 232, 200),
                                              fontSize: 12,
                                            )),
                                      ),
                                      Text("${items?[index].describle}",
                                          style: const TextStyle(
                                            color: Colors.yellowAccent,
                                          )),
                                      Text(
                                          "${oCcy.format(items?[index].price)}¥ x ${items?[index].quantity}  = ${oCcy.format(xiaojiYuan)} ¥ \n x ${items?[index].cnYrateVnd} đ/¥ = ${oCcVN.format(xiaojiDun)} đ",
                                          style: const TextStyle(
                                              color: Colors.amber,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }),
          ),
          FutureBuilder(
            future: fetchDataCancelOrder(http.Client()),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  padding: const EdgeInsets.all(1.0),
                  color: Colors.black,
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, idx) {
                            List<Order>? orders = snapshot.data;
                            num? totalItemCny = 0;
                            num? totalItemVnd = 0;
                            num? shipFeeCny = orders![idx].shipFeeCny;
                            num? shipFeeVnd = orders[idx].shipFeeVnd;

                            if (shipFeeCny == null) {
                              shipFeeCny = 0;
                            } else {
                              shipFeeCny = orders[idx].shipFeeCny;
                            }

                            if (shipFeeVnd == null) {
                              shipFeeVnd = 0;
                            } else {
                              shipFeeVnd = orders[idx].shipFeeVnd;
                            }

                            for (int i = 0; i < orders[idx].items.length; i++) {
                              num? orderPrice = orders[idx].items[i].price;
                              num? orderQuantity =
                                  orders[idx].items[i].quantity;
                              num? ordercnYrateVnd =
                                  orders[idx].items[i].cnYrateVnd;
                              totalItemCny =
                                  totalItemCny! + orderPrice! * orderQuantity!;
                              totalItemVnd = totalItemCny * ordercnYrateVnd!;
                            }
                            return GestureDetector(
                              child: Container(
                                padding: const EdgeInsets.all(2.0),
                                color: Colors.black,
                                child: Container(
                                  margin: const EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                              DateFormat('yyyy-MM-dd').format(
                                                  orders[idx].receivedDate),
                                              style: const TextStyle(
                                                  color: Colors.yellowAccent,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.0)),
                                          TextButton(
                                              style: ButtonStyle(
                                                foregroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Colors.redAccent),
                                              ),
                                              onPressed: () async {
                                                onDeleteOrder(
                                                    orders[idx].orderId);
                                              },
                                              child: const Text('取消')),
                                          Text('${orders[idx].orderNo}',
                                              style: const TextStyle(
                                                  color: Colors.yellowAccent,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.0)),
                                          Text('${orders[idx].orderUserName}',
                                              style: const TextStyle(
                                                  color: Colors.yellowAccent,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.0)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 300,
                                            child: ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount:
                                                  orders[idx].items.length,
                                              itemBuilder: (context, index) {
                                                final Item item =
                                                    orders[idx].items[index];
                                                num? itemPrice = item.price;
                                                num? itemQuantity =
                                                    item.quantity;
                                                num? itemCNYrateVND =
                                                    item.cnYrateVnd;
                                                num? xiaojiYuan = itemPrice! *
                                                    (itemQuantity!);
                                                num? xiaojiDun = itemPrice *
                                                    (itemQuantity) *
                                                    (itemCNYrateVND!);
                                                return Row(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              1.0),
                                                      child: Image.network(
                                                        fit: BoxFit.cover,
                                                        'http://www.orderuytin.com/image/item/${item.image}',
                                                        width: 80,
                                                        height: 100,
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
                                                                "${item.link}",
                                                                style:
                                                                    const TextStyle(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          243,
                                                                          232,
                                                                          200),
                                                                  fontSize: 12,
                                                                )),
                                                          ),
                                                          Text(
                                                              "${item.describle}",
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .yellowAccent,
                                                              )),
                                                          Text(
                                                              "${oCcy.format(item.price)}¥ x ${item.quantity}  = ${oCcy.format(xiaojiYuan)} ¥ \n x ${item.cnYrateVnd} đ/¥ = ${oCcVN.format(xiaojiDun)} đ",
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .amber,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: 110,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Text("商品总价:",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 8,
                                                            )),
                                                        Text(
                                                            " ${oCcy.format(totalItemCny)}¥ ",
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            )),
                                                      ],
                                                    ),
                                                    Text(
                                                        " ( ${oCcVN.format(totalItemVnd)} đ )",
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
                                                    Text(
                                                        "${oCcy.format(shipFeeCny)} ¥  ",
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                  ],
                                                ),
                                                Text(
                                                    " ( ${oCcVN.format(shipFeeVnd)} đ )",
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
                                                        " ${oCcy.format(orders[idx].totalCn)}¥ ",
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                  ],
                                                ),
                                                Text(
                                                    "(${oCcVN.format(orders[idx].totalVn)}đ) ",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    )),
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
                          })
                    ],
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }),
          ),
        ],
      ),
    ));
  }
}

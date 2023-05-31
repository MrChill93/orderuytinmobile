import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/orders.dart';
import '../../models/ordersmodel.dart';
import 'package:intl/intl.dart';

class boughtOrderUserScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _boughtOrderUserScreenState();
}

class _boughtOrderUserScreenState extends State<boughtOrderUserScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: SingleChildScrollView(
      child: FutureBuilder(
        future: fetchDataBoughtOrder(http.Client()),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return OrdersList(orders: snapshot.data);
          }
          return const Center(child: CircularProgressIndicator());
        }),
      ),
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
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: orders!.length,
        itemBuilder: (context, idx) {
          final oCcy = NumberFormat("###.00", "en_US");
          final oCcVN = NumberFormat("###,###", "en_US");
          num? totalItemCny = 0;
          num? totalItemVnd = 0;
          num? shipFeeCny = orders![idx].shipFeeCny;
          num? shipFeeVnd = orders![idx].shipFeeVnd;

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
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0)),
                        Text('${orders?[idx].orderUserName}',
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
                              return Row(
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
                                                overflow: TextOverflow.ellipsis,
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
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 120,
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

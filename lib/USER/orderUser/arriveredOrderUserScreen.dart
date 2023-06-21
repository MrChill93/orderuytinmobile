import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../models/orders.dart';
import '../../models/ordersmodel.dart';
import 'package:intl/intl.dart';

import '../../presentation/features/auth/auth_bloc.dart';
import '../item/complainItem.dart';

class arriveredOrderUserScreen extends StatefulWidget {
  const arriveredOrderUserScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _arriveredOrderUserScreenState();
}

class _arriveredOrderUserScreenState extends State<arriveredOrderUserScreen> {
  List<Order>? orders;

  @override
  void initState() {
    super.initState();
  }

  ConfirmSuccess(int orderId, String userName) async {
    await confirmSuccessOrder(http.Client(), orderId);

    setState(() {
      fetchDataArriveredOrder(http.Client(), userName);
    });
  }

// Getting value from TextField widget.
  late var userNoteCtr = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> complainOrder(Item i) async {
    String userNote = userNoteCtr.text;

    String url = 'http://localhost:8080/complainItem';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json =
        '{ "link": "${i.link}",  "describle": "${i.describle}", "price": ${i.price}, "quantity": ${i.quantity}, "itemStatus": "Khieu nai", "image": "${i.image}",  "cnYrateVnd": ${i.cnYrateVnd},"itemUserName": "${i.itemUserName}","userNote": "${i.userNote}","adminNote": "${i.adminNote}", "refundDate": ${i.refundDate}, "quantityRefund": ${i.quantityRefund}, "orderId": "${i.orderId}"} ';
    Response response = await put(Uri.parse(url), headers: headers, body: json);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    // TODO: implement build
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthenticatedState) {
          return Scaffold(
              body: FutureBuilder(
            future: fetchDataArriveredOrder(
                http.Client(), state.user.userName ?? ""),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, idx) {
                      List<Order>? orders = snapshot.data;

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
                        totalItemCny =
                            totalItemCny! + orderPrice! * orderQuantity!;
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

                      return Container(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                            // isDismissible: false,
                                            context: this.context,
                                            isScrollControlled: true,
                                            builder: (context) {
                                              return Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.9,
                                                  color: Colors.yellowAccent,
                                                  child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      color: Colors.black,
                                                      child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(1),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .black,
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .white,
                                                                    width: 2,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0)),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Expanded(
                                                              child: Column(
                                                                children: [
                                                                  Column(
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: <
                                                                            Widget>[
                                                                          Text(
                                                                              DateFormat('yyyy-MM-dd').format(orders?[idx].receivedDate),
                                                                              style: const TextStyle(color: Colors.yellowAccent, fontWeight: FontWeight.bold, fontSize: 12.0)),
                                                                          Text(
                                                                              '${orders?[idx].orderNo}',
                                                                              style: const TextStyle(color: Colors.yellowAccent, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.bold, fontSize: 12.0)),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          10),
                                                                  SizedBox(
                                                                    child: Table(
                                                                        border: TableBorder.all(
                                                                            color:
                                                                                Colors.white,
                                                                            style: BorderStyle.solid,
                                                                            width: 2),
                                                                        children: [
                                                                          TableRow(
                                                                              children: [
                                                                                Column(children: const [
                                                                                  Text('Mã vđ ', style: TextStyle(fontSize: 12.0, color: Colors.amber))
                                                                                ]),
                                                                                Column(children: const [
                                                                                  Text('Thành tiền', style: TextStyle(fontSize: 12.0, color: Colors.amber))
                                                                                ]),
                                                                                SizedBox(
                                                                                  width: MediaQuery.of(context).size.width,
                                                                                  child: Column(children: const [
                                                                                    Text('KG', style: TextStyle(fontSize: 12.0, color: Colors.amber))
                                                                                  ]),
                                                                                ),
                                                                                Column(children: const [
                                                                                  Text('M3', style: TextStyle(fontSize: 12.0, color: Colors.amber))
                                                                                ]),
                                                                                Column(children: const [
                                                                                  Text(
                                                                                    'Ngày về',
                                                                                    style: TextStyle(fontSize: 12.0, color: Colors.amber),
                                                                                  )
                                                                                ]),
                                                                              ]),
                                                                        ]),
                                                                  ),
                                                                  SizedBox(
                                                                    child: ListView.builder(
                                                                        physics: const NeverScrollableScrollPhysics(),
                                                                        shrinkWrap: true,
                                                                        itemCount: orders?[idx].waybills.length,
                                                                        itemBuilder: (context, index) {
                                                                          // DateTime date = orders![idx].waybills[index].arriveredDate;
                                                                          num? freight = orders![idx]
                                                                              .waybills[index]
                                                                              .freight;
                                                                          if (freight ==
                                                                              null) {
                                                                            freight =
                                                                                0;
                                                                          } else {
                                                                            freight =
                                                                                orders![idx].waybills[index].freight;
                                                                          }
                                                                          final WayBills?
                                                                              waybill =
                                                                              orders?[idx].waybills[index];
                                                                          return Table(
                                                                            border: TableBorder.all(
                                                                                color: Colors.white,
                                                                                style: BorderStyle.solid,
                                                                                width: 2),
                                                                            children: [
                                                                              TableRow(children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(5.0),
                                                                                  child: Center(
                                                                                    child: Text('${orders?[idx].waybills[index].wayBillCode}', style: const TextStyle(fontSize: 9.0, color: Colors.amber)),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(top: 10),
                                                                                  child: Center(
                                                                                    child: Text(oCcVN.format(freight), style: const TextStyle(fontSize: 10.0, color: Colors.amber)),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(top: 10),
                                                                                  child: Center(
                                                                                    child: Text('${orders?[idx].waybills[index].kg}', style: const TextStyle(fontSize: 12.0, color: Colors.amber)),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(top: 10),
                                                                                  child: Center(
                                                                                    child: Text('${orders?[idx].waybills[index].cubic}', style: const TextStyle(fontSize: 12.0, color: Colors.amber)),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(top: 10),
                                                                                  child: Center(
                                                                                    child: Text(orders![idx].waybills[index].arriveredDate.toString() == 'null' ? 'Chưa về' : orders![idx].waybills[index].arriveredDate.toString().substring(0, 10), style: TextStyle(fontSize: 12.0, color: Colors.amber)),
                                                                                  ),
                                                                                ),
                                                                              ]),
                                                                            ],
                                                                          );
                                                                        }),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      const Text(
                                                                          'Tổng cước',
                                                                          style: TextStyle(
                                                                              fontSize: 12.0,
                                                                              color: Colors.amber)),
                                                                      SizedBox(
                                                                        width:
                                                                            30,
                                                                      ),
                                                                      Text(
                                                                          oCcVN.format(
                                                                              totalFreight),
                                                                          style: const TextStyle(
                                                                              fontSize: 12.0,
                                                                              color: Colors.amber)),
                                                                    ],
                                                                  ),
                                                                  Column(
                                                                    children: [
                                                                      SizedBox(
                                                                        child: ListView
                                                                            .builder(
                                                                          physics:
                                                                              const NeverScrollableScrollPhysics(),
                                                                          shrinkWrap:
                                                                              true,
                                                                          itemCount: orders?[idx]
                                                                              .items
                                                                              .length,
                                                                          itemBuilder:
                                                                              (context, index) {
                                                                            final Item?
                                                                                item =
                                                                                orders?[idx].items[index];
                                                                            int itemId =
                                                                                item!.itemId;
                                                                            num?
                                                                                itemPrice =
                                                                                item?.price;
                                                                            num?
                                                                                itemQuantity =
                                                                                item?.quantity;
                                                                            num?
                                                                                itemCNYrateVND =
                                                                                item?.cnYrateVnd;
                                                                            num?
                                                                                xiaojiYuan =
                                                                                itemPrice! * (itemQuantity!);
                                                                            num? xiaojiDun = itemPrice *
                                                                                (itemQuantity) *
                                                                                (itemCNYrateVND!);
                                                                            return Column(
                                                                              children: [
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                                                                    Column(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        SizedBox(
                                                                                          width: MediaQuery.of(context).size.width * 0.45,
                                                                                          child: Text("${item?.link}",
                                                                                              style: const TextStyle(
                                                                                                overflow: TextOverflow.ellipsis,
                                                                                                color: Color.fromARGB(255, 243, 232, 200),
                                                                                                fontSize: 12,
                                                                                              )),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: MediaQuery.of(context).size.width * 0.45,
                                                                                          child: Text("${item?.describle}",
                                                                                              style: const TextStyle(
                                                                                                color: Colors.yellowAccent,
                                                                                              )),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: MediaQuery.of(context).size.width * 0.45,
                                                                                          child: Text("${oCcy.format(item?.price)}¥ x ${item?.quantity}  = ${oCcy.format(xiaojiYuan)} ¥ \n x ${item?.cnYrateVnd} đ/¥ = ${oCcVN.format(xiaojiDun)} đ", style: const TextStyle(color: Colors.amber, fontSize: 15, fontWeight: FontWeight.bold)),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    Column(
                                                                                      children: [
                                                                                        TextButton(
                                                                                            onPressed: () {
                                                                                              Navigator.push(
                                                                                                context,
                                                                                                MaterialPageRoute(builder: (context) => complainItemScreen(itemId: item!.itemId)),
                                                                                              );
                                                                                            },
                                                                                            child: Container(
                                                                                              padding: const EdgeInsets.all(5),
                                                                                              decoration: BoxDecoration(
                                                                                                color: Colors.redAccent,
                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                              ),
                                                                                              child: const Text('Khiếu nại', style: TextStyle(color: Colors.cyanAccent, fontSize: 15, fontWeight: FontWeight.bold)),
                                                                                            )),
                                                                                        SizedBox(
                                                                                          height: 30,
                                                                                        ),
                                                                                        Container(width: 80, child: Text("${item?.userNote == null ? '' : item?.userNote}", style: const TextStyle(fontSize: 14.0, color: Colors.redAccent, fontWeight: FontWeight.bold)))
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  Text("TỔNG đơn hàng ( KHÔNG Ship nđ)", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                                                                  Text(" ${oCcy.format(totalItemCny)}¥ ",
                                                                                      style: const TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontSize: 14,
                                                                                        fontWeight: FontWeight.bold,
                                                                                      )),
                                                                                  Text(" ( ${oCcVN.format(totalItemVnd)} đ )",
                                                                                      style: const TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontSize: 12,
                                                                                      )),
                                                                                ],
                                                                              ),
                                                                              SizedBox(height: 10),
                                                                              Row(
                                                                                children: [
                                                                                  Text("Ship nđ  ", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                                                                  Text("${oCcy.format(shipFeeCny)} ¥  ",
                                                                                      style: const TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontSize: 15,
                                                                                        fontWeight: FontWeight.bold,
                                                                                      )),
                                                                                  Text(" ( ${oCcVN.format(shipFeeVnd)} đ )",
                                                                                      style: const TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontSize: 12,
                                                                                      )),
                                                                                ],
                                                                              ),
                                                                              SizedBox(height: 10),
                                                                              Row(
                                                                                children: [
                                                                                  Text("TỔNG đơn hàng (CÓ Ship nđ) ", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                                                                  Text(" ${oCcy.format(orders?[idx].totalCn)}¥ ",
                                                                                      style: const TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontSize: 15,
                                                                                        fontWeight: FontWeight.bold,
                                                                                      )),
                                                                                  Text("(${oCcVN.format(orders?[idx].totalVn)}đ) ",
                                                                                      style: const TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontSize: 12,
                                                                                      )),
                                                                                ],
                                                                              ),
                                                                              SizedBox(height: 10),
                                                                              Row(
                                                                                children: [
                                                                                  Text("TỔNG (+cước) ", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
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
                                                                ],
                                                              ),
                                                            ),
                                                          ))));
                                            });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Text('Khiếu nại',
                                            style: TextStyle(
                                                color: Colors.cyanAccent,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                              //  isDismissible: true,
                                            context: this.context,
                                            // isScrollControlled: true,
                                            builder: (context) {
                                              return Container(
                                                   height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.9,
                                                  color: Colors.yellowAccent,
                                                  child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      color: Colors.black,
                                                      child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(1),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .black,
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .white,
                                                                    width: 2,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0)),
                                                          child:
                                                              SingleChildScrollView(
                                                                  child:
                                                                      Expanded(
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(8),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                          DateFormat('yyyy-MM-dd').format(orders?[idx]
                                                                              .receivedDate),
                                                                          style: const TextStyle(
                                                                              color: Colors.yellowAccent,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12.0)),
                                                                      Text(
                                                                          '${orders?[idx].orderStatus}',
                                                                          style: const TextStyle(
                                                                              color: Colors.yellowAccent,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12.0)),
                                                                      Text(
                                                                          '${orders?[idx].orderNo}',
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
                                                                        color: Colors
                                                                            .white,
                                                                        style: BorderStyle
                                                                            .solid,
                                                                        width:
                                                                            2),
                                                                    children: const [
                                                                      TableRow(
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsets.all(5.0),
                                                                              child: Center(
                                                                                child: Text('MÃ VĐ', style: TextStyle(fontSize: 12.0, color: Colors.amber)),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsets.all(5.0),
                                                                              child: Center(
                                                                                child: Text('Thành tiền', style: TextStyle(fontSize: 12.0, color: Colors.amber)),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsets.all(3.0),
                                                                              child: Center(
                                                                                child: Text('KG', style: TextStyle(fontSize: 12.0, color: Colors.amber)),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsets.all(3.0),
                                                                              child: Center(
                                                                                child: Text('M3', style: TextStyle(fontSize: 12.0, color: Colors.amber)),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsets.all(3.0),
                                                                              child: Center(
                                                                                child: Text(
                                                                                  'Ngày về ',
                                                                                  style: TextStyle(fontSize: 12.0, color: Colors.amber),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                    ]),
                                                                SizedBox(
                                                                  width: 400,
                                                                  child: ListView
                                                                      .builder(
                                                                          physics:
                                                                              const NeverScrollableScrollPhysics(),
                                                                          shrinkWrap:
                                                                              true,
                                                                          itemCount: orders?[idx]
                                                                              .waybills
                                                                              .length,
                                                                          itemBuilder:
                                                                              (context, index) {
                                                                            num?
                                                                                freight =
                                                                                orders![idx].waybills[index].freight;
                                                                            if (freight ==
                                                                                null) {
                                                                              freight = 0;
                                                                            } else {
                                                                              freight = orders![idx].waybills[index].freight;
                                                                            }
                                                                            final WayBills?
                                                                                waybill =
                                                                                orders?[idx].waybills[index];
                                                                            return Table(
                                                                              border: TableBorder.all(color: Colors.white, style: BorderStyle.solid, width: 2),
                                                                              children: [
                                                                                TableRow(children: [
                                                                                  Column(children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.all(5.0),
                                                                                      child: Text('${orders?[idx].waybills[index].wayBillCode}', style: const TextStyle(fontSize: 9.0, color: Colors.amber)),
                                                                                    )
                                                                                  ]),
                                                                                  Column(children: [
                                                                                    Align(
                                                                                      alignment: Alignment.center,
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.only(top: 10),
                                                                                        child: Text(oCcVN.format(freight), style: const TextStyle(fontSize: 12.0, color: Colors.amber)),
                                                                                      ),
                                                                                    )
                                                                                  ]),
                                                                                  Column(children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(top: 10),
                                                                                      child: Text('${orders?[idx].waybills[index].kg}', style: const TextStyle(fontSize: 12.0, color: Colors.amber)),
                                                                                    )
                                                                                  ]),
                                                                                  Column(children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(top: 10),
                                                                                      child: Text('${orders?[idx].waybills[index].cubic}', style: const TextStyle(fontSize: 12.0, color: Colors.amber)),
                                                                                    )
                                                                                  ]),
                                                                                  Column(children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(top: 10),
                                                                                      child: Text((orders![idx].waybills[index].arriveredDate.toString() == 'null') ? 'Chưa về' : orders![idx].waybills[index].arriveredDate.toString().substring(0, 10), style: const TextStyle(fontSize: 12.0, color: Colors.amber)),
                                                                                    )
                                                                                  ]),
                                                                                ]),
                                                                              ],
                                                                            );
                                                                          }),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    const Text(
                                                                        'Tổng cước',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12.0,
                                                                            color:
                                                                                Colors.amber)),
                                                                    SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                    Text(
                                                                        oCcVN.format(
                                                                            totalFreight),
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                12.0,
                                                                            color:
                                                                                Colors.amber)),
                                                                    const Spacer(),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        ConfirmSuccess(
                                                                            orders?[idx].orderId ??
                                                                                0,
                                                                            state.user.userName ??
                                                                                '');
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        padding:
                                                                            const EdgeInsets.all(5),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.cyanAccent,
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                        ),
                                                                        child: const Text(
                                                                            'Xác nhận thành công',
                                                                            style: TextStyle(
                                                                                color: Colors.red,
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.bold)),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          screenWidth *
                                                                              0.9,
                                                                      child: ListView
                                                                          .builder(
                                                                        physics:
                                                                            const NeverScrollableScrollPhysics(),
                                                                        shrinkWrap:
                                                                            true,
                                                                        itemCount: orders?[idx]
                                                                            .items
                                                                            .length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          final Item?
                                                                              item =
                                                                              orders?[idx].items[index];
                                                                          num?
                                                                              itemPrice =
                                                                              item?.price;
                                                                          num?
                                                                              itemQuantity =
                                                                              item?.quantity;
                                                                          num?
                                                                              itemQuantityRefund =
                                                                              item?.quantityRefund;
                                                                          num?
                                                                              itemCNYrateVND =
                                                                              item?.cnYrateVnd;
                                                                          num?
                                                                              xiaojiYuan =
                                                                              itemPrice! * (itemQuantity!);
                                                                          num? xiaojiDun = itemPrice *
                                                                              (itemQuantity) *
                                                                              (itemCNYrateVND!);
                                                                          num? tuikuanDun = itemPrice *
                                                                              (itemQuantityRefund ?? 0) *
                                                                              (itemCNYrateVND);
                                                                          return Container(
                                                                            margin:
                                                                                EdgeInsets.all(2),
                                                                            decoration: BoxDecoration(
                                                                                border: Border.all(
                                                                                  color: Colors.white,
                                                                                  width: 1,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(10.0)),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Container(
                                                                                  margin: const EdgeInsets.all(1.0),
                                                                                  child: Image.network(
                                                                                    fit: BoxFit.cover,
                                                                                    'http://www.orderuytin.com/image/item/${item?.image}',
                                                                                    width: 80,
                                                                                    height: 120,
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      SizedBox(
                                                                                        width: 220,
                                                                                        child: Text("${item?.link}",
                                                                                            style: const TextStyle(
                                                                                              overflow: TextOverflow.ellipsis,
                                                                                              color: Color.fromARGB(255, 243, 232, 200),
                                                                                              fontSize: 12,
                                                                                            )),
                                                                                      ),
                                                                                      Text("${item?.describle}",
                                                                                          style: const TextStyle(
                                                                                            color: Colors.yellowAccent,
                                                                                          )),
                                                                                      Text("${oCcy.format(item?.price)}¥ x ${item?.quantity}  = ${oCcy.format(xiaojiYuan)} ¥ \n x ${item?.cnYrateVnd} đ/¥ = ${oCcVN.format(xiaojiDun)} đ", style: const TextStyle(color: Colors.amber, fontSize: 15, fontWeight: FontWeight.bold)),
                                                                                      Text("Số lg hoàn tiền: ${item?.quantityRefund ?? 0}",
                                                                                          style: const TextStyle(
                                                                                            color: Colors.yellowAccent,
                                                                                          )),
                                                                                      Text("Giá trị tiền hoàn: ${oCcVN.format(tuikuanDun)} đ",
                                                                                          style: const TextStyle(
                                                                                            color: Colors.yellowAccent,
                                                                                          )),
                                                                                      Text(item?.userNote == null ? '' : ('Khiếu nại :' + '${item?.userNote}'),
                                                                                          style: const TextStyle(
                                                                                            color: Colors.red,
                                                                                          )),
                                                                                      Text(item?.adminNote == null ? '' : ('Phản hồi :' + '${item?.adminNote}'),
                                                                                          style: const TextStyle(
                                                                                            color: Colors.cyanAccent,
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
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            const Text("TỔNG đơn hàng ( KHÔNG Ship nđ)",
                                                                                style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                                                            Text(" ${oCcy.format(totalItemCny)}¥ ",
                                                                                style: const TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 14,
                                                                                  fontWeight: FontWeight.bold,
                                                                                )),
                                                                            Text(" ( ${oCcVN.format(totalItemVnd)} đ )",
                                                                                style: const TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 12,
                                                                                )),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                10),
                                                                        Row(
                                                                          children: [
                                                                            const Text("Ship nđ  ",
                                                                                style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                                                            Text("${oCcy.format(shipFeeCny)} ¥  ",
                                                                                style: const TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 15,
                                                                                  fontWeight: FontWeight.bold,
                                                                                )),
                                                                            Text(" ( ${oCcVN.format(shipFeeVnd)} đ )",
                                                                                style: const TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 12,
                                                                                )),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                10),
                                                                        Row(
                                                                          children: [
                                                                            const Text("TỔNG đơn hàng (CÓ Ship nđ) ",
                                                                                style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                                                            Text(" ${oCcy.format(orders?[idx].totalCn)}¥ ",
                                                                                style: const TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 15,
                                                                                  fontWeight: FontWeight.bold,
                                                                                )),
                                                                            Text("(${oCcVN.format(orders?[idx].totalVn)}đ) ",
                                                                                style: const TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 12,
                                                                                )),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                10),
                                                                        Row(
                                                                          children: [
                                                                            const Text("TỔNG giá trị đơn hàng (+cước) ",
                                                                                style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
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
                                                          )))));
                                            });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.cyanAccent,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Text('Xác nhận thành công',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                      ))
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: screenWidth * 0.95,
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
                                        num? itemCNYrateVND = item?.cnYrateVnd;
                                        num? xiaojiYuan =
                                            itemPrice! * (itemQuantity!);
                                        num? xiaojiDun = itemPrice *
                                            (itemQuantity) *
                                            (itemCNYrateVND!);
                                        return Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  margin:
                                                      const EdgeInsets.all(1.0),
                                                  child: Image.network(
                                                    fit: BoxFit.cover,
                                                    'http://www.orderuytin.com/image/item/${item?.image}',
                                                    width: 60,
                                                    height: 60,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      // SizedBox(
                                                      //   width: 220,
                                                      //   child: Text("${item?.link}",
                                                      //       style: const TextStyle(
                                                      //         overflow:
                                                      //             TextOverflow.ellipsis,
                                                      //         color: Color.fromARGB(
                                                      //             255, 243, 232, 200),
                                                      //         fontSize: 12,
                                                      //       )),
                                                      // ),
                                                      Text("${item?.describle}",
                                                          style:
                                                              const TextStyle(
                                                            color: Colors
                                                                .yellowAccent,
                                                          )),
                                                      Text(
                                                          "${oCcy.format(item?.price)}¥ x ${item?.quantity}  = ${oCcy.format(xiaojiYuan)} ¥ \n x ${item?.cnYrateVnd} đ/¥ = ${oCcVN.format(xiaojiDun)} đ",
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.amber,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
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
                      );
                    });
                ;
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

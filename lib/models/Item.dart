import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:orderuytinmobile/config.dart';

class Item {
  final int itemId;
  final int quantity;
  final int orderId;
  final int CNYrateVND;
  final int quantityRefund;
  final String? link;
  final String? adminNote;
  final String? userNote;
  final String? image;
  final String? itemUserName;
  final String? describle;
  final String? itemStatus;
  final Double price;
  final DateTime? refundDate;

  Item({
    required this.itemId,
    required this.quantity,
    required this.orderId,
    required this.CNYrateVND,
    required this.quantityRefund,
    required this.link,
    required this.adminNote,
    required this.userNote,
    required this.image,
    required this.itemUserName,
    required this.itemStatus,
    required this.price,
    required this.refundDate,
    required this.describle,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      orderId: json["orderId"],
      itemId: json["itemId"],
      quantity: json["quantity"],
      itemStatus: json["itemStatus"],
      itemUserName: json["itemUserName"],
      refundDate: json["refundDate"],
      describle: json["describle"],
      price: json["price"],
      image: json["image"],
      quantityRefund: json["quantityRefund"],
      adminNote: json["adminNote"],
      link: json["link"],
      userNote: json["userNote"],
      CNYrateVND: json["CNYrateVND"],
    );
  }
}

Future<List<Item>> fetchOrders(http.Client client) async {
  //How to make these URLs in a dart file?

  final response = await client.get(Uri.parse(URL_ORDERS));

  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = json.decode(response.body);
    if (mapResponse["result"] == "ok") {
      final orders = mapResponse["data"].cast<Map<String, dynamic>>();
      final ListofOrders = await orders.map<Item>((json) {
        return Item.fromJson(json);
      }).toList();
      return ListofOrders;
    } else {
      return [];
    }
  } else {
    throw Exception("Mạng đang lỗi , không thể lấy được dữ liệu từ server.");
  }
}

import 'dart:convert';

class Order {
  Order({
    required this.orderId,
    required this.totalCn,
    required this.shipFeeVnd,
    required this.shipFeeCny,
    required this.totalVn,
    required this.orderUserName,
    required this.orderStatus,
    required this.orderNo,
    this.receivedDate,
    this.cancelDate,
    required this.items,
    required this.waybills,
  });

  final int orderId;
  final num? totalCn;
  final num? shipFeeVnd;
  final num? shipFeeCny;
  final num? totalVn;
  final String? orderUserName;
  final String? orderStatus;
  final String? orderNo;
  final dynamic receivedDate;
  final dynamic cancelDate;
  final List<Item> items;
  final List<WayBills> waybills;

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderId: json["orderId"],
        totalCn: json["totalCN"],
        shipFeeVnd: json["shipFeeVND"],
        shipFeeCny: json["shipFeeCNY"],
        totalVn: json["totalVN"],
        orderUserName: json["orderUserName"],
        orderStatus: json["orderStatus"],
        orderNo: json["orderNo"],
        receivedDate: DateTime.parse(json["receivedDate"]),
        cancelDate: json["cancelDate"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        waybills: List<WayBills>.from(
            json["waybills"].map((x) => WayBills.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "totalCN": totalCn,
        "shipFeeVND": shipFeeVnd,
        "shipFeeCNY": shipFeeCny,
        "totalVN": totalVn,
        "orderUserName": orderUserName,
        "orderStatus": orderStatus,
        "orderNo": orderNo,
        "receivedDate": receivedDate?.toIso8601String(),
        "cancelDate": cancelDate,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "waybills": List<dynamic>.from(waybills.map((x) => x)),
      };
}

class Item {
  Item({
    required this.itemId,
    required this.quantity,
    required this.orderId,
    required this.cnYrateVnd,
    required this.price,
    // this.orders,
    required this.quantityRefund,
    this.refundDate,
    required this.adminNote,
    required this.userNote,
    required this.link,
    required this.image,
    this.itemUserName,
    required this.describle,
    required this.itemStatus,
  });

  final int itemId;
  final num? quantity;
  final num? orderId;
  final num? cnYrateVnd;
  final num? price;
  final num? quantityRefund;
  final dynamic refundDate;
  final String? adminNote;
  final String? userNote;
  // final dynamic orders;
  final String? link;
  final String? image;
  final String? itemUserName;
  final String? describle;
  final String? itemStatus;

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        itemId: json["itemId"],
        quantity: json["quantity"],
        orderId: json["orderId"],
        // orders: json["orders"],
        cnYrateVnd: json["CNYrateVND"],
        price: json["price"],
        quantityRefund: json["quantityRefund"],
        refundDate: json["refundDate"],
        adminNote: json["adminNote"],
        userNote: json["userNote"],
        link: json["link"],
        image: json["image"],
        itemUserName: json["itemUserName"],
        describle: json["describle"],
        itemStatus: json["itemStatus"],
      );

  Map<String, dynamic> toJson() => {
        "itemId": itemId,
        "quantity": quantity,
        "orderId": orderId,
        // "orders": orders,
        "CNYrateVND": cnYrateVnd,
        "price": price,
        "quantityRefund": quantityRefund,
        "refundDate": refundDate,
        "adminNote": adminNote,
        "userNote": userNote,
        "link": link,
        "image": image,
        "itemUserName": itemUserName,
        "describle": describle,
        "itemStatus": itemStatus,
      };
}

class WayBills {
  WayBills({
    required this.wayBillId,
    required this.freight,
    required this.rateCubic,
    required this.wayBillCode,
    required this.rateKg,
    this.orders,
    this.arriveredDate,
    required this.kg,
    required this.type,
    required this.wbUserName,
    required this.cubic,
  });

  final num? wayBillId;
  final num? freight;
  final num? rateCubic;
  final num? rateKg;
  final num? cubic;
  final num? kg;
  final dynamic orders;
  final dynamic arriveredDate;
  final String? wayBillCode;
  final String? wbUserName;
  final String? type;

  factory WayBills.fromRawJson(String str) =>
      WayBills.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WayBills.fromJson(Map<String, dynamic> json) => WayBills(
        wayBillId: json["wayBillId"],
        freight: json["freight"],
        rateCubic: json["rateCubic"],
        orders: json["orders"],
        rateKg: json["rateKg"],
        wayBillCode: json["wayBillCode"],
        kg: json["kg"],
        cubic: json["cubic"],
        wbUserName: json["wbUserName"],
        type: json["type"],
        arriveredDate: json["arriveredDate"],
      );

  Map<String, dynamic> toJson() => {
        "wayBillId": wayBillId,
        "freight": freight,
        "rateCubic": rateCubic,
        "rateKg": rateKg,
        "wayBillCode": wayBillCode,
        "wbUserName": wbUserName,
        "kg": kg,
        "cubic": cubic,
        "orders": orders,
        "type": type,
        "arriveredDate": arriveredDate,
      };
}

class Users {
  Users({
    required this.rate,
    required this.role,
    required this.phone,
    required this.email,
    required this.STATUS,
    required this.userId,
    required this.rateM3,
    required this.rateKg,
    required this.address,
    required this.password,
    required this.userName,
    required this.rePassword,
    required this.chargMoneys,
  });

  final num? rate;
  final num? userId;
  final num? rateM3;
  final num? rateKg;
  final num? STATUS;
  final String? role;
  final String? phone;
  final String? email;
  final String? address;
  final String? password;
  final String? userName;
  final String? rePassword;
  final List<ChargMoney> chargMoneys;

  factory Users.fromRawJson(String str) => Users.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        role: json["role"],
        rate: json["rate"],
        email: json["email"],
        phone: json["phone"],
        rateKg: json["rateKg"],
        STATUS: json["STATUS"],
        userId: json["userId"],
        rateM3: json["rateM3"],
        address: json["address"],
        password: json["password"],
        userName: json["userName"],
        rePassword: json["rePassword"],
        chargMoneys: List<ChargMoney>.from(
            json["chargMoneys"].map((x) => ChargMoney.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "role": role,
        "phone": phone,
        "email": email,
        "rateM3": rateM3,
        "rateKg": rateKg,
        "STATUS": STATUS,
        "userId": userId,
        "address": address,
        "userName": userName,
        "password": password,
        "rePassword": rePassword,
        "chargMoneys": List<dynamic>.from(chargMoneys.map((x) => x.toJson())),
      };
}

class ChargMoney {
  ChargMoney({
    required this.chargId,
    required this.userId,
    required this.amount,
    this.chargDate,
    required this.note,
  });

  final int chargId;
  final num? userId;
  final num? amount;
  final dynamic chargDate;
  final String? note;

  factory ChargMoney.fromRawJson(String str) =>
      ChargMoney.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChargMoney.fromJson(Map<String, dynamic> json) => ChargMoney(
        chargId: json["chargId"],
        userId: json["userId"],
        amount: json["amount"],
        chargDate: json["chargDate"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "chargId": chargId,
        "userId": userId,
        "amount": amount,
        "chargDate": chargDate,
        "note": note,
      };
}

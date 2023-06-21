import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:orderuytinmobile/config.dart';

class Statistic {
  final int? countWholeOrder;
  final int? countPendingItem;
  final int? countCartItem;
  final int? countCancelItem;
  final int? countCancelOrder;
  final int? countBoughtOrder;
  final int? countDeliveredOrder;
  final int? countArriveredOrder;
  final int? countComplainOrder;
  final int? countFinishedOrder;
  final double sumTotalVNUser;
  final double sumAmountUser;
  final double? sumReFundVNUser;
  final double? sumTotalCancelVNUser;
  final double sumTotalFreightUser;

  Statistic({
    required this.countWholeOrder,
    required this.countPendingItem,
    required this.countCartItem,
    required this.countCancelItem,
    required this.countCancelOrder,
    required this.countBoughtOrder,
    required this.countDeliveredOrder,
    required this.countArriveredOrder,
    required this.countComplainOrder,
    required this.countFinishedOrder,
    required this.sumTotalVNUser,
    required this.sumAmountUser,
    this.sumReFundVNUser,
    this.sumTotalCancelVNUser,
    required this.sumTotalFreightUser,
  });

  factory Statistic.fromRawJson(String str) =>
      Statistic.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Statistic.fromJson(Map<String, dynamic> json) => Statistic(
        countWholeOrder: json["countWholeOrder"],
        countPendingItem: json["countPendingItem"],
        countCartItem: json["countCartItem"],
        countCancelItem: json["countCancelItem"],
        countCancelOrder: json["countCancelOrder"],
        countBoughtOrder: json["countBoughtOrder"],
        countDeliveredOrder: json["countDeliveredOrder"],
        countArriveredOrder: json["countArriveredOrder"],
        countComplainOrder: json["countComplainOrder"],
        countFinishedOrder: json["countFinishedOrder"],
        sumTotalVNUser: json["sumTotalVNUser"],
        sumAmountUser: json["sumAmountUser"],
        sumReFundVNUser: json["sumReFundVNUser"],
        sumTotalCancelVNUser: json["sumTotalCancelVNUser"],
        sumTotalFreightUser: json["sumTotalFreightUser"],
      );

  Map<String, dynamic> toJson() => {
        "countWholeOrder": countWholeOrder,
        "countPendingItem": countPendingItem,
        "countCartItem": countCartItem,
        "countCancelItem": countCancelItem,
        "countCancelOrder": countCancelOrder,
        "countBoughtOrder": countBoughtOrder,
        "countDeliveredOrder": countDeliveredOrder,
        "countArriveredOrder": countArriveredOrder,
        "countComplainOrder": countComplainOrder,
        "countFinishedOrder": countFinishedOrder,
        "sumTotalVNUser": sumTotalVNUser,
        "sumAmountUser": sumAmountUser,
        "sumReFundVNUser": sumReFundVNUser,
        "sumTotalCancelVNUser": sumTotalCancelVNUser,
        "sumTotalFreightUser": sumTotalFreightUser,
      };
}

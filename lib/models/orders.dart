import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:orderuytinmobile/models/ordersmodel.dart';

import '../ApiResponse.dart';

Future<List<Order>> fetchDataBoughtOrder(http.Client client,String userName) async {
  var headers = {'Content-Type': 'application/json'};
  var request =
      http.Request('GET', Uri.parse('http://localhost:8080/boughtOrder/$userName'));

  request.body = '''\n''';
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  try {
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      final data = await response.stream.bytesToString();
      final dataParse = jsonDecode(data) as List;
      print(dataParse.first); //
      final orders = dataParse.map((item) {
        return Order.fromJson(item);
      }).toList();
      print(orders.length);
      return orders;
    } else {
      return [];
      // print(response.reasonPhrase);
    }
  } catch (e) {
    print("LOL $e");
    return [];
  }
}

Future<List<Order>> fetchDataDeleveriedOrder(http.Client client,String userName) async {
  var headers = {
    'Content-Type': 'application/json',
    "Connection": "Keep-Alive",
  };
  var request =
      http.Request('GET', Uri.parse('http://localhost:8080/deleveriedOrder/$userName'));
  request.body = '''\n''';
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  try {
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      final data = await response.stream.bytesToString();
      final dataParse = jsonDecode(data) as List;
      print(dataParse.first); //
      final orders = dataParse.map((item) {
        return Order.fromJson(item);
      }).toList();
      print(orders.length);
      return orders;
    } else {
      return [];
      // print(response.reasonPhrase);
    }
  } catch (e) {
    print("LOL $e hahaha");
    return [];
  }
}

Future<List<Order>> fetchDataArriveredOrder(http.Client client,String userName) async {
  var headers = {'Content-Type': 'application/json'};
  var request =
      http.Request('GET', Uri.parse('http://localhost:8080/arriveredOrder/$userName'));
  request.body = '''\n''';
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  try {
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      final data = await response.stream.bytesToString();
      final dataParse = jsonDecode(data) as List;
      print(dataParse.first); //
      final orders = dataParse.map((item) {
        return Order.fromJson(item);
      }).toList();
      print(orders.length);
      return orders;
    } else {
      return [];
      // print(response.reasonPhrase);
    }
  } catch (e) {
    print("LOL $e");
    return [];
  }
}

Future<List<Order>> fetchDataOrder(http.Client client,String userName) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request('GET', Uri.parse('http://localhost:8080/order/$userName'));
  request.body = '''\n''';
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  try {
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      final data = await response.stream.bytesToString();
      final dataParse = jsonDecode(data) as List;
      print(dataParse.first); //
      final orders = dataParse.map((item) {
        return Order.fromJson(item);
      }).toList();
      print(orders.length);
      return orders;
    } else {
      return [];
      // print(response.reasonPhrase);
    }
  } catch (e) {
    print("LOL $e");
    return [];
  }
}

Future<List<Order>> fetchDataFinishedOrder(http.Client client,String userName) async {
  var headers = {'Content-Type': 'application/json'};
  var request =
      http.Request('GET', Uri.parse('http://localhost:8080/finishedOrder/$userName'));
  request.body = '''\n''';
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  try {
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      final data = await response.stream.bytesToString();
      final dataParse = jsonDecode(data) as List;
      print(dataParse.first); //
      final orders = dataParse.map((item) {
        return Order.fromJson(item);
      }).toList();
      print(orders.length);
      return orders;
    } else {
      return [];
      // print(response.reasonPhrase);
    }
  } catch (e) {
    print("LOL $e");
    return [];
  }
}

Future<List<Order>> fetchFoundOrder(http.Client client, String orderNo) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
      'GET', Uri.parse('http://localhost:8080/findBoughtOrder/$orderNo'));
  request.body = '''\n''';
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  try {
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      final data = await response.stream.bytesToString();
      final dataParse = jsonDecode(data) as List;
      print(dataParse.first); //
      final orders = dataParse.map((item) {
        return Order.fromJson(item);
      }).toList();
      print(orders.length);
      return orders;
    } else {
      return [];
      // print(response.reasonPhrase);
    }
  } catch (e) {
    print("LOL $e");
    return [];
  }
}

Future<List<Order>> fetchDataComplainOrder(http.Client client,String userName) async {
  var headers = {'Content-Type': 'application/json'};
  var request =
      http.Request('GET', Uri.parse('http://localhost:8080/complainOrder/$userName'));
  request.body = '''\n''';
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  try {
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      final data = await response.stream.bytesToString();
      final dataParse = jsonDecode(data) as List;
      print(dataParse.first); //
      final orders = dataParse.map((item) {
        return Order.fromJson(item);
      }).toList();
      print(orders.length);
      return orders;
    } else {
      return [];
      // print(response.reasonPhrase);
    }
  } catch (e) {
    print("LOL $e");
    return [];
  }
}


Future<List<Item>> fetchDataPendingOrder(http.Client client,String userName) async {
  var headers = {'Content-Type': 'application/json'};
  var request =
      http.Request('GET', Uri.parse('http://localhost:8080/pendingOrder/$userName'));
  request.body = '''\n''';
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  try {
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      final data = await response.stream.bytesToString();
      final dataParse = jsonDecode(data) as List;
      print(dataParse.first); //
      final items = dataParse.map((item) {
        return Item.fromJson(item);
      }).toList();
      print(items.length);
      return items;
    } else {
      return [];
    }
  } catch (e) {
    print("LOL $e");
    return [];
  }
}

Future<List<Order>> fetchDataCancelOrder(http.Client client) async {
  var headers = {'Content-Type': 'application/json'};
  var request =
      http.Request('GET', Uri.parse('http://localhost:8080/cancelOrder'));
  request.body = '''\n''';
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  try {
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      final data = await response.stream.bytesToString();
      final dataParse = jsonDecode(data) as List;
      print(dataParse.first); //
      final orders = dataParse.map((item) {
        return Order.fromJson(item);
      }).toList();
      print(orders.length);
      return orders;
    } else {
      return [];
    }
  } catch (e) {
    print("LOL $e");
    return [];
  }
}

Future<List<Item>> fetchDataCancelItem(http.Client client) async {
  var headers = {'Content-Type': 'application/json'};
  var request =
      http.Request('GET', Uri.parse('http://localhost:8080/cancelItem'));
  request.body = '''\n''';
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  try {
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      final data = await response.stream.bytesToString();
      final dataParse = jsonDecode(data) as List;
      print(dataParse.first); //
      final items = dataParse.map((item) {
        return Item.fromJson(item);
      }).toList();
      print(items.length);
      return items;
    } else {
      return [];
    }
  } catch (e) {
    print("LOL $e");
    return [];
  }
}

Future<List<Item>> fetchDataItemInCart(
    http.Client client, String itemUserName) async {
  var headers = {'Content-Type': 'application/json', 'Charset': 'utf-8'};
  var request = http.Request(
      'GET', Uri.parse('http://localhost:8080/cart/$itemUserName'));
  request.body = '''\n''';
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  try {
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      final data = await response.stream.bytesToString();
      final dataParse = jsonDecode(data) as List;
      print(dataParse.first); //
      final items = dataParse.map((item) {
        return Item.fromJson(item);
      }).toList();
      print(items.length);
      return items;
    } else {
      return [];
    }
  } catch (e) {
    print("LOL $e");
    return [];
  }
}

Future<void> fetchDeleteItem(http.Client client, int itemId) async {
  var headers = {'Content-Type': 'application/json'};
  // var response =
  await client.delete(Uri.parse('http://localhost:8080/item/$itemId'));
}

Future<void> fetchDeleteOrder(http.Client client, int orderId) async {
  var headers = {'Content-Type': 'application/json'};
  // var response =
  await client.delete(Uri.parse('http://localhost:8080/order/$orderId'));
}

Future<void> putDeleteItem(int itemId) async {
  String url = 'http://localhost:8080/updateCancelItem/$itemId';

  try {
    final response = await http.put(Uri.parse(url));
    print(response.body);
  } catch (er) {}
}

Future<void> putRefundItem(int itemId) async {
  String url = 'http://localhost:8080/updateRefundItem/$itemId';

  try {
    final response = await http.put(Uri.parse(url));
    print(response.body);
  } catch (er) {}
}

Future<List<Users>> fetchDataUsers(http.Client client) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request('GET', Uri.parse('http://localhost:8080/users'));
  request.body = '''\n''';
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  try {
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      final data = await response.stream.bytesToString();
      final dataParse = jsonDecode(data) as List;
      print(dataParse.first); //
      final users = dataParse.map((chargmoney) {
        return Users.fromJson(chargmoney);
      }).toList();
      print(users.length);
      return users;
    } else {
      return [];
    }
  } catch (e) {
    print("LOL $e");
    return [];
  }
}

Future<Item> fetchCreateItem(
    http.Client client, Map<String, dynamic> params) async {
  final response = await client
      .post(Uri.parse('http://localhost:8080/createItem'), body: params);

  if (response.statusCode == 200) {
    final responseBody = await json.decode(response.body);
    return Item.fromJson(responseBody);
  } else {
    throw Exception(' Tạo đơn hàng thất bại .Lỗi :${response.toString()}');
  }
}

Future<ApiResponse> authenticateUser(String phone, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    var statusCode;
    final response = await http
        .post(Uri.parse('http://localhost:8080/api/auth/signin'), body: {
      'phone': phone,
      'password': password,
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.Data = Users.fromJson(json.decode(response.body));
        print("OK");
        break;
      case 401:
        print((apiResponse.ApiError as ApiError).error);
        apiResponse.ApiError =
            ApiError.fromJson(json.decode(response.body)) as String;
        break;
      default:
        print((apiResponse.ApiError as ApiError).error);
        apiResponse.ApiError =
            ApiError.fromJson(json.decode(response.body)) as String;
        break;
    }
  } on SocketException {
    apiResponse.ApiError =
        ApiError(error: "Server error. Please retry") as String;
  }
  return apiResponse;
}

Future<ApiResponse> getUserDetails(String userId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response =
        await http.get(Uri.parse('http://localhost:8080/user/$userId'));

    switch (response.statusCode) {
      case 200:
        apiResponse.Data = Users.fromJson(json.decode(response.body));
        break;
      case 401:
        print((apiResponse.ApiError as ApiError).error);
        apiResponse.ApiError =
            ApiError.fromJson(json.decode(response.body)) as String;
        break;
      default:
        print((apiResponse.ApiError as ApiError).error);
        apiResponse.ApiError =
            ApiError.fromJson(json.decode(response.body)) as String;
        break;
    }
  } on SocketException {
    apiResponse.ApiError =
        ApiError(error: "Server error. Please retry") as String;
  }
  return apiResponse;
}

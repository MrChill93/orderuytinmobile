import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:orderuytinmobile/shared/constants.dart';
import 'package:orderuytinmobile/shared/global_bloclistener.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final app = await Firebase.initializeApp(
    name: "Orderuytin",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  OrderuytinConfig.shared.database = FirebaseDatabase.instanceFor(
    app: app,
    databaseURL: app.options.databaseURL,
  );

  print(OrderuytinConfig.shared.database?.databaseURL);

  runApp(const GlobalBlocProviders());
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do/controllers/global_bindings.dart';
import 'package:to_do/firebase_options.dart';
import 'package:to_do/widgets/root_wrapper.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("todos");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RootWrapper(),
      initialBinding: GlobalBindings(),
      theme: ThemeData(primarySwatch: Colors.purple),
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: FlutterEasyLoading(child: child));
      },
    );
  }
}

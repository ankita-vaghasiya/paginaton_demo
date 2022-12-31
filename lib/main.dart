import 'package:flutter/material.dart';
import 'package:pagination_demo/view/home.dart';
import 'package:get/get.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'pagination Demo',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        home: HomePage());
  }
}

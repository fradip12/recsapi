import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:src/controller/home/home_controller.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (HomeController controller) {
      return Scaffold(
        body: Center(child: Text(" test ")),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:src/controller/tambah/kelahiran/tambah_kelahiran_controller.dart';

class TambahKelahiranPages extends StatelessWidget {
  const TambahKelahiranPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: TambahKelahiranController(),
      builder: (TambahKelahiranController controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Tambah Kelahiran'),
        ),
        body: Center(
          child: Text('Tambah Kelahiran'),
        ),
      );
    });
  }
}

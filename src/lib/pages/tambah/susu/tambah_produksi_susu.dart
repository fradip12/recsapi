import 'package:flutter/material.dart' hide TextField;
import 'package:get/get.dart';
import 'package:src/common/widget/keyboard_dismiss.dart';
import 'package:src/controller/tambah/susu/tambah_produksi_susu_controller.dart';

import '../../../common/widget/form_label.dart';
import '../../../common/widget/text_field.dart';

class TambahProduksiSusuPages extends StatelessWidget {
  const TambahProduksiSusuPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: TambahProduksiSusuController(),
      builder: (TambahProduksiSusuController controller) {
        return KeyboardDismissOntap(
          child: Scaffold(
            appBar: AppBar(
              title: Text('Tambah Produksi Susu'),
            ),
            bottomNavigationBar: ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  Size(double.infinity, 60),
                ),
              ),
              onPressed: () {
                controller.simpanData();
              },
              child: Text('Simpan'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormLabel(
                    isRequired: true,
                    label: 'Nama Sapi',
                  ),
                  TextField(
                    controller: controller.namaSapiController.value,
                    hintText: 'Nama Sapi',
                    keyboardType: TextInputType.phone,
                    enabled: false,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  FormLabel(
                    isRequired: true,
                    label: 'Kode Sapi',
                  ),
                  TextField(
                    controller: controller.kodeSapiController.value,
                    hintText: 'Kode Sapi',
                    keyboardType: TextInputType.phone,
                    enabled: false,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  FormLabel(
                    isRequired: true,
                    label: 'Laktasi Ke',
                  ),
                  TextField(
                    controller: controller.laktasiController.value,
                    hintText: 'Laktasi Ke',
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  FormLabel(
                    isRequired: true,
                    label: 'Produksi Susu pada hari ke',
                  ),
                  TextField(
                    controller: controller.hariProduksiSusu.value,
                    hintText: 'Produksi Susu pada hari ke',
                    keyboardType: TextInputType.phone,
                    enabled: true,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  FormLabel(
                    isRequired: false,
                    label: 'Produksi Susu Pagi',
                  ),
                  TextField(
                    controller: controller.susuPagiController.value,
                    hintText: 'Produksi Susu Pagi',
                    keyboardType: TextInputType.phone,
                    enabled: true,
                    suffixText: 'liter',
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  FormLabel(
                    isRequired: false,
                    label: 'Produksi Susu Sore',
                  ),
                  TextField(
                    controller: controller.susuSoreController.value,
                    hintText: 'Produksi Susu Sore',
                    keyboardType: TextInputType.phone,
                    enabled: true,
                    suffixText: 'liter',
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart' hide TextField;
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:get/get.dart';
import 'package:src/common/helper/date_formatter.dart';
import 'package:src/common/widget/keyboard_dismiss.dart';
import 'package:src/controller/tambah/kelahiran/tambah_kelahiran_controller.dart';

import '../../../common/helper/util.dart';
import '../../../common/widget/form_label.dart';
import '../../../common/widget/text_field.dart';

class TambahKelahiranPages extends StatelessWidget {
  const TambahKelahiranPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: TambahKelahiranController(),
        builder: (TambahKelahiranController controller) {
          return KeyboardDismissOntap(
            child: Scaffold(
              appBar: AppBar(
                title: StreamBuilder<bool?>(
                    stream: controller.outIsEdit,
                    builder: (context, snapshot) {
                      return Text(snapshot.data == true
                          ? 'Edit Kelahiran'
                          : 'Tambah Kelahiran');
                    }),
              ),
              bottomNavigationBar: ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    Size(double.infinity, 60),
                  ),
                ),
                onPressed: () {
                  controller.simpanKelahiran();
                },
                child: Text('Simpan'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormLabel(
                        isRequired: true,
                        label: 'Kelahiran Ke',
                      ),
                      TextField(
                        controller: controller.kelahiranKe.value,
                        hintText: 'Kelahiran Ke',
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      FormLabel(
                        isRequired: true,
                        label: 'Kondisi Kelahiran',
                      ),
                      StreamBuilder<String?>(
                          stream: controller.outselectedKondisiKelahiran,
                          builder: (context, selected) {
                            return StreamBuilder<List<String>>(
                                stream: controller.listKondisiKelahiran,
                                builder: (context, list) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.grey)),
                                    child: DropdownButton<String?>(
                                      hint: Text('Kondisi Kelahiran'),
                                      isExpanded: true,
                                      underline: SizedBox(),
                                      value: selected.data,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      items: list.data?.map((String? items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items ?? '-'),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        controller.inselectedKondisiKelahiran
                                            .add(newValue);
                                      },
                                    ),
                                  );
                                });
                          }),
                      SizedBox(
                        height: 16,
                      ),
                      FormLabel(
                        isRequired: true,
                        label: 'Proses Kelahiran',
                      ),
                      StreamBuilder<String?>(
                          stream: controller.outselectedProsesKelahiran,
                          builder: (context, selected) {
                            return StreamBuilder<List<String>>(
                                stream: controller.listProsesKelahiran,
                                builder: (context, list) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.grey)),
                                    child: DropdownButton<String?>(
                                      hint: Text('Proses Kelahiran'),
                                      isExpanded: true,
                                      underline: SizedBox(),
                                      value: selected.data,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      items: list.data?.map((String? items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items ?? '-'),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        controller.inselectedProsesKelahiran
                                            .add(newValue);
                                      },
                                    ),
                                  );
                                });
                          }),
                      SizedBox(
                        height: 16,
                      ),
                      FormLabel(
                        isRequired: true,
                        label: 'Tanggal Kelahiran',
                      ),
                      Obx(
                        () => TextButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                              EdgeInsets.zero,
                            ),
                          ),
                          onPressed: () {
                            DatePicker.showDatePicker(
                              context,
                              showTitleActions: true,
                              minTime: DateTime(1900, 3, 5),
                              maxTime: DateTime.now(),
                              onChanged: (date) {
                                controller.dateTime.value =
                                    date.toIso8601String();
                              },
                              onConfirm: (date) {
                                controller.dateTime.value =
                                    date.toIso8601String();
                              },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en,
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 45,
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.black54)),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  isNotBlank(controller.dateTime.value)
                                      ? CustomDateFormat.dateDMYHMS.format(
                                          DateTime.parse(
                                              controller.dateTime.value!))
                                      : 'Pilih Tanggal Kelahiran',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      FormLabel(
                        isRequired: true,
                        label: 'Jenis Kelahiran',
                      ),
                      StreamBuilder<String?>(
                          stream: controller.outselectedJenisKelahiran,
                          builder: (context, selected) {
                            return StreamBuilder<List<String>>(
                                stream: controller.listJenisKelahiran,
                                builder: (context, list) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.grey)),
                                    child: DropdownButton<String?>(
                                      hint: Text('Jenis Kelahiran'),
                                      isExpanded: true,
                                      underline: SizedBox(),
                                      value: selected.data,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      items: list.data?.map((String? items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items ?? '-'),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        controller.inselectedJenisKelahiran
                                            .add(newValue);
                                      },
                                    ),
                                  );
                                });
                          }),
                      SizedBox(
                        height: 16,
                      ),
                      FormLabel(
                        isRequired: true,
                        label: 'Berat Lahir',
                      ),
                      TextField(
                        controller: controller.beratLahir.value,
                        hintText: 'Berat Lahir',
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

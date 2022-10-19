import 'package:flutter/material.dart' hide TextField;
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:get/get.dart';
import 'package:src/common/helper/date_formatter.dart';
import 'package:src/common/helper/util.dart';
import 'package:src/common/model/sapi_model.dart';
import 'package:src/common/widget/keyboard_dismiss.dart';
import 'package:src/controller/tambah/pembiakan/tambah_pembiakan_controller.dart';

import '../../../common/arguments/arguments.dart';
import '../../../common/widget/chip_choice.dart';
import '../../../common/widget/form_label.dart';
import '../../../common/widget/text_field.dart';

class TambahPembiakanPages extends StatelessWidget {
  const TambahPembiakanPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: TambahPembiakanController(),
      builder: (TambahPembiakanController state) {
        return KeyboardDismissOntap(
          child: Scaffold(
              appBar: AppBar(
                title: StreamBuilder<CowModel?>(
                    stream: state.cowModelStream,
                    builder: (context, snapshot) {
                      return Column(
                        children: [
                          Text((snapshot.data?.name ?? '-').capitalizeFirst!),
                          Text(snapshot.data?.uniqueId ?? '-'),
                        ],
                      );
                    }),
              ),
              bottomNavigationBar: ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    Size(double.infinity, 60),
                  ),
                ),
                onPressed: () async {
                  state.submitTambahPembiakan();
                },
                child: Text('Simpan'),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 32.0, horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormLabel(
                      isRequired: true,
                      label: 'Tanggal Kawin',
                    ),
                    Obx(
                      () => TextButton(
                        onPressed: () {
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime(1900, 3, 5),
                            maxTime: DateTime.now(),
                            onChanged: (date) {
                              state.dateTime.value = date.toIso8601String();
                            },
                            onConfirm: (date) {
                              state.dateTime.value = date.toIso8601String();
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
                                isNotBlank(state.dateTime.value)
                                    ? CustomDateFormat.dateDMYHMS.format(
                                        DateTime.parse(state.dateTime.value!))
                                    : 'Pilih Tanggal',
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
                    Obx(
                      () => ChipChoices(
                        choices: ['Pejantan', 'Inseminasi Buatan'],
                        selectedIndex: state.hasilKawinDg.value,
                        onTap: state.switchHasilKawin,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Obx(
                      () => FormLabel(
                        isRequired: true,
                        label: state.hasilKawinDg.value == 0
                            ? 'Pejantan'
                            : 'Nomor Strow',
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Obx(
                      () => (state.hasilKawinDg.value == 1)
                          ? TextField(
                              controller: state.strowController.value,
                              hintText: 'Nomor Strow',
                              suffix: Text('Kg'),
                            )
                          : StreamBuilder<CowModel?>(
                              stream: state.selectedPejantanOut,
                              builder: (context, snapshot) {
                                return StreamBuilder<List<CowModel>?>(
                                    stream: state.listPejantanOut,
                                    builder: (context, listPejantan) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: DropdownButton<CowModel>(
                                          hint: Text('Pilih Pejantan'),
                                          isExpanded: true,
                                          underline: SizedBox(),
                                          value: snapshot.data,
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          items: listPejantan.data!
                                              .map((CowModel items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items.name ?? '-'),
                                            );
                                          }).toList(),
                                          onChanged: (CowModel? newValue) {
                                            state.selectedPejantanIn
                                                .add(newValue);
                                          },
                                        ),
                                      );
                                    });
                              }),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    FormLabel(
                      isRequired: true,
                      label: 'Perkawinan ini membuat induk bunting?',
                    ),
                    Obx(
                      () => ChipChoices(
                        choices: [
                          'Tidak',
                          'Ya',
                        ],
                        selectedIndex: state.buntingState.value,
                        onTap: state.switchBuntingState,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    FormLabel(
                      isRequired: true,
                      label: 'Jumlah Kawin/IB hingga bunting',
                    ),
                    TextField(
                      controller: state.jumlahKawin.value,
                      hintText: 'Jumlah Kawin/IB hingga bunting',
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    FormLabel(
                      isRequired: true,
                      label: 'SC',
                    ),
                    Obx(
                      () => Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey)),
                        child: DropdownButton<int>(
                          hint: Text('SC'),
                          isExpanded: true,
                          value: state.selectedSC.value,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          underline: SizedBox(),
                          items: state.listSC.map((int items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items.toString()),
                            );
                          }).toList(),
                          onChanged: (int? newValue) {
                            state.selectedSC.value = newValue!;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}

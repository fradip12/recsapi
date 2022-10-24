import 'package:flutter/material.dart' hide TextField;
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:get/get.dart';
import 'package:src/common/helper/date_formatter.dart';
import 'package:src/common/model/sapi_model.dart';
import 'package:src/common/widget/chip_choice.dart';
import 'package:src/common/widget/form_label.dart';
import 'package:src/common/widget/keyboard_dismiss.dart';
import 'package:src/controller/recording/add_sapi_controller.dart';

import '../../common/color/spacer.dart';
import '../../common/widget/text_field.dart';

class AddSapi extends StatefulWidget {
  const AddSapi({Key? key}) : super(key: key);

  @override
  State<AddSapi> createState() => _AddSapiState();
}

class _AddSapiState extends State<AddSapi> {
  List<Widget> widgetStep1(AddSapiController controller) {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          FormLabel(
            isRequired: true,
            label: 'Kode',
          ),
          TextField(
            controller: controller.codeController.value,
            hintText: 'Kode',
          ),
          SizedBox(height: Spacing.kSpacingHeight),
          //
          FormLabel(
            isRequired: true,
            label: 'Nama Sapi',
          ),
          TextField(
            controller: controller.usernameController.value,
            hintText: 'Nama Sapi',
          ),
          SizedBox(height: Spacing.kSpacingHeight),
          //
          FormLabel(
            isRequired: false,
            label: 'Bangsa',
          ),
          TextField(
            controller: controller.bangsaController.value,
            hintText: 'Bangsa',
          ),
          SizedBox(height: Spacing.kSpacingHeight),
          //
          FormLabel(
            isRequired: true,
            label: 'Jenis Kelamin',
          ),
          ChipChoices(
            choices: [
              'Betina',
              'Jantan',
            ],
            selectedIndex: controller.selectedGender.value,
            onTap: controller.switchGender,
          ),
          SizedBox(height: Spacing.kSpacingHeight),
          //
          FormLabel(
            isRequired: false,
            label: 'Warna',
          ),
          TextField(
            controller: controller.warnaController.value,
            hintText: 'Warna',
          ),
          SizedBox(height: Spacing.kSpacingHeight),
          FormLabel(
            isRequired: true,
            label: 'Induk',
          ),
          //---
          StreamBuilder<List<CowModel>?>(
              stream: controller.listIndukOut,
              builder: (context, listData) {
                return StreamBuilder<CowModel?>(
                    stream: controller.selectedIndukOut,
                    builder: (context, selected) {
                      return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey)),
                        child: DropdownButton<CowModel>(
                          hint: Text('Pilih Induk'),
                          isExpanded: true,
                          value: selected.data,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          underline: SizedBox(),
                          items: listData.data?.map((CowModel items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items.name ?? '-'),
                            );
                          }).toList(),
                          onChanged: (CowModel? newValue) {
                            controller.selectedIndukIn.add(newValue);
                          },
                        ),
                      );
                    });
              }),
          SizedBox(height: Spacing.kSpacingHeight),
          FormLabel(
            isRequired: true,
            label: 'Hasil Kawin dengan',
          ),
          ChipChoices(
            choices: ['Pejantan', 'Inseminasi Buatan'],
            selectedIndex: controller.hasilKawinDg.value,
            onTap: controller.switchHasilKawin,
          ),
          SizedBox(height: Spacing.kSpacingHeight),
          //
          FormLabel(
            isRequired: true,
            label:
                controller.hasilKawinDg.value == 0 ? 'Pejantan' : 'Nomor Strow',
          ),
          if (controller.hasilKawinDg.value == 1)
            TextField(
              controller: controller.strowController.value,
              hintText: 'Nomor Strow',
              suffix: Text('kg'),
            )
          else
            StreamBuilder<List<CowModel>?>(
                stream: controller.listPejantanOut,
                builder: (context, listData) {
                  return StreamBuilder<CowModel?>(
                      stream: controller.selectedPejantanOut,
                      builder: (context, selected) {
                        return Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey)),
                          child: DropdownButton<CowModel>(
                            hint: Text('Pilih Pejantan'),
                            isExpanded: true,
                            value: selected.data,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            underline: SizedBox(),
                            items: listData.data?.map((CowModel items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items.name ?? '-'),
                              );
                            }).toList(),
                            onChanged: (CowModel? newValue) {
                              controller.selectedPejantanIn.add(newValue);
                            },
                          ),
                        );
                      });
                }),
          SizedBox(height: Spacing.kSpacingHeight),
          //
          FormLabel(
            isRequired: true,
            label: 'Tanggal Lahir',
          ),
          TextButton(
            onPressed: () {
              DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                minTime: DateTime(1900, 3, 5),
                maxTime: DateTime.now(),
                onChanged: (date) {
                  controller.dateTime.value = date.toIso8601String();
                },
                onConfirm: (date) {
                  controller.dateTime.value = date.toIso8601String();
                },
                currentTime: DateTime.now(),
                locale: LocaleType.en,
              );
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Container(
              width: double.infinity,
              height: 45,
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black54)),
              child: Center(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      controller.dateTime.value != ''
                          ? CustomDateFormat.dateDMY
                              .format(DateTime.parse(controller.dateTime.value))
                          : 'Pilih Tanggal',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: Spacing.kSpacingHeight),
          //
          FormLabel(
            isRequired: false,
            label: 'Bobot Lahir',
          ),
          TextField(
            controller: controller.bobotLahirController.value,
            hintText: 'Bobot Lahir',
            suffixText: 'kg',
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: Spacing.kSpacingHeight),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          FormLabel(
            isRequired: true,
            label: 'Bobot Saat Umur 4 bulan',
          ),
          TextField(
            controller: controller.weight4MController.value,
            keyboardType: TextInputType.phone,
            hintText: 'Bobot Saat Umur 4 bulan',
            suffixText: 'kg',
          ),
          SizedBox(height: Spacing.kSpacingHeight),
          //
          FormLabel(
            isRequired: true,
            label: 'Bobot Saat Umur 1 tahun',
          ),
          TextField(
            controller: controller.weight1YController.value,
            keyboardType: TextInputType.phone,
            hintText: 'Bobot Saat Umur 1 tahun',
            suffixText: 'kg',
          ),
          SizedBox(height: Spacing.kSpacingHeight),
          //
          FormLabel(
            isRequired: true,
            label: 'Lingkar Dada saat umur 1 tahun',
          ),
          TextField(
            controller: controller.ld1YController.value,
            keyboardType: TextInputType.phone,
            hintText: 'Lingkar Dada saat umur 1 tahun',
            suffixText: 'cm',
          ),
          SizedBox(height: Spacing.kSpacingHeight),
          //
          FormLabel(
            isRequired: true,
            label: 'Panjang Badan Saat Umur 1 tahun',
          ),
          TextField(
            controller: controller.pb1YController.value,
            keyboardType: TextInputType.phone,
            hintText: 'Panjang Badan Saat Umur 1 tahun',
            suffixText: 'cm',
          ),
          SizedBox(height: Spacing.kSpacingHeight),
          //
          FormLabel(
            isRequired: true,
            label: 'Tinggi Pundak Saat Umur 1 tahun',
          ),
          TextField(
            controller: controller.tp1YsController.value,
            keyboardType: TextInputType.phone,
            hintText: 'Tinggi Pundak Saat Umur 1 tahun',
            suffixText: 'cm',
          ),
          SizedBox(height: Spacing.kSpacingHeight),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          FormLabel(
            isRequired: true,
            label: 'Catatan',
          ),
          TextField(
            controller: controller.notesController.value,
            hintText: 'Tambahkan Catatan yang diperlukan untuk recording',
            maxLines: 20,
          ),
          SizedBox(height: Spacing.kSpacingHeight),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOntap(
      child: GetBuilder(
          init: AddSapiController(),
          initState: (_) => Get.put(AddSapiController()).init(),
          builder: (AddSapiController controller) {
            return WillPopScope(
              onWillPop: () async {
                if (controller.activeSteps.value == 0) {
                  Get.back();
                } else {
                  controller.backStep();
                }
                return false;
              },
              child: Scaffold(
                appBar: AppBar(
                  title: StreamBuilder<bool?>(
                      stream: controller.isEditOut,
                      builder: (context, snapshot) {
                        return Text((snapshot.data ?? false)
                            ? 'Edit Sapi'
                            : 'Tambah Sapi');
                      }),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      if (controller.activeSteps.value == 0) {
                        Get.back();
                      } else {
                        controller.backStep();
                      }
                    },
                  ),
                ),
                body: Obx(
                  () => Stepper(
                    type: StepperType.horizontal,
                    currentStep: controller.activeSteps.value,
                    steps: controller.stepper
                        .asMap()
                        .map((i, element) => MapEntry(
                              i,
                              Step(
                                  title: Text(element),
                                  // TODO : State urus nanti, butuh validator form
                                  // state: controller.activeSteps.value == i
                                  //     ? StepState.complete
                                  //     : StepState.indexed,
                                  isActive: controller.activeSteps.value == i,
                                  content: widgetStep1(controller)[i]),
                            ))
                        .values
                        .toList(),
                    onStepContinue: controller.continueStep,
                    onStepCancel: controller.backStep,
                    controlsBuilder: (context, ControlsDetails details) {
                      return SizedBox(
                        width: Get.width,
                        child: ElevatedButton(
                          onPressed: details.onStepContinue,
                          child: Text('Selanjutnya'),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:src/common/arguments/arguments.dart';
import 'package:src/common/color/colors.dart';
import 'package:src/common/helper/date_formatter.dart';
import 'package:src/common/helper/util.dart';
import 'package:src/common/model/birth_model.dart';
import 'package:src/common/model/breeding_model.dart';
import 'package:src/common/model/sapi_model.dart';
import 'package:src/common/style/text_style.dart';

import '../../../controller/tambah/kelahiran/kelahiran_controller.dart';

class KelahiranPages extends StatelessWidget {
  const KelahiranPages({Key? key}) : super(key: key);

  List<Widget> _item(String title, String value, String idValue) {
    return [
      Text(
        title,
        style: kText10StyleBold.copyWith(color: Colors.black),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: Text(
              value,
              style: kText20StyleBold.copyWith(
                color: Colors.black,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Text(
              idValue,
              style: kText20StyleBold.copyWith(
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 12)
    ];
  }

  List<Widget> _itemBirth(String title, String value) {
    return [
      Text(
        title,
        style: kText10StyleBold.copyWith(color: Colors.black),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: Text(
              value,
              style: kText20StyleBold.copyWith(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 12)
    ];
  }

  Widget _breedingData(KelahiranController state) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 3,
      child: Container(
        padding: EdgeInsets.all(12),
        width: double.infinity,
        child: StreamBuilder<BreedingModel?>(
            stream: state.breedModelStream,
            builder: (context, breed) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: StreamBuilder<CowModel?>(
                        stream: state.cowModelStream,
                        builder: (context, cow) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _item('Induk', cow.data?.name ?? '-',
                                    cow.data?.uniqueId ?? '-') +
                                _item(
                                    'Di kawinkan dengan',
                                    breed.data?.maleName ?? 'Inseminasi Buatan',
                                    breed.data?.maleId ??
                                        breed.data!.strowNumber!) +
                                _item('Jumlah Kawin/ IB Hingga Bunting',
                                    '${breed.data?.sc} kali', '') +
                                _item(
                                    'SC', (breed.data?.sc ?? 0).toString(), ''),
                          );
                        }),
                  ),
                ],
              );
            }),
      ),
    );
  }

  Widget _birthCard(KelahiranController state) {
    return StreamBuilder<List<BirthModel>?>(
      stream: state.birthModelStream,
      builder: (context, snapshot) {
        if (snapshot.data?.isNotEmpty ?? false) {
          return Expanded(
            child: ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      clipBehavior: Clip.hardEdge,
                      elevation: 3,
                      child: Container(
                        padding: EdgeInsets.all(12),
                        width: double.infinity,
                        child: StreamBuilder<BreedingModel?>(
                            stream: state.breedModelStream,
                            builder: (context, breed) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _itemBirth('Kelahiran Ke',
                                              '${snapshot.data?[i].numberOfBirth ?? '-'}') +
                                          _itemBirth(
                                            'Kondisi Kelahiran',
                                            snapshot.data?[i].condition ?? '-',
                                          ) +
                                          _itemBirth(
                                            'Proses Kelahiran',
                                            snapshot.data?[i].process ?? '-',
                                          ) +
                                          _itemBirth(
                                            'Tanggal Kelahiran',
                                            isNotBlank(
                                                    snapshot.data?[i].birthdate)
                                                ? CustomDateFormat.dateDMYHMS
                                                    .format(DateTime.parse(
                                                        snapshot.data![i]
                                                            .birthdate!))
                                                : '-',
                                          ) +
                                          _itemBirth(
                                            'Jenis Kelahiran',
                                            snapshot.data?[i].birthType ?? '-',
                                          ) +
                                          _itemBirth(
                                            'Berat Lahir',
                                            isNotBlank(snapshot
                                                    .data?[i].birthWeight)
                                                ? '${snapshot.data?[i].birthWeight} Kg'
                                                : '-',
                                          ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () async {
                                        var res = await Get.toNamed(
                                          '/tambah-kelahiran',
                                          arguments: TambahKelahiranArguments(
                                              breed.data!,
                                              editData: snapshot.data![i]),
                                        );
                                        if (res != null && res) {
                                          state.init();
                                        }
                                      },
                                      child: Icon(
                                        FontAwesome5.edit,
                                        color: Clr.yellowPrimary,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }),
                      ),
                    ),
                  );
                }),
          );
        }
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          child: StreamBuilder<BreedingModel?>(
              stream: state.breedModelStream,
              builder: (context, breed) {
                return InkWell(
                  onTap: (breed.data?.pregnantState ?? false)
                      ? () async {
                          var res = await Get.toNamed('/tambah-kelahiran',
                              arguments: TambahKelahiranArguments(breed.data!));
                          if (res != null && res) {
                            state.init();
                          }
                        }
                      : () {
                          Get.snackbar(
                            'Info',
                            'Sapi Tidak Bunting',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      height: 45,
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Belum Ada Data Kelahiran',
                            style: kText12Style.copyWith(
                              color: Colors.black54,
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Clr.yellowPrimary,
                            radius: 10,
                            child: Icon(
                              FontAwesome5.plus,
                              color: Colors.white,
                              size: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: KelahiranController(),
        builder: (KelahiranController state) {
          return Scaffold(
            appBar: AppBar(
              title: StreamBuilder<BreedingModel?>(
                  stream: state.breedModelStream,
                  builder: (context, breed) {
                    return Column(
                      children: [
                        Text(breed.data?.breedDate?.isNotEmpty ?? false
                            ? CustomDateFormat.dateDMY
                                .format(DateTime.parse(breed.data!.breedDate!))
                            : '-'),
                      ],
                    );
                  }),
            ),
            bottomNavigationBar: StreamBuilder<BreedingModel?>(
                stream: state.breedModelStream,
                builder: (context, breed) {
                  return ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        Size(double.infinity, 60),
                      ),
                    ),
                    onPressed: (breed.data?.pregnantState ?? false)
                        ? () async {
                            var res = await Get.toNamed('/tambah-kelahiran',
                                arguments:
                                    TambahKelahiranArguments(breed.data!));
                            if (res != null && res) {
                              state.init();
                            }
                          }
                        : () {
                            Get.snackbar(
                              'Info',
                              'Sapi Tidak Bunting',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          },
                    child: Text('Tambah Kelahiran'),
                  );
                }),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [_breedingData(state), _birthCard(state)],
              ),
            ),
          );
        });
  }
}

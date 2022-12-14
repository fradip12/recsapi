import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:get/get.dart';
import 'package:src/common/arguments/arguments.dart';
import 'package:src/common/color/colors.dart';
import 'package:src/common/color/spacer.dart';
import 'package:src/common/helper/date_formatter.dart';
import 'package:src/common/model/sapi_model.dart';
import 'package:src/common/style/text_style.dart';
import 'package:src/common/widget/no_data.dart';
import 'package:src/common/widget/shimmer.dart';
import 'package:src/controller/sapi/sapi_saya_controller.dart';

class SapiSaya extends StatelessWidget {
  const SapiSaya({Key? key}) : super(key: key);

  _gender(int index) {
    switch (index) {
      case 0:
        return 'Betina';
      case 1:
        return 'Jantan';
      default:
        return 'Undefined';
    }
  }

  _genderIcon(int index) {
    if (index == 0) {
      return Icon(
        Elusive.female,
        size: 15,
        color: Colors.pinkAccent,
      );
    } else if (index == 1) {
      return Icon(
        Elusive.male,
        size: 15,
        color: Clr.yellowPrimary,
      );
    }
  }

  Widget _cardSapi(CowModel e) {
    var age;
    if (e.birthdate != null) {
      age = DateTime.now().difference(DateTime.parse(e.birthdate!)).inDays;
    } else {
      age = 0;
    }

    return GestureDetector(
      onTap: () {
        Get.toNamed('/sapi-detail', arguments: DetailSapiArguments(e));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: double.infinity,
          height: 100,
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.name!.capitalizeFirst!,
                    style: kText16StyleBold.copyWith(color: Colors.black),
                  ),
                  Text(
                    e.uniqueId!.capitalizeFirst!,
                    style: kText16StyleBold.copyWith(color: Colors.black38),
                  ),
                  SizedBox(height: Spacing.kSpacingHeight),
                  Row(
                    children: [
                      _genderIcon(e.gender!),
                      SizedBox(width: Spacing.kSpacingHeight / 2),
                      Text(
                        _gender(e.gender!),
                        style: kText16StyleBold.copyWith(color: Colors.black38),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    age.toString() + ' hari',
                    style: kText16StyleBold.copyWith(color: Colors.black),
                  ),
                  Text(
                    e.breed!.capitalizeFirst!,
                    style: kText16StyleBold.copyWith(color: Colors.black38),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SapiSayaController(),
        builder: (SapiSayaController controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Sapi Saya'),
              actions: const [Icon(Icons.filter_list)],
            ),
            bottomNavigationBar: ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  Size(double.infinity, 60),
                ),
              ),
              onPressed: () {
                controller.tambahSapi();
              },
              child: Text('Tambah Sapi'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (text) {
                      Timer? _debounce;
                      if (_debounce?.isActive ?? false) _debounce?.cancel();
                      _debounce = Timer(const Duration(milliseconds: 500), () {
                        // Do Search here
                        controller.searchListenerSink.add(text);
                        controller.init();
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                      fillColor: Color(0xffF6F6F6),
                      isDense: true,
                      filled: true,
                      hintText: "Cari berdasarkan nama sapi, kode sapi ...",
                      prefixIcon: Icon(
                        Icons.search,
                        size: 24,
                        color: Theme.of(context).primaryColor,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: Color(0xffe8e8e8), width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: Color(0xffe8e8e8), width: 1.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Spacing.kSpacingHeight,
                  ),
                  Expanded(
                    child: StreamBuilder<List<CowModel>?>(
                        stream: controller.sapiSayaStream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return ListView.builder(
                                itemCount: 8,
                                shrinkWrap: true,
                                primary: true,
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6.0),
                                    child: ShimmerWidget.rectRadius(
                                      height: 65,
                                      width: double.infinity,
                                      shapeBorder: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  );
                                });
                          }
                          if (snapshot.hasData) {
                            if (snapshot.data?.isNotEmpty ?? false) {
                              return ListView.builder(
                                  itemCount: snapshot.data?.length,
                                  shrinkWrap: true,
                                  primary: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, i) {
                                    return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6.0),
                                        child: _cardSapi(snapshot.data![i]));
                                  });
                            }
                            return Center(
                              child: NoData(
                                message:
                                    'Belum Ada data sapi\nTambahkan Recording Sekarang',
                                child: CircleAvatar(
                                  radius: 22,
                                  backgroundColor: Colors.grey[200],
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.black26,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Center(child: Text('No Data'));
                          }
                        }),
                  )
                ],
              ),
            ),
          );
        });
  }
}

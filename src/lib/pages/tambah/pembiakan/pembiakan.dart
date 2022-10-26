import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:src/common/arguments/arguments.dart';
import 'package:src/common/widget/sapi_saya_widget.dart';
import 'package:src/pages/sapi/sapi_saya.dart';

import '../../../common/color/spacer.dart';
import '../../../common/model/sapi_model.dart';
import '../../../common/widget/no_data.dart';
import '../../../common/widget/shimmer.dart';
import '../../../controller/tambah/pembiakan/pembiakan_controller.dart';

class PembiakanPages extends StatelessWidget {
  const PembiakanPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PembiakanController(),
      builder: (PembiakanController state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Sapi Saya'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  onChanged: (text) {
                    Timer? _debounce;
                    if (_debounce?.isActive ?? false) _debounce?.cancel();
                    _debounce = Timer(const Duration(milliseconds: 500), () {
                      // Do Search here
                      state.searchListenerSink.add(text);
                      state.init();
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
                      stream: state.outListSapiBeti,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ListView.builder(
                              itemCount: 8,
                              shrinkWrap: true,
                              primary: true,
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6.0),
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
                                    child: SapiSayaCard(
                                      onTapRoute: 'tambah-pembiakan-detail',
                                      e: snapshot.data![i],
                                      arguments: PembiakanDetailArguments(
                                        snapshot.data![i].id!,
                                      ),
                                    ),
                                  );
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
      },
    );
  }
}

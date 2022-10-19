import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:src/common/arguments/arguments.dart';

import '../../../common/color/spacer.dart';
import '../../../common/model/sapi_model.dart';
import '../../../common/widget/sapi_saya_widget.dart';
import '../../../common/widget/shimmer.dart';
import '../../../controller/tambah/susu/susu_pages_controller.dart';

class SusuPages extends StatelessWidget {
  const SusuPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SusuPagesController(),
      builder: (SusuPagesController controller) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Pilih Sapi'),
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
                        stream: controller.outListSapiBeti,
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
                                      child: SapiSayaCard(
                                        onTapRoute: '/susu-produksi',
                                        e: snapshot.data![i],
                                        arguments: ProduksiSusuArguments(
                                          snapshot.data![i],
                                        ),
                                      ),
                                    );
                                  });
                            }
                            return Container();
                          } else {
                            return Center(child: Text('No Data'));
                          }
                        }),
                  )
                ],
              ),
            ));
      },
    );
  }
}

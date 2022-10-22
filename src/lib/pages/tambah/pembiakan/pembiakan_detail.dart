import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:src/common/arguments/arguments.dart';
import 'package:src/common/color/colors.dart';
import 'package:src/common/helper/date_formatter.dart';
import 'package:src/common/helper/util.dart';
import 'package:src/common/model/breeding_model.dart';
import 'package:src/common/model/sapi_model.dart';
import 'package:src/common/style/text_style.dart';
import 'package:src/common/widget/no_data.dart';
import 'package:src/common/widget/shimmer.dart';
import 'package:src/controller/tambah/pembiakan/pembiakan_detail_controller.dart';

class PembiakanDetail extends StatelessWidget {
  const PembiakanDetail({Key? key}) : super(key: key);

  Widget breedingCard(CowModel? sapi, BreedingModel? breed) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/kelahiran',
            arguments: KelahiranPagesArguments(
              breed!,
            ));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.hardEdge,
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Kawin Ke : ${breed?.sc == 0 ? '-' : breed!.sc.toString()} ',
                    style: kText12StyleBold.copyWith(
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    isNotBlank(breed?.breedDate)
                        ? CustomDateFormat.dateDMYHMS
                            .format(DateTime.parse(breed!.breedDate!))
                        : '-',
                    style: kText12StyleBold.copyWith(
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 55,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    (breed?.pregnantState ?? false)
                        ? 'Bunting'
                        : 'Tidak Bunting',
                    style: kText16StyleBold.copyWith(
                      color: (breed?.pregnantState ?? false)
                          ? Clr.yellowPrimary
                          : Colors.red,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Elusive.male,
                        color: Clr.yellowPrimary,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (breed?.maleName != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              (breed?.maleName ?? '-').capitalizeFirst!,
                              style: kText16StyleBold.copyWith(
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              breed?.maleId ?? '-',
                              style: kText16StyleBold.copyWith(
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        )
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Strow Number',
                              style: kText14Style.copyWith(
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              breed?.strowNumber ?? '-',
                              style: kText16StyleBold.copyWith(
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        )
                    ],
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
      init: PembiakanDetailController(),
      builder: (PembiakanDetailController state) {
        return Scaffold(
          appBar: AppBar(
            title: StreamBuilder<CowModel?>(
                stream: state.outCowModel,
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
              var res = await Get.toNamed('/tambah-pembiakan-item');
              Logger().w(res);
              state.init();
            },
            child: Text('Tambah Pembiakan'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: StreamBuilder<List<BreedingModel>?>(
                stream: state.outBreeding,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                        itemCount: 4,
                        itemBuilder: (_, i) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ShimmerWidget.rectRadius(
                              height: 125,
                              width: double.infinity,
                              shapeBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        });
                  }
                  if (snapshot.hasData &&
                      (snapshot.data?.isNotEmpty ?? false)) {
                    return StreamBuilder<CowModel?>(
                        stream: state.outCowModel,
                        builder: (context, sapi) {
                          return ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (_, i) {
                                return breedingCard(
                                    sapi.data, snapshot.data?[i]);
                              });
                        });
                  } else {
                    return NoData(
                      child: CircleAvatar(
                        backgroundColor: Colors.black12,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                      message:
                          'Sapi ini belum pernah Kawin \nTambahkan Recording Sekarang',
                    );
                  }
                }),
          ),
        );
      },
    );
  }
}

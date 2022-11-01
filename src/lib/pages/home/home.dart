import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:src/common/color/colors.dart';
import 'package:src/common/color/spacer.dart';
import 'package:src/common/model/summary_model.dart';
import 'package:src/common/widget/home_menu_card.dart';
import 'package:src/common/widget/home_profile_area.dart';
import 'package:src/controller/home/home_controller.dart';
import '../../common/style/text_style.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  _seeder(SummaryModel data) {
    List _value = <String>[];
    _value.add((data.indukCount ?? 0).toString());
    _value.add((data.jantanCount ?? 0).toString());
    _value.add((data.anakJantanCount ?? 0).toString());
    _value.add((data.anakBetinaCount ?? 0).toString());
    return _value;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (HomeController controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Clr.primary,
            elevation: 0,
          ),
          body: SafeArea(
            minimum: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                HomeProfile(
                    name: controller.mainController.user.value.email ?? '-'),
                SizedBox(height: Spacing.kSpacingHeight),

                // Blue Card Area
                Card(
                  elevation: 4,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Container(
                    height: Get.height * 0.28,
                    width: Spacing.getWidth(context),
                    padding: const EdgeInsets.all(20),
                    color: Clr.bluePrimary,
                    child: StreamBuilder<SummaryModel?>(
                        stream: controller.summary,
                        builder: (context, snapshot) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sapi',
                                style: kText20StyleBold.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 3),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: summaryOf(
                                        controller.total[0],
                                        (snapshot.data?.cowCount ?? 0)
                                            .toString()),
                                  ),
                                  Flexible(
                                    flex: 6,
                                    child: MasonryGridView.count(
                                      primary: false,
                                      shrinkWrap: true,
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 16,
                                      itemCount: 4,
                                      itemBuilder: (context, index) {
                                        return summaryOf(
                                          controller.myProducts[index],
                                          _seeder(snapshot.data!)[index],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Spacing.kSpacingHeight),
                              //SUSU
                              Text(
                                'Produksi Susu',
                                style: kText20StyleBold.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 3),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                      flex: 2,
                                      child: summaryOf(
                                         'Total',
                                          ((snapshot.data?.milkCount ?? 0))
                                              .toString())),
                                  Flexible(
                                    flex: 6,
                                    child: MasonryGridView.count(
                                      primary: false,
                                      shrinkWrap: true,
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 16,
                                      itemCount: 1,
                                      itemBuilder: (context, index) {
                                        return summaryOf(
                                          'Rata-Rata',
                                          ((snapshot.data?.milkCount ?? 0) /
                                                  (snapshot.data!.indukCount!))
                                              .toStringAsFixed(1),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                  ),
                ),
                SizedBox(height: Spacing.kSpacingHeight),

                //Menu Card
                Expanded(
                  child: MasonryGridView.count(
                    primary: false,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 16,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return MenuCard(
                        title: controller.myMenu[index].title ?? '-',
                        route: controller.myMenu[index].route ?? '-',
                        icon: controller.myMenu[index].icon ??
                            "asset/images/logo/logo.png",
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  summaryOf(String name, String total) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(total, style: kText20StyleBold),
        Text(name, style: kText12Style)
      ],
    );
  }
}

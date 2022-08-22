import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:src/common/color/colors.dart';
import 'package:src/common/color/spacer.dart';
import 'package:src/common/widget/home_menu_card.dart';
import 'package:src/common/widget/home_profile_area.dart';
import 'package:src/controller/home/home_controller.dart';

import '../../common/style/textstyle.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (HomeController controller) {
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16),
              child: Column(
                children: [
                  HomeProfile(
                      name: controller.mainController.user.value.email ?? '-'),
                  SizedBox(height: Spacing.kSpacingHeight),
                  // Blue Card Area
                  Card(
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      height: 230,
                      width: double.infinity,
                      color: Clr.bluePrimary,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('0', style: kText24StyleBold),
                                      Text(controller.total[0],
                                          style: kText16StyleBold)
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('0', style: kText24StyleBold),
                                      Text(controller.total[1],
                                          style: kText16StyleBold)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 3 / 2,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20),
                              itemCount: 4,
                              itemBuilder: (BuildContext ctx, index) {
                                return Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('0', style: kText24StyleBold),
                                      Text(controller.myProducts[index],
                                          style: kText16StyleBold)
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Spacing.kSpacingHeight),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 300,
                              childAspectRatio: 0.9,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemCount: 4,
                      itemBuilder: (BuildContext ctx, index) {
                        return MenuCard(
                          title: controller.myMenu[index].title ?? '-',
                          route: controller.myMenu[index].route ?? '-',
                        );
                      },
                    ),
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

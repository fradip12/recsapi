import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:src/common/color/colors.dart';
import 'package:src/common/color/spacer.dart';
import 'package:src/common/widget/home_menu_card.dart';
import 'package:src/common/widget/home_profile_area.dart';
import 'package:src/controller/home/home_controller.dart';
import '../../common/style/text_style.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
                    height: 210,
                    width: Spacing.getWidth(context),
                    padding: const EdgeInsets.all(20),
                    color: Clr.bluePrimary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            summaryOf(controller.total[0], "20"),
                            summaryOf(controller.total[1], "33 L"),
                          ],
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 300,
                                    childAspectRatio: 3,
                                    crossAxisSpacing: 20),
                            itemCount: 2,
                            itemBuilder: (BuildContext ctx, index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  summaryOf(controller.myProducts[index], "5"),
                                  summaryOf(
                                      controller.myProducts[index + 1], "5"),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
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
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(total, style: kText20StyleBold),
          Text(name, style: kText12Style)
        ],
      ),
    );
  }
}

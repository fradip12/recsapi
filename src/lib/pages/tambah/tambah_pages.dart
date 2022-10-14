import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:src/controller/tambah/tambah_pages_controller.dart';

import '../../common/widget/home_menu_card.dart';

class TambahPages extends StatelessWidget {
  const TambahPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: TambahPagesController(),
        initState: (_) => Get.put(TambahPagesController()).init(),
        builder: (TambahPagesController controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Tambah Recording'),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical : 32.0, horizontal : 16.0),
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
          );
        });
  }
}

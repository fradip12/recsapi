import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:src/common/color/colors.dart';
import 'package:src/common/style/text_style.dart';
import 'package:src/controller/lihat%20recording/lihat_recording_controller.dart';

class LihatRecordingPages extends StatelessWidget {
  const LihatRecordingPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: LihatRecordingController(),
        builder: (LihatRecordingController controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Lihat Recording'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: StreamBuilder<List<String>>(
                  stream: controller.menu,
                  builder: (context, menu) {
                    return ListView.builder(
                        itemCount: menu.data?.length,
                        itemBuilder: (_, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              onTap: () {
                                switch (index) {
                                  case 0:
                                    controller.getSapi();
                                    break;
                                  case 1:
                                    controller.getBreeding();
                                    break;
                                  case 2:
                                    controller.getBirth();
                                    break;
                                  case 3:
                                    controller.getMilk();
                                    break;
                                }
                              },
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    menu.data?[index] ?? '',
                                    style: kText12Style.copyWith(
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Clr.yellowPrimary,
                                    size: 15,
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }),
            ),
          );
        });
  }
}

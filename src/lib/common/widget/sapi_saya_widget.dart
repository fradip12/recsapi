import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../arguments/arguments.dart';
import '../model/sapi_model.dart';
import '../style/text_style.dart';

class SapiSayaCard extends StatelessWidget {
  final String? onTapRoute;
  final CowModel? e;
  final dynamic arguments;
  const SapiSayaCard({Key? key, this.onTapRoute, this.e, this.arguments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var age;
    if (e?.birthdate != null) {
      age = DateTime.now().difference(DateTime.parse(e!.birthdate!)).inDays;
    } else {
      age = 0;
    }

    return GestureDetector(
      onTap: () {
        if (arguments != null) {
          Get.toNamed(onTapRoute ?? '/sapi-detail', arguments: arguments);
        } else {
          Get.toNamed(onTapRoute ?? '/sapi-detail');
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: double.infinity,
          height: 75,
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e?.name!.capitalizeFirst ?? '-',
                    style: kText16StyleBold.copyWith(color: Colors.black),
                  ),
                  Text(
                    e?.uniqueId!.toUpperCase() ?? '-',
                    style: kText16StyleBold.copyWith(color: Colors.black38),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    age.toString() + ' hari',
                    style: kText16StyleBold.copyWith(color: Colors.black),
                  ),
                  Text(
                    e?.breed!.capitalizeFirst ?? '-',
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
}

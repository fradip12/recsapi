import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../color/colors.dart';
import '../style/textstyle.dart';

class MenuCard extends StatelessWidget {
  final String title;
  final String route;
  const MenuCard({Key? key, required this.title, required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(route),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 4,
        child: Container(
          height: 100,
          width: 100,
          alignment: Alignment.center,
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Expanded(
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Clr.bluePrimary,
                  child: Text('logo'),
                ),
              ),
              Text(
                title,
                style: kText16StyleBold.copyWith(
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

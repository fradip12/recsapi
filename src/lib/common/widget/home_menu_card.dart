import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../style/text_style.dart';

class MenuCard extends StatelessWidget {
  final String title;
  final String route;
  final String icon;
  const MenuCard(
      {Key? key, required this.title, required this.route, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(route),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 3,
        child: Container(
          height: 150,
          width: 150,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Expanded(
                child: CircleAvatar(
                  radius: 45,
                  child: SvgPicture.asset(
                    icon,
                    semanticsLabel: 'A red up arrow',
                  ),
                  backgroundColor: Colors.white,
                ),
              ),
              Text(
                title,
                style: kText12StyleBold.copyWith(color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../style/text_style.dart';

class MenuCard extends StatelessWidget {
  final String title;
  final String route;
  final String icon;
  const MenuCard({Key? key, required this.title, required this.route, required this.icon})
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
          height: 120,
          width: 100,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Expanded(
                child: CircleAvatar(
                  radius: 45,
                  child: Image(image: AssetImage(icon)),
                  backgroundColor: Colors.white,
                ),
              ),
              Text(
                title,
                style: kText12StyleBold.copyWith(
                  color: Colors.black87
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

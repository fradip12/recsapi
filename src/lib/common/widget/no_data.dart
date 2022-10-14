import 'package:flutter/material.dart';
import 'package:src/common/style/text_style.dart';

class NoData extends StatelessWidget {
  final String? message;
  final Widget? child;
  const NoData({Key? key, this.message, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          child ?? Container(),
          Text(
            message ?? 'No Data Available',
            textAlign: TextAlign.center,
            style: kText12Style.copyWith(color: Colors.black45),
          ),
        ],
      ),
    );
  }
}

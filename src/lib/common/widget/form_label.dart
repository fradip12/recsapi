import 'package:flutter/material.dart';

class FormLabel extends StatelessWidget {
  final String? label;
  final bool? isRequired;
  final TextStyle? style;
  const FormLabel({
    Key? key,
    this.label,
    this.isRequired = false,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(children: <TextSpan>[
          TextSpan(
            text: label,
            style: TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: isRequired == true ? ' *' : '',
            style: TextStyle(color: Colors.black)
          ),
        ]),
      ),
    );
  }
}

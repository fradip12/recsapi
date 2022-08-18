import 'package:flutter/material.dart';

class KeyboardDismissOntap extends StatelessWidget {
  final Widget child;
  const KeyboardDismissOntap({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}

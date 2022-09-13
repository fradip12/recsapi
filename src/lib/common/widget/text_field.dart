import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart' as material;

/// TextField wraps a material text field with streams that can be used for
/// state management. The stream is used to set the current value, and also to
/// provide an error message if, for example, validation of the text failed.
class TextField extends StatefulWidget {
  /// label is the text that describes the content of this text field to the
  /// user.
  final String? label;

  /// image is optional in case we needed to include to the end of the text input.
  /// use as optional named (image: "assets/imageName")
  final String? image;

  final bool? autofocus;

  // should make the textfield smaller to fit multiple textfields in a row.
  final bool? smallPadding;

  /// keyboardType specifies which keyboard will be displayed to the user, for
  /// example if they are typing an email address [TextInputType.email] will
  /// show a keyboard with an "@" button.
  final TextInputType? keyboardType;

  /// isPassword obscures the text that the user enters.
  final bool? isPassword;

  // hintText is acting as hintText in flutter TextField, simply a placeholder
  final String? hintText;

  /// imageTapFunction executes when tapping the image.
  final void Function()? imageTapFunction;

  ///validator
  final String? Function(String?)? validator;

  ///if true, the action after onpress will be move to the next field
  final bool? textActionNext;

  final double? height;

  final bool? hasFocusedBorder;
  final bool? hasBorders;

  final List<TextInputFormatter>? inputFormatters;

  final int? maxLines;

  final String? suffixText;
  final TextStyle? suffixStyle;
  final Widget? suffix;
  final bool enabled;
  final bool isRequired;

  final InputBorder? customBorder;

  final double? leftPadding;

  final GlobalKey<FormState>? formKey;
  final InputDecorationTheme? decoration;

  final TextEditingController? controller;

  const TextField({
    this.enabled = true,
    this.label,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.autofocus = false,
    this.image,
    this.imageTapFunction,
    this.hintText,
    this.hasFocusedBorder = false,
    this.inputFormatters,
    this.maxLines,
    this.hasBorders = false,
    this.height = 50,
    this.smallPadding = false,
    this.textActionNext,
    this.suffixText,
    this.suffixStyle,
    this.suffix,
    this.validator,
    this.isRequired = false,
    this.customBorder,
    this.leftPadding = 20.0,
    this.formKey,
    this.decoration,
    this.controller,
  });

  @override
  _TextFieldState createState() => _TextFieldState();
}

class _TextFieldState extends State<TextField> {
  StreamSubscription<String?>? valueSub;
  StreamSubscription<String?>? updateValueSub;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    updateValueSub?.cancel();
    valueSub?.cancel();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget _renderTextField() {
    return Form(
      key: widget.formKey ?? _formKey,
      child: material.TextFormField(
        enabled: widget.enabled,
        inputFormatters: widget.inputFormatters,
        autofocus: widget.autofocus!,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textActionNext == true
            ? TextInputAction.next
            : TextInputAction.done,
        decoration: InputDecoration(
          hintText: widget.hintText,
        ),
        onChanged: (_) {
          _formKey.currentState?.validate();
        },
        obscureText: widget.isPassword!,
        style: Theme.of(context).textTheme.bodyText2,
        maxLines: widget.maxLines,
      ),
    );
  }

  Widget? _suffixIcon() => widget.image != null
      ? GestureDetector(
          onTap: widget.imageTapFunction,
          child: ClipRRect(
            // borderRadius: const BorderRadius.only(
            //     bottomRight: Radius.circular(10.0),
            //     topRight: Radius.circular(10.0)),
            clipBehavior: Clip.hardEdge,
            child: Container(
              width: 57.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    widget.image!,
                  ),
                ),
                // color: kTextFieldQRBackgroundColour,
                // border: Border(left: BorderSide(color: kBorderColour, width: 1)),
              ),
            ),
          ),
        )
      : null;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        widget.label != null
            ? Row(
                children: <Widget>[
                  Text(
                    widget.label!,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              )
            : Container(),
        _renderTextField(),
      ],
    );
  }
}

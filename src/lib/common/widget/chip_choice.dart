import 'package:flutter/material.dart';
import 'package:src/common/color/colors.dart';

class ChipChoices extends StatefulWidget {
  final List<String> choices;
  final int selectedIndex;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final Function()? onTap;
  const ChipChoices(
      {Key? key,
      required this.choices,
      required this.selectedIndex,
      this.selectedColor,
      this.unselectedColor,
      this.selectedTextColor,
      this.unselectedTextColor,
      this.onTap})
      : super(key: key);

  @override
  State<ChipChoices> createState() => _ChipChoicesState();
}

class _ChipChoicesState extends State<ChipChoices> {
  @override
  Widget build(BuildContext context) {
    return Row(
        children: widget.choices
            .asMap()
            .map((key, value) => MapEntry(
                  key,
                  Expanded(
                    child: GestureDetector(
                      onTap: widget.onTap,
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Chip(
                            backgroundColor: widget.selectedIndex == key
                                ? Clr.bluePrimary
                                : Colors.grey[200],
                            label: Container(
                              width: double.infinity,
                              height: 35,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Center(
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: widget.selectedIndex == key
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ),
                  ),
                ))
            .values
            .toList());
  }
}

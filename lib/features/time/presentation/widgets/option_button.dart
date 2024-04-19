import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/fonts.dart';

class OptionButton extends StatefulWidget {
  const OptionButton(
      {super.key,
      required this.index,
      required this.indexSelected,
      required this.label,
      this.onPressed});
  final int index;
  final int indexSelected;
  final String label;
  final VoidCallback? onPressed;

  @override
  State<OptionButton> createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        backgroundColor:
            widget.indexSelected == widget.index ? pinkColor : grayColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(widget.label,
          style: widget.indexSelected == widget.index
              ? textBlackStyleSmall
              : textWhiteStyle),
    );
  }
}

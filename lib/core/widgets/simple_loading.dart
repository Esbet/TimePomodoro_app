
import 'package:flutter/material.dart';
import 'package:timepomodoro_app/core/theme/colors.dart';

class SimpleLoading extends StatelessWidget {
  final Color color, colorProgress;
  const SimpleLoading(
      {super.key, required this.color, this.colorProgress = pinkColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: CircularProgressIndicator(
          color: colorProgress,
        ),
      ),
    );
  }
}

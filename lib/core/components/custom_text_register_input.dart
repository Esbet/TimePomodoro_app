import 'package:flutter/material.dart';
import '../theme/fonts.dart';
import '../utils/input_decoration_style.dart';


class CustomTextRegisterInput extends StatelessWidget {
  final IconData? icon;
  final String placeholder;
  final TextEditingController? textController;
  final TextInputType keyboardType;
  final bool isPassword;
  final void Function(String value)? onChanged;
  final String? errorText;
  final bool? isEnabled;
  final Widget? suffixIcon;


  const CustomTextRegisterInput(
      {super.key,
      this.icon,
      required this.placeholder,
      this.textController,
      this.keyboardType = TextInputType.text,
      this.isPassword = false,
      this.onChanged,
      this.errorText,
      this.isEnabled,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: textController,
          autocorrect: false,
          enabled: isEnabled,
          style: textWhiteStyleSubtitle,
          keyboardType: keyboardType,
          obscureText: isPassword,
          onChanged: onChanged,
          decoration: inputStyle(errorText, placeholder, icon, suffixIcon)
        ),
      
      ],
    );
  }
}

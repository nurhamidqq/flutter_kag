import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kag/app/config/colors.dart';

class FormCustom extends StatelessWidget {
  const FormCustom(
      {super.key,
      this.readonly = false,
      required this.context,
      required this.label,
      required this.iconRight,
      this.validator,
      this.obscureText = false,
      this.maxLength = 50,
      this.icon,
      this.controller,
      this.keyboardType,
      this.onTapRightIcon,
      this.inputFormatters,
      this.onChange});
  final bool readonly;
  final BuildContext context;
  final String label;
  final bool iconRight;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function()? onTapRightIcon;
  final Function(dynamic)? onChange;
  final String? Function(String?)? validator;
  final Widget? icon;
  final int maxLength;
  final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      maxLength: maxLength,
      maxLines: 1,
      readOnly: readonly,
      obscureText: obscureText,
      controller: controller,
      onChanged: onChange,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          counterText: '',
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: AppColors.red)),
          border: OutlineInputBorder(
            //borderSide: BorderSide(color: AppColors.neutral300),
            borderRadius: BorderRadius.circular(5.0),
          ),
          hintText: label,
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          suffixIcon: iconRight
              ? GestureDetector(
                  onTap: onTapRightIcon,
                  child: icon!,
                )
              : const SizedBox()),
    );
  }
}

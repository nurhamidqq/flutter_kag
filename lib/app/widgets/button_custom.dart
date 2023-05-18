import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kag/app/config/colors.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({
    Key? key,
    required this.onPressed,
    this.label = '',
    this.elevation = 0,
    this.shape,
    this.backgroundColor,
    this.splashColor,
    this.textColor,
    this.padding,
    this.textStyle,
    this.border,
    this.isLoading = false,
    this.borderColor,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String label;
  final double? elevation;
  final OutlinedBorder? shape;
  final Color? backgroundColor;
  final Color? splashColor;

  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final Color? border;
  final Color? textColor;
  final Color? borderColor;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? () => false : onPressed,
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        padding: padding,
        backgroundColor: backgroundColor,
      ),
      child: isLoading
          ? Center(
              child: CupertinoActivityIndicator(
                  color: textColor ?? AppColors.white),
            )
          : Text(
              label,
              style: textStyle ??
                  TextStyle(
                    color: textColor ?? AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
    );
  }
}

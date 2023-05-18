import 'package:flutter/cupertino.dart';
import 'package:flutter_kag/app/config/colors.dart';

// ignore: must_be_immutable
class LoadingIndicator extends StatelessWidget {
  LoadingIndicator({super.key, this.color});
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        color: color ?? AppColors.white,
        radius: 12,
      ),
    );
  }
}

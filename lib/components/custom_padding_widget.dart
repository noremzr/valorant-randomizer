import 'package:flutter/material.dart';

class CustomPaddingWidget extends StatelessWidget {
  final Widget? child;
  final double? basePadding;
  const CustomPaddingWidget({
    super.key,
    this.child,
    this.basePadding,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double scaleH = size.height / 1080;
    double scaleW = size.width / 1920;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: basePadding ?? 8 * scaleW,
        vertical: basePadding ?? 8 * scaleH,
      ),
      child: child,
    );
  }
}

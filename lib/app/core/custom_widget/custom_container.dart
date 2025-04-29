import 'package:flutter/material.dart';
 
import '../utils/app_colors.dart'; // <-- apna correct path lagana

class CustomContainer extends StatelessWidget {
  final double? borderRadius;
  final Color? backgroundColor;
  final double? elevation;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxBorder? border;
  final AlignmentGeometry? alignment;
  final double? width;
  final double? height;

  const CustomContainer({
    Key? key,
    this.borderRadius,
    this.backgroundColor,
    this.elevation,
    this.child,
    this.padding,
    this.margin,
    this.border,
    this.alignment,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin ?? const EdgeInsets.all(8.0),
      padding: padding ?? const EdgeInsets.all(16.0),
      alignment: alignment ?? Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primaryColor, // ⭐️ runtime default
        borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
        border: border,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: elevation ?? 4.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

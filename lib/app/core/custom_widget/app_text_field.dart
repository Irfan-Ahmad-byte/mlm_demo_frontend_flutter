import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/responsive_widget.dart';

import '../../core/utils/app_colors.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final String hint;
  final bool isPassword;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final IconData? icon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final VoidCallback? leftButtonOnPressed; // NEW
  final IconData? leftButtonIcon; // NEW

  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.isPassword = false,
    this.icon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.backgroundColor,
    this.leftButtonOnPressed,
    this.leftButtonIcon,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: 15,
                color: AppColors.textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        Row(
          children: [
            if (widget.leftButtonIcon != null)
              IconButton(
                onPressed: widget.leftButtonOnPressed,
                icon: Icon(widget.leftButtonIcon, color: AppColors.hintColor),
              ),
            Expanded(
              child: SizedBox(
                height: ResponsiveWidget.isCustomScreen(context) ||
                        ResponsiveWidget.issmallscreen(context)
                    ? 40.h
                    : 55.h,
                child: TextFormField(
                  controller: widget.controller,
                  keyboardType: widget.keyboardType,
                  obscureText: widget.isPassword ? _obscure : false,
                  validator: widget.validator,
                  style: TextStyle(color: AppColors.textColor),
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    hintStyle: TextStyle(color: AppColors.hintColor),
                    filled: true,
                    fillColor: widget.backgroundColor ??
                        AppColors.primaryColor.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: widget.icon != null
                        ? Icon(widget.icon, color: AppColors.hintColor)
                        : null,
                    suffixIcon: widget.isPassword
                        ? IconButton(
                            icon: Icon(
                              _obscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.hintColor,
                            ),
                            onPressed: () =>
                                setState(() => _obscure = !_obscure),
                          )
                        : null,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

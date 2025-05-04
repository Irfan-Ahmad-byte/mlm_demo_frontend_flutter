import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/custom_snackbar.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/responsive_widget.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_textstyle.dart';

import '../../core/utils/app_colors.dart';

class AppTextField extends StatefulWidget {
  final String? label;
  final String hint;
  final bool isPassword;
  final Color? backgroundColor;
  final Color? labelColors;
  final TextEditingController? controller;
  final IconData? icon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final VoidCallback? leftButtonOnPressed;
  final IconData? leftButtonIcon;
  final Function(String)? onChanged; // 🆕 Added
  final Function(String)? onSubmitted; // 🆕 Added
  final List<TextInputFormatter>? inputFormatters;
  final bool? isReadOnly;
  final bool showSuffixIcon;

  const AppTextField({
    super.key,
    this.label,
    required this.hint,
    this.controller,
    this.isPassword = false,
    this.icon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.backgroundColor,
    this.leftButtonOnPressed,
    this.leftButtonIcon,
    this.labelColors,
    this.onChanged,
    this.onSubmitted,
    this.inputFormatters,
    this.isReadOnly,
    this.showSuffixIcon = false,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscure = true;
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null && widget.label!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              widget.label!,
              style: TextStyle(
                fontSize: 15,
                color: widget.labelColors ?? AppColors.whiteColor,
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
                        ResponsiveWidget.isSmallScreen(context)
                    ? 35.h
                    : 55.h,
                child: TextFormField(
                  readOnly: widget.isReadOnly ?? false,
                  inputFormatters: widget.inputFormatters,
                  focusNode: _focusNode,
                  controller: widget.controller,
                  keyboardType: widget.keyboardType,
                  obscureText: widget.isPassword ? _obscure : false,
                  validator: widget.validator,
                  onChanged: widget.onChanged, // ✅ New
                  onFieldSubmitted: widget.onSubmitted, // ✅ New
                  style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: AppTextstyle.text10
                          .copyWith(
                            fontSize: FontSizeManager.getFontSize(context, 10),
                          )
                          .fontSize),
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    hintStyle: AppTextstyle.text14.copyWith(
                      fontSize: FontSizeManager.getFontSize(context, 12),
                      color: AppColors.hintColor,
                    ),
                    filled: true,
                    fillColor: widget.backgroundColor ?? AppColors.whiteColor,
                    prefixIcon: widget.icon != null
                        ? Icon(widget.icon, color: AppColors.hintColor)
                        : null,
                    suffixIcon: widget.showSuffixIcon
                        ? (widget.isPassword
                            ? IconButton(
                                icon: Icon(
                                  _obscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColors.hintColor,
                                ),
                                onPressed: () =>
                                    setState(() => _obscure = !_obscure),
                                tooltip: "Show/Hide Password",
                              )
                            : IconButton(
                                icon: Icon(Icons.copy,
                                    color: AppColors.hintColor),
                                tooltip: "Copy to Clipboard",
                                onPressed: () {
                                  if (widget.controller != null &&
                                      widget.controller!.text.isNotEmpty) {
                                    Clipboard.setData(
                                      ClipboardData(
                                          text: widget.controller!.text),
                                    );
                                    CustomSnackBar.show(
                                        message: 'Copied to clipboard');
                                  }
                                },
                              ))
                        : null,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.secondaryColor, // Grey border normally
                        width: 1.9,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors
                            .secondaryDarkColor, // Primary border when focused
                        width: 1.5,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.errorColor, // Error red
                        width: 1.5,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.errorColor,
                        width: 1.5,
                      ),
                    ),
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

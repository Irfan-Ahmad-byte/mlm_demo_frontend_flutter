import 'package:flutter/material.dart';
import '../../core/utils/app_colors.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final String hint;
  final bool isPassword;
  final TextEditingController controller;
  final IconData? icon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.icon,
    this.validator,
    this.keyboardType = TextInputType.text,
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
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPassword ? _obscure : false,
          validator: widget.validator,
          style: TextStyle(color: AppColors.textColor),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(color: AppColors.hintColor),
            filled: true,
            fillColor: AppColors.primaryColor.withOpacity(0.2),
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
                      _obscure ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.hintColor,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final String? text1;
  final TextStyle? style1;
  final String? text2;
  final TextStyle? style2;
  final String? text3;
  final TextStyle? style3;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final int? maxLines;
  final TextOverflow? overflow;

  const CustomRichText({
    super.key,
    this.text1,
    this.style1,
    this.text2,
    this.style2,
    this.text3,
    this.style3,
    this.textAlign = TextAlign.start,
    this.textDirection = TextDirection.ltr,
    this.maxLines,
    this.overflow = TextOverflow.clip,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign ?? TextAlign.left,
      textDirection: textDirection,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: text1,
            style: style1,
          ),
          TextSpan(
            text: text2,
            style: style2,
          ),
          TextSpan(
            text: text3,
            style: style3,
          ),
        ],
      ),
    );
  }
}

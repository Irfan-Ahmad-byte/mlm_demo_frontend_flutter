import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget? smallscreen;
  final Widget? mediumscreen;
  final Widget? largescreen;
  final Widget? customscreen;

  const ResponsiveWidget({
    Key? key,
    this.smallscreen,
    this.mediumscreen,
    this.largescreen,
    this.customscreen,
  }) : super(key: key);

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool isCustomScreen(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 850;
  }

  static bool isMediumScreen(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 850 && width < 1024;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1024;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1024) {
      return largescreen ?? const SizedBox.shrink();
    } else if (width >= 850) {
      return mediumscreen ?? smallscreen ?? const SizedBox.shrink();
    } else if (width >= 600) {
      return customscreen ?? smallscreen ?? const SizedBox.shrink();
    } else {
      return smallscreen ?? const SizedBox.shrink();
    }
  }
}

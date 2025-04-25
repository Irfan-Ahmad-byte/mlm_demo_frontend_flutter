import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget? smallscreen;
  final Widget? mediumscreen;
  final Widget? largescreen;
  final Widget? customscreen;

  const ResponsiveWidget({
    super.key,
    this.smallscreen,
    this.mediumscreen,
    this.largescreen,
    this.customscreen,
  });

  static bool issmallscreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool ismediumscreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 850 &&
        MediaQuery.of(context).size.width < 950;
  }

  static bool isCustomScreen(BuildContext context) {
    return MediaQuery.of(context).size.width <= 850 &&
        MediaQuery.of(context).size.width > 600;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1024;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 1024) {
        return largescreen ?? const SizedBox.shrink();
      } else if (constraints.maxWidth >= 950) {
        return customscreen ??
            mediumscreen ??
            smallscreen ??
            const SizedBox.shrink();
      } else if (constraints.maxWidth >= 600) {
        return mediumscreen ?? smallscreen ?? const SizedBox.shrink();
      } else {
        return smallscreen ?? const SizedBox.shrink();
      }
    });
  }
}

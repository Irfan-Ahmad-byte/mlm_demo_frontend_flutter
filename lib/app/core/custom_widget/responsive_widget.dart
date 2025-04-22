import 'package:flutter/material.dart';
 
class ResponsiveWidget extends StatelessWidget {
  final Widget? smallscreen;
  final Widget? mediumscreen;
  final Widget? largescreen;
  final Widget? customscreen;
  const ResponsiveWidget(
      {super.key,
      this.smallscreen,
      this.mediumscreen,
      this.largescreen,
      this.customscreen});
  static bool issmallscreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool ismediumscreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1024;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 1024;
  }

  // static bool isCustomSize(BuildContext context) {
  //   return MediaQuery.of(context).size.width <= customScreenSize &&
  //       MediaQuery.of(context).size.width >= mediumScreenSize;
  // }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 1024) {
        return largescreen!;
      } else if (constraints.maxWidth < 1024 && constraints.maxWidth >= 600) {
        return mediumscreen!;
      } else {
        return smallscreen!;
      }
    });
  }
}

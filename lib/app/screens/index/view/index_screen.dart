import 'package:flutter/material.dart';
import '../../../core/custom_widget/custom_header.dart';
import '../../../core/utils/app_colors.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Center(
        child: Column(
          children: [
            CustomHeader(),
          ],
        ),
      ),
    );
  }
}

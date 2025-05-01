import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/bonus/view/bonus_page.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/index/controller/index_controller.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/shortener/view/shortener_page.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/dashboard/view/dashboard_page.dart';

import '../../core/custom_widget/custom_header.dart';
import '../network/view/network_page.dart';

class IndexPage extends GetView<IndexController> {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndexController>(
      init: IndexController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Column(
              children: [
                CustomHeader(controller: controller),
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    onPageChanged: (index) => controller.changeIndex(index),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: IndexScreens.values.length,
                    itemBuilder: (context, index) {
                      switch (IndexScreens.values[index]) {
                        case IndexScreens.network:
                          return const NetworkPage();
                        // case IndexScreens.dashboard:
                        //   return DashboardPage();
                        case IndexScreens.bonus:
                          return const BonusPage();
                        case IndexScreens.shortener:
                          return const ShortenerPage();
                        case IndexScreens.dashboard:
                          return const DashboardPage();
                        // // case IndexScreens.weeklyReport:
                        // //   return WeeklyReportPage();

                        // case IndexScreens.profile:
                        //   return ProfilePage();
                        case IndexScreens.logout:
                          // You can show logout dialog here
                          return Container(); // fallback
                        default:
                          return NetworkPage(); // fallback
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

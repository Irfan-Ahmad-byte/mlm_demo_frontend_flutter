import 'package:get/get.dart';

import '../../services/initial_setting_service.dart';

String kAppName = Get.find<InitialSettingServices>().settingmodel.appName!;
const String kInitialSettingJson =
    "assets/initial_setting/initial_setting.json";

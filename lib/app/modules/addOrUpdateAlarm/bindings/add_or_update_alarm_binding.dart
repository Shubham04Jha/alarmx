import 'package:get/get.dart';
import 'package:alarmx/app/modules/bottomNavigationBar/controllers/bottom_navigation_bar_controller.dart';
import 'package:alarmx/app/modules/home/controllers/home_controller.dart';
import 'package:alarmx/app/modules/settings/controllers/settings_controller.dart';
import 'package:alarmx/app/modules/timer/controllers/timer_controller.dart';

import '../controllers/add_or_update_alarm_controller.dart';

class AddOrUpdateAlarmBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AddOrUpdateAlarmController>(
      AddOrUpdateAlarmController(),
    );
    Get.put<HomeController>(
      HomeController(),
    );
    Get.lazyPut<SettingsController>(
      () => SettingsController(),
    );
    Get.put<TimerController>(
      TimerController(),
    );
    Get.lazyPut<BottomNavigationBarController>(
      () => BottomNavigationBarController(),
    );
  }
}

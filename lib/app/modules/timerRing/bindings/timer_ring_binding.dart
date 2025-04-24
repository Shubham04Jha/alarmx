import 'package:get/get.dart';
import 'package:alarmx/app/modules/bottomNavigationBar/controllers/bottom_navigation_bar_controller.dart';
import 'package:alarmx/app/modules/home/controllers/home_controller.dart';
import 'package:alarmx/app/modules/settings/controllers/settings_controller.dart';
import 'package:alarmx/app/modules/timer/controllers/timer_controller.dart';
import 'package:alarmx/app/modules/timerRing/controllers/timer_ring_controller.dart';

class TimerRingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TimerRingController>(
      TimerRingController(),
    );
    Get.put<HomeController>(
      HomeController(),
    );
    Get.put<SettingsController>(
      SettingsController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<TimerController>(
      () => TimerController(),
    );
    Get.lazyPut<BottomNavigationBarController>(
      () => BottomNavigationBarController(),
    );
  }
}

import 'package:get/get.dart';
import 'package:alarmx/app/modules/bottomNavigationBar/controllers/bottom_navigation_bar_controller.dart';
import '../controllers/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SettingsController>(
      SettingsController(),
    );

    Get.lazyPut<BottomNavigationBarController>(
      () => BottomNavigationBarController(),
    );
  }
}

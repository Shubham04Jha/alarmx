import 'package:get/get.dart';
import 'package:alarmx/app/modules/bottomNavigationBar/controllers/bottom_navigation_bar_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeController(),
    );

    
    Get.lazyPut<BottomNavigationBarController>(
      () => BottomNavigationBarController(),
    );
  }
}

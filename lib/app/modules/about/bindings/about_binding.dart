import 'package:get/get.dart';
import 'package:alarmx/app/modules/about/controller/about_controller.dart';

class AboutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutController>(() => AboutController(), fenix: true);
  }
}

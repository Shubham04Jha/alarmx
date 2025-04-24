import 'package:get/get.dart';
import 'package:alarmx/app/modules/timer/controllers/timer_controller.dart';

class TimerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TimerController>(
      TimerController(),
    );


  }
}

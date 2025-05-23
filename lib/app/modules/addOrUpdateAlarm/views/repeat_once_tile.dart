import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alarmx/app/modules/addOrUpdateAlarm/controllers/add_or_update_alarm_controller.dart';
import 'package:alarmx/app/modules/settings/controllers/theme_controller.dart';
import 'package:alarmx/app/utils/constants.dart';
import 'package:alarmx/app/utils/utils.dart';

class RepeatOnceTile extends StatelessWidget {
  const RepeatOnceTile({
    super.key,
    required this.controller,
    required this.themeController,
  });

  final AddOrUpdateAlarmController controller;
  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListTile(

        title: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            'Ring once'.tr,
            style: TextStyle(
              color: themeController.primaryTextColor.value,
            ),
          ),
        ),
        onTap: () {
          Utils.hapticFeedback();
          if (!controller.repeatDays.every((element) => element == false)) {
            controller.isOneTime.value = !controller.isOneTime.value;
          }
        },
        trailing: InkWell(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Obx(
                () {
                  if (controller.repeatDays
                      .every((element) => element == false)) {
                    return Switch.adaptive(
                      value: false,
                      activeColor: ksecondaryColor,
                      onChanged: (value) {
                        Utils.hapticFeedback();
                        controller.isOneTime.value = true;
                      },
                    );
                  }
                  return Switch.adaptive(
                    value: controller.isOneTime.value,
                    activeColor: ksecondaryColor,
                    onChanged: (value) {
                      Utils.hapticFeedback();
                      controller.isOneTime.value = value;
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:alarmx/app/modules/addOrUpdateAlarm/controllers/add_or_update_alarm_controller.dart';
import 'package:alarmx/app/modules/settings/controllers/theme_controller.dart';
import 'package:alarmx/app/utils/constants.dart';
import 'package:alarmx/app/utils/utils.dart';

class PedometerChallenge extends StatelessWidget {
  const PedometerChallenge({
    super.key,
    required this.controller,
    required this.themeController,
  });

  final AddOrUpdateAlarmController controller;
  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    int numberOfSteps;
    bool isPedometerEnabled;
    return Obx(
      () => ListTile(
        title: Row(
          children: [
            Text(
              'Pedometer'.tr,
              style: TextStyle(
                color: themeController.primaryTextColor.value,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.info_sharp,
                size: 21,
                color: themeController.primaryTextColor.value.withOpacity(0.3),
              ),
              onPressed: () {
                Utils.showModal(
                  context: context,
                  title: 'Pedometer'.tr,
                  description: 'pedometerDescription'.tr,
                  iconData: Icons.directions_walk,
                  isLightMode: themeController.currentTheme.value == ThemeMode.light,
                );
              },
            ),
          ],
        ),
        onTap: () {
          Utils.hapticFeedback();
          // storing initial state
          numberOfSteps = controller.numberOfSteps.value;
          isPedometerEnabled = controller.isPedometerEnabled.value;
          Get.defaultDialog(
            onWillPop: () async {
              // presetting values to initial state
              _presetToInitial(numberOfSteps, isPedometerEnabled);
              return true;
            },
            titlePadding: const EdgeInsets.only(top: 20),
            backgroundColor: themeController.secondaryBackgroundColor.value,
            title: 'Number of steps'.tr,
            titleStyle: Theme.of(context).textTheme.displaySmall,
            content: Obx(
              () => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        NumberPicker(
                          value: controller.numberOfSteps.value,
                          minValue: 0,
                          maxValue: 60,
                          onChanged: (value) {
                            Utils.hapticFeedback();
                            if (value > 0) {
                              controller.isPedometerEnabled.value = true;
                            } else {
                              controller.isPedometerEnabled.value = false;
                            }
                            controller.numberOfSteps.value = value;
                          },
                        ),
                        Text(
                          controller.numberOfSteps.value > 1
                              ? 'steps'.tr
                              : 'step'.tr,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Utils.hapticFeedback();
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kprimaryColor,
                              // Set the desired background color
                            ),
                            child: Text(
                              'Done'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    color: themeController.secondaryTextColor.value,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        trailing: InkWell(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Obx(
                () => Text(
                  controller.numberOfSteps.value > 0
                      ? controller.numberOfSteps.value > 1
                          ? '${controller.numberOfSteps.value} ' + 'steps'.tr
                          : '${controller.numberOfSteps.value} ' + 'step'.tr
                      : 'Off'.tr,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: (controller.isPedometerEnabled.value == false)
                            ? themeController.primaryDisabledTextColor.value
                            : themeController.primaryTextColor.value,
                      ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: themeController.primaryDisabledTextColor.value,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _presetToInitial(int numberOfSteps, bool isPedometerEnabled) {
    controller.numberOfSteps.value = numberOfSteps;
    controller.isPedometerEnabled.value = isPedometerEnabled;
  }
}

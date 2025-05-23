import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:alarmx/app/modules/addOrUpdateAlarm/controllers/add_or_update_alarm_controller.dart';
import 'package:alarmx/app/modules/settings/controllers/theme_controller.dart';
import 'package:alarmx/app/utils/constants.dart';
import 'package:alarmx/app/utils/utils.dart';

class AlarmIDTile extends StatelessWidget {
  const AlarmIDTile({
    super.key,
    required this.controller,
    required this.width,
    required this.themeController,
  });

  final AddOrUpdateAlarmController controller;
  final ThemeController themeController;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        child: (controller.isSharedAlarmEnabled.value == true)
            ? Obx(
              () => ListTile(
                  onTap: () {
                    Utils.hapticFeedback();
                    Clipboard.setData(ClipboardData(text: controller.alarmID));
                    Get.snackbar(
                      'Success!'.tr,
                      'Alarm ID has been copied!'.tr,
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green,
                      colorText: themeController.secondaryTextColor.value,
                      maxWidth: width,
                      duration: const Duration(seconds: 2),
                    );
                  },
                  title: FittedBox(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Alarm ID'.tr,
                      style: TextStyle(
                        color: themeController.primaryTextColor.value,
                      ),
                    ),
                  ),
                  trailing: InkWell(
                    child: Icon(
                      Icons.copy,
                      color: themeController.primaryTextColor.value.withOpacity(0.7),
                    ),
                  ),
                ),
            )
            : Obx(
                () => ListTile(
                  onTap: () {
                    Utils.hapticFeedback();
                    Get.defaultDialog(
                      titlePadding: const EdgeInsets.symmetric(vertical: 20),
                      backgroundColor: themeController.secondaryBackgroundColor.value,
                      title: 'Disabled!'.tr,
                      titleStyle: Theme.of(context).textTheme.displaySmall,
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              //'To copy Alarm ID you have enable shared alarm!',
                              'toCopyAlarm'.tr,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  kprimaryColor,
                                ),
                              ),
                              child: Text(
                                'Okay'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                      color: themeController.secondaryTextColor.value,
                                    ),
                              ),
                              onPressed: () {
                                Utils.hapticFeedback();
                                Get.back();
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  title: Text(
                    'Alarm ID'.tr,
                    style: TextStyle(
                      color: themeController.primaryTextColor.value,
                    ),
                  ),
                  trailing: InkWell(
                    child: Icon(
                      Icons.lock,
                      color: themeController.primaryTextColor.value.withOpacity(0.7),
                    ),
                  ),
                ),
            ),
      ),
    );
  }
}

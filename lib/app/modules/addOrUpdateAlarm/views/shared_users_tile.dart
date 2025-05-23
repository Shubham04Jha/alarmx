// ignore_for_file: lines_longer_than_80_chars, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alarmx/app/data/models/user_model.dart';
import 'package:alarmx/app/data/providers/firestore_provider.dart';
import 'package:alarmx/app/modules/addOrUpdateAlarm/controllers/add_or_update_alarm_controller.dart';
import 'package:alarmx/app/modules/settings/controllers/theme_controller.dart';
import 'package:alarmx/app/utils/constants.dart';
import 'package:alarmx/app/utils/utils.dart';

class SharedUsers extends StatelessWidget {
  const SharedUsers({
    super.key,
    required this.controller,
    required this.themeController,
  });

  final AddOrUpdateAlarmController controller;
  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        child: (controller.isSharedAlarmEnabled.value &&
                controller.alarmRecord.value != null)
            ? (controller.alarmRecord.value.ownerId !=
                    controller.userModel.value!.id)
                ? ListTile(
                    title: Text(
                      'Alarm Owner'.tr,
                      style: TextStyle(
                        color: themeController.primaryTextColor.value,
                      ),
                    ),
                    trailing: Text(
                      controller.alarmRecord.value.ownerName,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: themeController.primaryDisabledTextColor.value,
                          ),
                    ),
                  )
                : ListTile(
                    title: Text(
                      'Shared Users'.tr,
                      style: TextStyle(
                        color: themeController.primaryTextColor.value,
                      ),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        Utils.hapticFeedback();
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: themeController.primaryBackgroundColor.value,
                          builder: (BuildContext context) {
                            final userDetails = RxList<UserModel?>([]);

                            return Obx(() {
                              if (controller.sharedUserIds.isEmpty) {
                                return Center(
                                  child: Text('No shared users!'.tr),
                                );
                              }

                              return FutureBuilder<List<UserModel?>>(
                                future:
                                    controller.fetchUserDetailsForSharedUsers(),
                                builder: (
                                  BuildContext context,
                                  AsyncSnapshot<List<UserModel?>> snapshot,
                                ) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator.adaptive(
                                        backgroundColor: kprimaryColor,
                                        valueColor: AlwaysStoppedAnimation(
                                          kprimaryColor,
                                        ),
                                      ),
                                    );
                                  }

                                  userDetails.value = snapshot.data ?? [];

                                  return Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Shared Users'.tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                        ),
                                        for (UserModel? user in userDetails)
                                          Column(
                                            children: [
                                              ListTile(
                                                title: Text(
                                                  user!.fullName,
                                                  style: TextStyle(
                                                    color: themeController.primaryTextColor.value,
                                                  ),
                                                ),
                                                trailing: TextButton(
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(
                                                      EdgeInsets.zero,
                                                    ),
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(
                                                      const Size(
                                                        80,
                                                        30,
                                                      ),
                                                    ),
                                                    maximumSize:
                                                        MaterialStateProperty
                                                            .all(
                                                      const Size(
                                                        80,
                                                        30,
                                                      ),
                                                    ),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.red),
                                                  ),
                                                  child: Text(
                                                    'Remove'.tr,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                          color: themeController.primaryTextColor.value.withOpacity(
                                                                  0.9,
                                                                ),
                                                        ),
                                                  ),
                                                  onPressed: () async {
                                                    Utils.hapticFeedback();
                                                    await FirestoreDb
                                                        .removeUserFromAlarmSharedUsers(
                                                      user,
                                                      controller.alarmID,
                                                    );
                                                    // Update sharedUserIds value after removing the user
                                                    controller.sharedUserIds
                                                        .remove(user.id);

                                                    // Remove the user from userDetails list
                                                    userDetails.remove(user);

                                                    // Update the list
                                                    userDetails.refresh();
                                                  },
                                                ),
                                              ),
                                              Divider(
                                                color: themeController.primaryDisabledTextColor.value,
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            });
                          },
                        );
                      },
                      child: Icon(
                        Icons.chevron_right,
                        color: themeController.primaryTextColor.value.withOpacity(0.7),
                      ),
                    ),
                  )
            : const SizedBox(),
      ),
    );
  }
}

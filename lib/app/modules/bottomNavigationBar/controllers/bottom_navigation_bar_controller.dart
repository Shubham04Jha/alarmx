import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alarmx/app/data/providers/secure_storage_provider.dart';
import 'package:alarmx/app/modules/home/views/home_view.dart';
import 'package:alarmx/app/modules/stopwatch/views/stopwatch_view.dart';
import 'package:alarmx/app/modules/timer/views/timer_view.dart';

class BottomNavigationBarController extends GetxController
    with WidgetsBindingObserver {
  RxInt activeTabIndex = 0.obs;
  RxBool hasloaded = false.obs;

  final _secureStorageProvider = SecureStorageProvider();

  List<Widget> pages = [
    HomeView(),
    StopwatchView(),
    TimerView(),
  ];

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    loadSavedState();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  Future<void> loadSavedState() async {
    int value = await _secureStorageProvider.readTabIndex();
    activeTabIndex.value = value;
    hasloaded.value = true;
  }

  void _saveState() async {
    await _secureStorageProvider.writeTabIndex(
      tabIndex: activeTabIndex.value,
    );
  }

  void changeTab(int index) {
    activeTabIndex.value = index;
    _saveState();

  }
}

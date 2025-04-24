import 'package:get/get.dart';
import 'package:alarmx/app/modules/about/views/about_view.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutController extends GetxController {
  final RxBool isAboutExpanded = true.obs;

  static const String shubhamUrl = 'https://shubham.org/';
  static const String githubUrl =
      'https://github.com/shubham/alarmx';

  Future<bool> launchUrl(Uri uri) async {
    if (await canLaunchUrlString(uri.toString())) {
      return await launchUrlString(uri.toString());
    } else {
      return false;
    }
  }

  void toggleAboutExpansion() {
    isAboutExpanded.value = !isAboutExpanded.value;
  }

  void navigateToAboutView() {
    Get.to(() => AboutView());
  }
}

import 'package:flutter_job_app/utils/loaders/snackbar_loader.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlController extends GetxController {
  static UrlController  get instance => Get.find();

  ///  URL LINK LAUNCHER
  Future<void> launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      TLoaders.errorSnackBar(title:'Could not launch $url');
    }
  }
}

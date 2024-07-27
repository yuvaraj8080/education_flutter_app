import 'package:flutter_job_app/features/personalization/controllers/user_controller.dart';
import 'package:get/get.dart';
import '../../../data/repositories/Banners/live_class_repository.dart';

class LiveClassController extends GetxController {
  static LiveClassController get instance => Get.find();

  final _repository = Get.put(LiveClassRepository());

  RxString currentLink = ''.obs;


  String get latestLink => currentLink.value;

  @override
  void onInit() {
    super.onInit();
    _fetchLatestLink();
  }

  Future<void> _fetchLatestLink() async {
    final batch = UserController.instance.user.value.batch;
    final String link = await _repository.getLatestLink(batch);
    currentLink.value = link;
  }

  // In LiveClassController.dart
  Future<void> refreshLink() async {
    await _fetchLatestLink();
  }
}
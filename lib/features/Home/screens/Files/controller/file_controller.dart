import 'package:get/get.dart';

import '../../../../../data/repositories/file/file_repository.dart';
import '../../../../../utils/loaders/snackbar_loader.dart';
import '../../../../personalization/controllers/user_controller.dart';
import '../models/file_model.dart';

class FileController extends GetxController {
  static FileController get instance => Get.find();

  final RxBool isLoading = false.obs;

  final RxList<FileModel> notesFiles = <FileModel>[].obs;
  final RxList<FileModel> pyqsFiles = <FileModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBatchNotes();
    fetchBatchPYQS();
  }

  /// FETCH FILES BY BATCH
  Future<void> fetchBatchNotes() async {
    try {
      isLoading.value = true;
      final batch = UserController.instance.user.value.batch;
      final fileRepo = FileRepository();
      final files = await fileRepo.FetBatchNotes(batch);
      this.notesFiles.assignAll(files);
    } catch (e) {
      TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  /// FETCH FILES BY BATCH
  Future<void> fetchBatchPYQS() async {
    try {
      /// SHOW LOADER WHILE LOADING FILES
      isLoading.value = true;

      ///----- FETCH FILES BY BATCH------
      final batch = UserController.instance.user.value.batch;
      final fileRepo = FileRepository();
      final files = await fileRepo.FetchBatchPYQS(batch);

      ///---ASSIGN FILES----
      this.pyqsFiles.assignAll(files);
    } catch (e) {
      TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    } finally {
      ///REMOVE LOADER
      isLoading.value = false;
    }
  }

}


import 'package:get/get.dart';

import '../../../data/repositories/Banners/banner_repository.dart';
import '../../../utils/loaders/snackbar_loader.dart';
import '../models/banner_model.dart';

class BannerController extends GetxController{
  ///---VARIABLE-----
  final isLoading = false.obs;
  final carousalCurrentIndex = 0.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;


  @override
  void onInit() {
    fetchBanner();
    super.onInit();
  }

  /// UPDATE PAGE NAVIGATION DOTS
  void  updatePageIndicator(index){
    carousalCurrentIndex.value = index;
  }

  ///FETCH BANNER
  Future<void> fetchBanner() async{
    try {
      /// SHOW LOADER WHILE LOADING CATEGORIES
      isLoading.value = true;

      ///----- FETCH BANNERS------
      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();

      ///---ASSIGN BANNERS----
      this.banners.assignAll(banners);

    }
    catch(e){
      TLoaders.errorSnackBar(title:"Oh Snap",message:e.toString());
    }
    finally{
      ///REMOVE LOADER
      isLoading.value = false;
    }
  }
}
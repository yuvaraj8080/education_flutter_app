import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../features/Home/models/banner_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';


class BannerRepository extends GetxController{
  static BannerRepository get instance => Get.find();

  /// ---- VARIABLES
  final _db = FirebaseFirestore.instance;

  ///  GET ALL ORDER RELATED TO CURRENT USER
  Future<List<BannerModel>> fetchBanners() async{
    try{
      final result = await _db.collection("Banners").where("Active",isEqualTo:true).get();
      return result.docs.map((documentSnapshot) => BannerModel.fromSnapshot(documentSnapshot)).toList();
    }on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong, Please try again";
    }
  }

 ///   UPLOAD BANNER TO THE CLOUD FIREBASE
}
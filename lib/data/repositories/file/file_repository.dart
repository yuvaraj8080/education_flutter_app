import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/Home/screens/Files/models/file_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class FileRepository extends GetxController{
  static FileRepository get instance => Get.find();

  final _firestore = FirebaseFirestore.instance;


  /// GET ALL FILES RELATED TO CURRENT BATCH
  Future<List<FileModel>> FetBatchNotes(String batch) async {
    try {
      final result = await _firestore.collection("Notes").where("Batch", isEqualTo: batch).get();
      return result.docs.map((documentSnapshot) => FileModel.fromSnapshot(documentSnapshot)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong, Please try again";
    }
  }

  /// GET ALL FILES RELATED TO CURRENT BATCH
  Future<List<FileModel>> FetchBatchPYQS(String batch) async {
    try {
      final result = await _firestore.collection("PYQS").where("Batch", isEqualTo: batch).get();
      return result.docs.map((documentSnapshot) => FileModel.fromSnapshot(documentSnapshot)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong, Please try again";
    }
  }

}
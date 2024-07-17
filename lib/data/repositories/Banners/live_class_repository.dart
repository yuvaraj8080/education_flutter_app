import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class LiveClassRepository extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> getLatestLink(String batch) async {
    final QuerySnapshot snapshot = await _firestore
        .collection('LiveClasses')
        .where('batch', isEqualTo: batch)
        // .orderBy('createdAt', descending: true)
        .limit(1)
        .get();
    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.get('link');
    } else {
      return '';
    }
  }
}
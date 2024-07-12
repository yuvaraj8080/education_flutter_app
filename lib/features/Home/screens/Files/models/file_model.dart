import 'package:cloud_firestore/cloud_firestore.dart';

class FileModel {
  final String id;
  String title;
  String batch;
  String subtitle;
  String fileUrl; // URL to the uploaded file

  /// Constructor for FileModel
  FileModel({
    required this.batch,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.fileUrl,
  });

  /// Helper function to get a summary of the file
  String get summary => "$title: $subtitle";

  /// Static function to create an empty FileModel
  static FileModel empty() => FileModel(id: "", title: "", subtitle: "", fileUrl: "", batch: '');

  /// Convert model to JSON structure for storing in Firebase
  Map<String, dynamic> toJson() {
    return {
      "Batch":batch,
      "Title": title,
      "Subtitle": subtitle,
      "FileUrl": fileUrl,
    };
  }

  /// Factory method to create a FileModel from a Firebase document snapshot
  factory FileModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return FileModel(
        id: document.id,
        title: data["Title"] ?? '',
        batch:data["Batch"]??'',
        subtitle: data["Subtitle"] ?? '',
        fileUrl: data["FileUrl"] ?? '',
      );
    } else {
      // Handle the case where data is null gracefully.
      return FileModel.empty(); // Return an empty FileModel
      // Or you can throw an exception if it's appropriate for your use case.
      // throw Exception('Document data is null');
    }
  }
}

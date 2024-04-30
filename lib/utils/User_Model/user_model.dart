import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  //KEEP THOSE VALUES FINAL WHICH TOU DO NOT WENT TO UPDATE
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String location;
  String profilePicture;

  ///  CONSTRUCTOR FOR USERMODEL
UserModel({
  required this.id,
  required this.firstName,
  required this.lastName,
  required this.username,
  required this.email,
  required this.location,
  required this. profilePicture,
});

/// HELPER FUNCTION TO GET THE FULL NAME
  String get fullName => "$firstName $lastName";

  ///HELPER FUNCTION TO FORMAT PHONE NUMBER

  // String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  ///STATIC FUNCTION TO SPLIT FULL NAME INTO FIRST AND LAST NAME
   static List<String> nameParts(fullName)=> fullName.split(" ");

   ///STATIC FUNCTION TO GENERATE A USERNAME FROM THE FULL NAME
   static String generateUsername(fullName){
     List<String> nameParts = fullName.split(" ");
     String firstName = nameParts[0].toLowerCase();
     String lastName  = nameParts.length > 1? nameParts[1].toLowerCase(): "";
     String camelCaseUsername = "$firstName$lastName";
     String usernameWithPrefix = "cwt_$camelCaseUsername";
     return usernameWithPrefix;
   }

   ///STATIC FUNCTION TO CREATE AN EMPTY USER MADEL
   static UserModel empty() => UserModel(id:"", firstName: "", lastName: "", username: "", email: "", location: "", profilePicture: "");

   /// CONVERT MODEL TO JSON STRUCTURE FOR STORING IN FIREBASE.
   Map<String, dynamic> toJson(){
     return {
       "FirstName" : firstName,
       "LastName" : lastName,
       "UserName" : username,
       "Email" : email,
       "Location" : location,
       "ProfilePicture" : profilePicture,
     };
   }

   /// FACTORY MATHOD TO CREATE A USERMODEL FROM A FIREBASE DOCUMENT SNAPSHOT
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return UserModel(
        id: document.id,
        firstName: data["FirstName"] ?? '',
        lastName: data["LastName"] ?? '',
        username: data["UserName"] ?? '',
        email: data["Email"] ?? '',
        location: data["Location"] ?? '',
        profilePicture: data["ProfilePicture"] ?? '',
      );
    } else {
      // Handle the case where data is null gracefully.
      // You can return a default UserModel or throw an error as per your application logic.
      return UserModel.empty(); // Return an empty UserModel
      // Or you can throw an exception if it's appropriate for your use case.
      // throw Exception('Document data is null');
    }
  }

}
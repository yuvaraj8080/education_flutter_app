import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.userId});

  final String userId;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String? name;
  String? email = '';
  String? phoneNumber = '';
  String? imageUrl = '';
  String? joinedAt = '';
  bool isLoading = false;
  bool isSameUser = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}

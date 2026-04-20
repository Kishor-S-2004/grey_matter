import 'package:flutter/material.dart';

class UserdetailsModel {
  final String? Username;
  final String? email;

  UserdetailsModel({
    required this.Username,
    required this.email
});

  factory UserdetailsModel.fromJson(Map<String,dynamic> json){
    return UserdetailsModel(Username: json['Username'] ?? 'Unknown', email: json['Email'] ?? '');
  }

  Map<String,dynamic> toJson() => {
    'Username' : Username,
    'email' : email
  } ;
}
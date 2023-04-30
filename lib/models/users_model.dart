import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UsersModel {
  final String id;
  final String fullName;
  final DateTime birthdayDate;
  final String email;
  final String gender;

  UsersModel({
    required this.id,
    required this.fullName,
    required this.birthdayDate,
    required this.email,
    required this.gender,
  });

  UsersModel copyWith({
    String? id,
    String? fullName,
    DateTime? birthdayDate,
    String? email,
    String? gender,
  }) {
    return UsersModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      birthdayDate: birthdayDate ?? this.birthdayDate,
      email: email ?? this.email,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'fullName': fullName});
    result.addAll({'birthdayDate': birthdayDate.toUtc()});
    result.addAll({'email': email});
    result.addAll({'gender': gender});

    return result;
  }

  String toJson() => json.encode(toMap());

  factory UsersModel.fromJson(String source) => UsersModel.fromMap(json.decode(source));

  factory UsersModel.fromMap(Map<String, dynamic> map) {
    return UsersModel(
      id: map['id'] ?? '',
      fullName: map['fullName'] ?? '',
      birthdayDate: (map['birthdayDate'] as Timestamp).toDate(),
      email: map['email'] ?? '',
      gender: map['gender'] ?? '',
    );
  }
}

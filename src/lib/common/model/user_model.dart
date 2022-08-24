// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

class UserModel {
  UserModel({
    this.id,
    this.email,
    this.displayName,
    this.phoneNumber,
    this.tenantId,
  });

  final String? id;
  final String? email;
  final String? displayName;
  final String? phoneNumber;
  final String? tenantId;

  UserModel copyWith({
    String? id,
    String? email,
    String? displayName,
    String? phoneNumber,
    String? tenantId,
  }) =>
      UserModel(
        id: id ?? this.id,
        email: email ?? this.email,
        displayName: displayName ?? this.displayName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        tenantId: tenantId ?? this.tenantId,
      );

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"],
        displayName: json["display_name"],
        phoneNumber: json["phone_number"],
        tenantId: json["tenant_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "display_name": displayName,
        "phone_number": phoneNumber,
        "tenant_id": tenantId,
      };
}

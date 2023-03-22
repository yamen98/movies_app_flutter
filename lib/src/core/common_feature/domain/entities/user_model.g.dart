// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      username: json['Username'] as String?,
      lastName: json['LastName'] as String?,
      firstName: json['FirstName'] as String?,
      email: json['Email'] as String?,
      id: json['Id'] as int?,
      phoneNumber: json['PhoneNumber'] as String?,
      createdAt: json['CreatedAt'] as String?,
      updatedAt: json['UpdatedAt'] as String?,
      token: json['Token'] as String?,
      emailVerifiedAt: json['EmailVerifiedAt'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'Id': instance.id,
      'Username': instance.username,
      'LastName': instance.lastName,
      'FirstName': instance.firstName,
      'Email': instance.email,
      'EmailVerifiedAt': instance.emailVerifiedAt,
      'PhoneNumber': instance.phoneNumber,
      'CreatedAt': instance.createdAt,
      'UpdatedAt': instance.updatedAt,
      'Token': instance.token,
    };

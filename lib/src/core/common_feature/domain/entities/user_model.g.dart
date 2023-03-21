// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      username: json['username'] as String?,
      lastName: json['last_name'] as String?,
      firstName: json['first_name'] as String?,
      email: json['email'] as String?,
      id: json['id'] as int?,
      phoneNumber: json['phone_number'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      token: json['token'] as String?,
      emailVerifiedAt: json['email_verified_at'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'last_name': instance.lastName,
      'first_name': instance.firstName,
      'email': instance.email,
      'email_verified_at': instance.emailVerifiedAt,
      'phone_number': instance.phoneNumber,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'token': instance.token,
    };

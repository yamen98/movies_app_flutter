import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel {
  final int? id;
  final String? username;
  final String? lastName;
  final String? firstName;
  final String? email;
  final String? emailVerifiedAt;
  final String? phoneNumber;
  final String? createdAt;
  final String? updatedAt;

  String? token;

  UserModel({
    this.username,
    this.lastName,
    this.firstName,
    this.email,
    this.id,
    this.phoneNumber,
    this.createdAt,
    this.updatedAt,
    this.token,
    this.emailVerifiedAt,
  });

  factory UserModel.fromJson(json) => _$UserModelFromJson(json);

  toJson() => _$UserModelToJson(this);

  static List<UserModel> fromJsonList(List json) {
    return json.map((e) => UserModel.fromJson(e)).toList();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}

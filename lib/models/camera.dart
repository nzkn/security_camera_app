import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class CameraModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  String description;
  @HiveField(2)
  String login;
  @HiveField(3)
  String password;
  @HiveField(4)
  String qrValue;

  CameraModel({
    this.name,
    this.description,
    this.login,
    this.password,
    this.qrValue,
  });
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:security_camera_app/models/camera_adapter.dart';
import 'package:security_camera_app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocsDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocsDir.path);
  Hive.registerAdapter(CameraModelAdapter());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}



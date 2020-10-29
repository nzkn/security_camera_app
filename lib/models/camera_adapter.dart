import 'camera.dart';
import 'package:hive/hive.dart';

class CameraModelAdapter extends TypeAdapter<CameraModel> {
  @override
  final int typeId = 1;

  @override
  CameraModel read(BinaryReader reader) {
    var cameraModel = reader.readList();
    return CameraModel(
      name: cameraModel[0] as String,
      description: cameraModel[1] as String,
      login: cameraModel[2] as String,
      password: cameraModel[3] as String,
      qrValue: cameraModel[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CameraModel obj) {
    writer.writeList([obj.name, obj.description, obj.login, obj.password,obj.qrValue]);
  }
}

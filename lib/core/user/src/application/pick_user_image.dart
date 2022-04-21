import 'dart:io' show Platform;

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

@injectable
class PickUserImage {
  final ImagePicker _imagePicker;
  PickUserImage(
    this._imagePicker,
  );

  Future<Option<XFile>> call() async {
    if (await _checkPermissions()) {
      final imageFile =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (imageFile != null) return some(imageFile);
      return none();
    } else {
      return none();
    }
  }

  Future<bool> _checkPermissions() async {
    if (Platform.isIOS) {
      final photosStatus = await Permission.photos.status;
      if (photosStatus.isDenied) {
        final photoStatus = await Permission.photos.request();
        return photoStatus.isGranted;
      } else {
        return true;
      }
    } else {
      if (await Permission.storage.status.isDenied) {
        final storageStatus = await Permission.storage.request();
        return storageStatus.isGranted;
      } else {
        return true;
      }
    }
  }
}

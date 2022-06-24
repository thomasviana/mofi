import 'package:cron/cron.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@module
abstract class PackagesInjectableModule {
  @lazySingleton
  ImagePicker get imagePicker => ImagePicker();
  @lazySingleton
  Cron get cron => Cron();
}

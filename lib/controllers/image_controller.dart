// image_controller.dart

import 'dart:io';
import 'package:get/get.dart';

class ImageController extends GetxController {
  Rx<File?> imageFile = Rx<File?>(null);

  void setImageFile(File? file) {
    imageFile.value = file;
  }

  File? get getImageFile => imageFile.value;

  void clearImageFile() {
    imageFile.value = null;
  }
}

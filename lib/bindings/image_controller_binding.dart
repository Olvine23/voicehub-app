import 'package:get/get.dart';
import 'package:voice_hub/controllers/image_controller.dart';

class ImageControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ImageController());
  }
}
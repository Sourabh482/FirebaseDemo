import 'package:demo_application/src/view/screen_one/controller/screen_one_controller.dart';
import 'package:get/get.dart';

class ScreenOneBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ScreenOneController>(() => ScreenOneController());
  }
}
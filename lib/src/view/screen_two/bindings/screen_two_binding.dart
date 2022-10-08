import 'package:get/get.dart';

import '../controller/screen_two_controller.dart';

class ScreenTwoBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ScreenTwoController>(() => ScreenTwoController());
  }
}
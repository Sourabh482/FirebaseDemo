import 'package:get/get.dart';

import '../controller/screen_three_controller.dart';

class ScreenThreeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ScreenThreeController>(() => ScreenThreeController());
  }
}
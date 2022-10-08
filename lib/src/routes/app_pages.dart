import 'package:get/get.dart';

import '../view/screen_one/bindings/screen_one_binding.dart';
import '../view/screen_one/view/screen_one.dart';
import '../view/screen_three/bindings/screen_three_binding.dart';
import '../view/screen_three/view/screen_three.dart';
import '../view/screen_two/bindings/screen_two_binding.dart';
import '../view/screen_two/view/screen_two.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.scree_one;

  static final routes = [
    GetPage(
      name: Routes.scree_one,
      page: () => ScreenOne(),
      transition: Transition.rightToLeft,
      binding: ScreenOneBinding(),
    ),
    GetPage(
      name: Routes.screen_two,
      page: () => ScreenTwo(),
      binding: ScreenTwoBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.screen_three,
      page: () => ScreenThree(),
      binding: ScreenThreeBinding(),
      transition: Transition.rightToLeft,
    )
  ];
}

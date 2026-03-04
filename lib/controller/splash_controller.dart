import 'package:flutter_extension/helper/route_helper.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  RxBool isLogin = false.obs;

  jumpNextScreen() {
    if (isLogin.value) {
      Get.offNamed(AppRoutes.homeScreen);
    } else {}
  }
}

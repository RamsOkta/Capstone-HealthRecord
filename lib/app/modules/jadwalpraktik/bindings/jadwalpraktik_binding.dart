import 'package:get/get.dart';

import '../controllers/jadwalpraktik_controller.dart';

class JadwalpraktikBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JadwalpraktikController>(
      () => JadwalpraktikController(),
    );
  }
}

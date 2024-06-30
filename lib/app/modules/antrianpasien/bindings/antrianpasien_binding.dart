import 'package:get/get.dart';

import '../controllers/antrianpasien_controller.dart';

class AntrianpasienBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AntrianpasienController>(
      () => AntrianpasienController(),
    );
  }
}

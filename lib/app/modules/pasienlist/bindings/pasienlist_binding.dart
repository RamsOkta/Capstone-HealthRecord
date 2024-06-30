import 'package:get/get.dart';

import '../controllers/pasienlist_controller.dart';

class PasienlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PasienlistController>(
      () => PasienlistController(),
    );
  }
}

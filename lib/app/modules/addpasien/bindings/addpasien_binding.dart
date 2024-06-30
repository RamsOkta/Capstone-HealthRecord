import 'package:get/get.dart';

import '../controllers/addpasien_controller.dart';

class AddpasienBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddpasienController>(
      () => AddpasienController(),
    );
  }
}

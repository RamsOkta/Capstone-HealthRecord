import 'package:get/get.dart';

import '../controllers/editpasien_controller.dart';

class EditpasienBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditpasienController>(
      () => EditpasienController(),
    );
  }
}

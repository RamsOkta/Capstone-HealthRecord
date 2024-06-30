import 'package:get/get.dart';

import '../controllers/detailpasien_controller.dart';

class DetailpasienBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailpasienController>(
      () => DetailpasienController(),
    );
  }
}

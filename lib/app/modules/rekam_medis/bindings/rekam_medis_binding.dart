import 'package:get/get.dart';

import '../controllers/rekam_medis_controller.dart';

class RekamMedisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RekamMedisController>(
      () => RekamMedisController(),
    );
  }
}

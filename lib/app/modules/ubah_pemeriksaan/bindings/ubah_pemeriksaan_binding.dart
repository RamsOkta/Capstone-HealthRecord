import 'package:get/get.dart';

import '../controllers/ubah_pemeriksaan_controller.dart';

class UbahPemeriksaanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UbahPemeriksaanController>(
      () => UbahPemeriksaanController(),
    );
  }
}

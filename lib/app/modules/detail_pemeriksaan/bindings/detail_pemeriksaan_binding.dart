import 'package:get/get.dart';

import '../controllers/detail_pemeriksaan_controller.dart';

class DetailPemeriksaanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPemeriksaanController>(
      () => DetailPemeriksaanController(),
    );
  }
}

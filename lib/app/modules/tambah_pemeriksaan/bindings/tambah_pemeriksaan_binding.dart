import 'package:get/get.dart';

import '../controllers/tambah_pemeriksaan_controller.dart';

class TambahPemeriksaanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahPemeriksaanController>(
      () => TambahPemeriksaanController(),
    );
  }
}

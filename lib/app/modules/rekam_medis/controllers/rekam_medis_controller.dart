import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RekamMedisController extends GetxController {
  var pasien = <Map<String, dynamic>>[].obs;
  var filteredPasien = <Map<String, dynamic>>[].obs;
  var searchTextController = TextEditingController();
  var isLoading = true.obs; // Loading state

  @override
  void onInit() {
    super.onInit();
    listenToPasienChanges();
    searchTextController.addListener(_filterPasienList);
  }

  void listenToPasienChanges() async {
    isLoading.value = true; // Start loading
    try {
      FirebaseFirestore.instance
          .collection('pemeriksaan')
          .orderBy('tanggal_waktu_pemeriksaan', descending: true)
          .snapshots()
          .listen((querySnapshot) {
        var pasienList = querySnapshot.docs.map((doc) {
          return {
            'id': doc.id,
            'id_pemeriksaan': doc[
                'id_pemeriksaan'], // Pastikan ini sesuai dengan field di Firestore
            'nama_pasien': doc['nama_pasien'],
            'tanggal_waktu_pemeriksaan':
                (doc['tanggal_waktu_pemeriksaan'] as Timestamp).toDate(),
            // tambahkan field lainnya sesuai kebutuhan
          };
        }).toList();
        pasien.assignAll(pasienList);
        filteredPasien.assignAll(pasienList);
        isLoading.value = false; // Stop loading
      });
    } catch (e) {
      isLoading.value = false; // Stop loading on error
      Get.snackbar('Error', 'Failed to load data: $e');
    }
  }

  void _filterPasienList() {
    var query = searchTextController.text.toLowerCase();
    if (query.isEmpty) {
      filteredPasien.assignAll(pasien);
    } else {
      filteredPasien.assignAll(pasien.where((item) {
        return item['nama_pasien'].toLowerCase().contains(query) ||
            item['id'].toString().toLowerCase().contains(query);
      }).toList());
    }
  }

  void deletePasien(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('pemeriksaan')
          .doc(id)
          .delete();
      listenToPasienChanges(); // Refresh the list after deletion
      Get.snackbar('Sukses', 'Data Pasien Berhasil Dihapus');
    } catch (e) {
      Get.snackbar('Error', 'Gagal Hapus Data: $e');
    }
  }
}

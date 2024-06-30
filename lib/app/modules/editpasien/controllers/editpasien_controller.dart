import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditpasienController extends GetxController {
  final namaLengkapController = TextEditingController();
  final nikController = TextEditingController();
  final tanggalLahirController = TextEditingController();
  final tempatLahirController = TextEditingController();
  final alamatLengkapController = TextEditingController();
  final nomorTelephoneController = TextEditingController();
  var jenisKelamin = ''.obs;

  var isDataLoaded = false.obs;

  void loadPasienDataIfNeeded(String id) async {
    if (!isDataLoaded.value) {
      var doc =
          await FirebaseFirestore.instance.collection('pasien').doc(id).get();
      if (doc.exists) {
        var data = doc.data()!;
        namaLengkapController.text = data['nama'] ?? '';
        nikController.text = data['nik'] ?? '';

        // Handle Timestamp for tanggal_lahir
        if (data['tanggal_lahir'] is Timestamp) {
          var timestamp = data['tanggal_lahir'] as Timestamp;
          var date = timestamp.toDate();
          tanggalLahirController.text =
              '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString()}';
        } else {
          tanggalLahirController.text = data['tanggal_lahir'] ?? '';
        }

        tempatLahirController.text = data['tempat_lahir'] ?? '';
        alamatLengkapController.text = data['alamat'] ?? '';
        nomorTelephoneController.text = data['telpon'] ?? '';
        jenisKelamin.value = data['jenis_kelamin'] ?? '';
        isDataLoaded.value = true;
      }
    }
  }

  void clearForm() {
    namaLengkapController.clear();
    nikController.clear();
    tanggalLahirController.clear();
    tempatLahirController.clear();
    alamatLengkapController.clear();
    nomorTelephoneController.clear();
    jenisKelamin.value = '';
    isDataLoaded.value = false;
  }

  void updatePasien(String? id) async {
    if (id != null) {
      // Parse tanggal_lahir to DateTime
      var dateParts = tanggalLahirController.text.split('-');
      var day = int.parse(dateParts[0]);
      var month = int.parse(dateParts[1]);
      var year = int.parse(dateParts[2]);
      var dateTime = DateTime(year, month, day);

      // Convert DateTime to Timestamp
      var timestamp = Timestamp.fromDate(dateTime);

      await FirebaseFirestore.instance.collection('pasien').doc(id).update({
        'nama': namaLengkapController.text,
        'nik': nikController.text,
        'tanggal_lahir': timestamp,
        'tempat_lahir': tempatLahirController.text,
        'alamat': alamatLengkapController.text,
        'telpon': nomorTelephoneController.text,
        'jenis_kelamin': jenisKelamin.value,
      });

      Get.snackbar(
        'Sukses',
        'Data pasien berhasil diperbarui',
      );
    } else {
      Get.snackbar(
        'Gagal',
        'Data pasien gagal diperbarui',
      );
    }
  }

  @override
  void dispose() {
    namaLengkapController.dispose();
    nikController.dispose();
    tanggalLahirController.dispose();
    tempatLahirController.dispose();
    alamatLengkapController.dispose();
    nomorTelephoneController.dispose();
    super.dispose();
  }
}

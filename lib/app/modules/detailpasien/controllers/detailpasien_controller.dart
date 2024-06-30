import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Untuk mengubah Timestamp ke format yang sesuai
import 'package:healthrecord/app/routes/app_pages.dart';

class DetailpasienController extends GetxController {
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
          var formattedDate = DateFormat('dd-MM-yyyy').format(date);
          tanggalLahirController.text = formattedDate;
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

  Future<void> tambahAntrian(String pasienId) async {
    try {
      DateTime now = DateTime.now();
      String today = "${now.year}-${now.month}-${now.day}";

      var result = await FirebaseFirestore.instance
          .collection('antrian')
          .where('timestamp',
              isGreaterThanOrEqualTo: DateTime(now.year, now.month, now.day))
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      int noAntrian = 1;
      if (result.docs.isNotEmpty) {
        noAntrian = result.docs.first.data()['no_antrian'] + 1;
      }

      await FirebaseFirestore.instance.collection('antrian').add({
        'no_antrian': noAntrian,
        'pasien_id': pasienId,
        'status': 'Belum Dilayani',
        'timestamp': FieldValue.serverTimestamp(),
      });

      Get.snackbar(
        'Sukses',
        'Antrian berhasil ditambahkan',
      );

      Get.toNamed(Routes.ANTRIANPASIEN);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menambahkan antrian: $e',
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

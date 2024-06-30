import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthrecord/app/routes/app_pages.dart';

class AddpasienController extends GetxController {
  final namaLengkapController = TextEditingController();
  final nikController = TextEditingController();
  final tanggalLahirController = TextEditingController();
  final tempatLahirController = TextEditingController();
  final alamatLengkapController = TextEditingController();
  final nomorTelephoneController = TextEditingController();
  var jenisKelamin = ''.obs;

  void clearForm() {
    namaLengkapController.clear();
    nikController.clear();
    tanggalLahirController.clear();
    tempatLahirController.clear();
    alamatLengkapController.clear();
    nomorTelephoneController.clear();
    jenisKelamin.value = '';
  }

  Future<bool> checkNIKExists(String nik) async {
    var result = await FirebaseFirestore.instance
        .collection('pasien')
        .where('nik', isEqualTo: nik)
        .get();
    return result.docs.isNotEmpty;
  }

  Future<String> generatePasienId() async {
    var snapshot = await FirebaseFirestore.instance.collection('pasien').get();
    int totalPasien = snapshot.docs.length + 1;
    String formattedId = 'PSN-${totalPasien.toString().padLeft(6, '0')}';
    return formattedId;
  }

  Future<void> savePasien() async {
    String nik = nikController.text;

    if (namaLengkapController.text.isEmpty ||
        nik.isEmpty ||
        tanggalLahirController.text.isEmpty ||
        tempatLahirController.text.isEmpty ||
        alamatLengkapController.text.isEmpty ||
        nomorTelephoneController.text.isEmpty ||
        jenisKelamin.value.isEmpty) {
      Get.snackbar('Error', 'Semua data harus diisi');
      return;
    }

    if (!RegExp(r'^\d+$').hasMatch(nik)) {
      Get.snackbar('Error', 'NIK harus berupa angka');
      return;
    }

    bool nikExists = await checkNIKExists(nik);

    if (nikExists) {
      Get.snackbar('Error', 'NIK sudah terdaftar');
      return;
    }

    // Generate pasien_id
    String pasienId = await generatePasienId();

    // Convert tanggal_lahir to Timestamp
    var dateParts = tanggalLahirController.text.split('-');
    var day = int.parse(dateParts[0]);
    var month = int.parse(dateParts[1]);
    var year = int.parse(dateParts[2]);
    var timestamp = Timestamp.fromDate(DateTime(year, month, day));

    await FirebaseFirestore.instance.collection('pasien').doc(pasienId).set({
      'pasien_id': pasienId,
      'nama': namaLengkapController.text,
      'nik': nik,
      'tanggal_lahir': timestamp,
      'tempat_lahir': tempatLahirController.text,
      'alamat': alamatLengkapController.text,
      'telpon': nomorTelephoneController.text,
      'jenis_kelamin': jenisKelamin.value,
    });

    clearForm();
    Get.snackbar('Success', 'Data pasien berhasil ditambahkan');

    Get.offNamed(Routes.PASIENLIST);
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      // Format picked date to dd-MM-yyyy
      String formattedDate =
          "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year.toString()}";
      tanggalLahirController.text = formattedDate;
    }
  }
}

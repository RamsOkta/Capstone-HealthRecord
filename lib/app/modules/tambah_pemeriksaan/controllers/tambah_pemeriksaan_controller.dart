import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TambahPemeriksaanController extends GetxController {
  // Form field controllers
  final namaPasienController = TextEditingController();
  final nikController = TextEditingController();
  final tanggalLahirController = Rx<DateTime?>(null);
  final jenisKelaminController = RxString('');
  final tanggalWaktuPemeriksaanController = Rx<DateTime?>(null);
  final kunjunganTypeController = RxString('');
  final keluhanUtamaController = TextEditingController();
  final riwayatPenyakitController = TextEditingController();
  final riwayatpenyakitsebelumnyaController = TextEditingController();
  final riwayatAlergiController = TextEditingController();
  final riwayatObatController = TextEditingController();
  final tekananDarahController = TextEditingController();
  final denyutNadiController = TextEditingController();
  final suhuTubuhController = TextEditingController();
  final pernafasanController = TextEditingController();
  final tinggiBadanController = TextEditingController();
  final beratBadanController = TextEditingController();

  var isDataLoaded = false.obs;
  final selectedPasien = RxString('');
  final selectedPasienData = Rx<Map<String, dynamic>>({});

  // Daftar nama pasien dari Firestore
  final pasienList = <String>[].obs;

  // Counter untuk ID pemeriksaan
  int nextId = 1;

  @override
  void onInit() {
    super.onInit();
    // Load daftar nama pasien dari Firestore saat controller diinisialisasi
    loadPasienList();
    // Ambil nilai terakhir dari Firestore untuk nextId
    getNextIdFromFirestore();
  }

  // Mendapatkan ID pemeriksaan berikutnya dari Firestore
  void getNextIdFromFirestore() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('counters')
          .doc('pemeriksaan')
          .get();
      if (snapshot.exists) {
        nextId = snapshot.data()?['nextId'] ?? 1;
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat ID pemeriksaan: $e');
    }
  }

  // Memuat daftar nama pasien dari Firestore
  void loadPasienList() {
    FirebaseFirestore.instance.collection('pasien').snapshots().listen(
      (snapshot) {
        try {
          if (snapshot.docs.isNotEmpty) {
            pasienList.clear();
            for (final doc in snapshot.docs) {
              pasienList.add(doc['nama'] ?? '');
            }
          }
        } catch (e) {
          Get.snackbar('Error', 'Gagal memuat daftar pasien: $e');
        }
      },
    );
  }

  // Memuat data pasien terpilih dari Firestore berdasarkan nama
  void loadPasienData(String namaPasien) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('pasien')
          .where('nama', isEqualTo: namaPasien)
          .limit(1)
          .get();
      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        selectedPasienData.value = data;
        // Mengisi field dengan data dari Firestore
        nikController.text = data['nik'] ?? '';
        if (data['tanggal_lahir'] != null) {
          // Pastikan untuk menggunakan Timestamp dari Firestore
          Timestamp timestamp = data['tanggal_lahir'];
          tanggalLahirController.value = timestamp.toDate();
        } else {
          tanggalLahirController.value = null;
        }
        jenisKelaminController.value = data['jenis_kelamin'] ?? '';
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat data pasien: $e');
    }
  }

  // Fungsi untuk validasi field
  bool validateFields() {
    if (nikController.text.isEmpty ||
        tanggalLahirController.value == null ||
        jenisKelaminController.value.isEmpty ||
        tanggalWaktuPemeriksaanController.value == null ||
        kunjunganTypeController.value.isEmpty ||
        keluhanUtamaController.text.isEmpty ||
        riwayatPenyakitController.text.isEmpty ||
        riwayatpenyakitsebelumnyaController.text.isEmpty ||
        riwayatAlergiController.text.isEmpty ||
        riwayatObatController.text.isEmpty ||
        tekananDarahController.text.isEmpty ||
        denyutNadiController.text.isEmpty ||
        suhuTubuhController.text.isEmpty ||
        pernafasanController.text.isEmpty ||
        tinggiBadanController.text.isEmpty ||
        beratBadanController.text.isEmpty) {
      Get.snackbar('Error', 'Semua field harus diisi');
      return false;
    }

    // if (!RegExp(r"^\d{16}$").hasMatch(nikController.text)) {
    //   Get.snackbar('Error', 'NIK harus berisi 16 angka');
    //   return false;
    // }

    if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(namaPasienController.text)) {
      Get.snackbar('Error', 'Nama pasien hanya boleh berisi huruf');
      return false;
    }

    if (!RegExp(r"^\d{1,3}/\d{1,3}$").hasMatch(tekananDarahController.text)) {
      Get.snackbar(
          'Error', 'Tekanan darah harus berformat angka/angka (misal 120/80)');
      return false;
    }

    if (!RegExp(r"^\d+$").hasMatch(denyutNadiController.text)) {
      Get.snackbar('Error', 'Denyut nadi hanya boleh berisi angka');
      return false;
    }

    int denyutNadi = int.tryParse(denyutNadiController.text) ?? -1;
    if (denyutNadi < 0 || denyutNadi > 1000) {
      Get.snackbar('Error', 'Denyut nadi maksimal 1000 kali');
      return false;
    }

    if (!RegExp(r"^\d+(\.\d+)?$").hasMatch(suhuTubuhController.text)) {
      Get.snackbar('Error',
          'Suhu tubuh hanya boleh berisi angka dan boleh menggunakan desimal');
      return false;
    }

    double suhuTubuh = double.tryParse(suhuTubuhController.text) ?? -1;
    if (suhuTubuh < 0 || suhuTubuh > 100) {
      Get.snackbar('Error', 'Suhu tubuh maksimal 100 celcius');
      return false;
    }

    if (!RegExp(r"^\d+$").hasMatch(pernafasanController.text)) {
      Get.snackbar('Error', 'Pernafasan hanya boleh berisi angka');
      return false;
    }

    int pernafasan = int.tryParse(pernafasanController.text) ?? -1;
    if (pernafasan < 0 || pernafasan > 1000) {
      Get.snackbar('Error', 'Pernafasan maksimal 1000 kali');
      return false;
    }

    if (!RegExp(r"^\d+(\.\d+)?$").hasMatch(tinggiBadanController.text)) {
      Get.snackbar('Error',
          'Tinggi badan hanya boleh berisi angka dan boleh menggunakan desimal');
      return false;
    }

    double tinggiBadan = double.tryParse(tinggiBadanController.text) ?? -1;
    if (tinggiBadan < 0 || tinggiBadan > 500) {
      Get.snackbar('Error', 'Tinggi badan maksimal 500 cm');
      return false;
    }

    if (!RegExp(r"^\d+(\.\d+)?$").hasMatch(beratBadanController.text)) {
      Get.snackbar('Error',
          'Berat badan hanya boleh berisi angka dan boleh menggunakan desimal');
      return false;
    }

    double beratBadan = double.tryParse(beratBadanController.text) ?? -1;
    if (beratBadan < 0 || beratBadan > 1000) {
      Get.snackbar('Error', 'Berat badan maksimal 1000 kg');
      return false;
    }

    return true;
  }

  // Menyimpan data ke Firestore
  void saveData(String? antrianId) async {
    if (!validateFields()) {
      return;
    }

    CollectionReference pemeriksaan =
        FirebaseFirestore.instance.collection('pemeriksaan');

    // Format ID pemeriksaan
    String formattedId =
        'RM-${(nextId).toString().padLeft(6, '0')}'; // RM-000001

    try {
      var result = await pemeriksaan.add({
        'id_pemeriksaan':
            formattedId, // Simpan ID pemeriksaan dengan format baru
        'nama_pasien': namaPasienController.text,
        'nik': nikController.text,
        'tanggal_lahir': Timestamp.fromDate(tanggalLahirController.value!),
        'jenis_kelamin': jenisKelaminController.value,
        'tanggal_waktu_pemeriksaan':
            Timestamp.fromDate(tanggalWaktuPemeriksaanController.value!),
        'kunjungan_type': kunjunganTypeController.value,
        'keluhan_utama': keluhanUtamaController.text,
        'riwayat_penyakit': riwayatPenyakitController.text,
        'riwayat_penyakit_sebelumnya': riwayatpenyakitsebelumnyaController.text,
        'riwayat_alergi': riwayatAlergiController.text,
        'riwayat_obat': riwayatObatController.text,
        'tekanan_darah': tekananDarahController.text,
        'denyut_nadi': denyutNadiController.text,
        'suhu_tubuh': suhuTubuhController.text,
        'pernafasan': pernafasanController.text,
        'tinggi_badan': tinggiBadanController.text,
        'berat_badan': beratBadanController.text,
      });

      // Increment nextId for the next entry
      nextId++;

      // Update nextId in Firestore
      await FirebaseFirestore.instance
          .collection('counters')
          .doc('pemeriksaan')
          .update({'nextId': nextId});

      Get.snackbar('Sukses', 'Data berhasil disimpan');

      if (antrianId != null) {
        updateAntrianStatus(antrianId);
      } else {
        Get.offNamed('/rekam_medis');
      }
    } catch (error) {
      Get.snackbar('Error', 'Gagal menyimpan data: $error');
    }
  }

  void updateAntrianStatus(String antrianId) async {
    try {
      await FirebaseFirestore.instance
          .collection('antrian')
          .doc(antrianId)
          .update({
        'status': 'Sudah Dilayani',
      });
      Get.offNamed('/rekam_medis');
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengupdate status antrian: $e');
    }
  }

  void loadPasienDataIfNeeded(String id) async {
    if (!isDataLoaded.value) {
      var doc =
          await FirebaseFirestore.instance.collection('pasien').doc(id).get();
      if (doc.exists) {
        var data = doc.data()!;
        namaPasienController.text = data['nama'] ?? '';
        nikController.text = data['nik'] ?? '';
        if (data['tanggal_lahir'] != null) {
          // Pastikan untuk menggunakan Timestamp dari Firestore
          Timestamp timestamp = data['tanggal_lahir'];
          tanggalLahirController.value = timestamp.toDate();
        }
        jenisKelaminController.value = data['jenis_kelamin'] ?? '';
        isDataLoaded.value = true;
      }
    }
  }

  void batal() {
    namaPasienController.clear();
    nikController.clear();
    tanggalLahirController.value = null;
    jenisKelaminController.value = '';
    tanggalWaktuPemeriksaanController.value = null;
    kunjunganTypeController.value = '';
    keluhanUtamaController.clear();
    riwayatPenyakitController.clear();
    riwayatpenyakitsebelumnyaController.clear();
    riwayatAlergiController.clear();
    riwayatObatController.clear();
    tekananDarahController.clear();
    denyutNadiController.clear();
    suhuTubuhController.clear();
    pernafasanController.clear();
    tinggiBadanController.clear();
    beratBadanController.clear();
  }

  // Mengosongkan field
  void clearFields() {
    namaPasienController.clear();
    nikController.clear();
    tanggalLahirController.value = null;
    jenisKelaminController.value = '';
    tanggalWaktuPemeriksaanController.value = null;
    kunjunganTypeController.value = '';
    keluhanUtamaController.clear();
    riwayatPenyakitController.clear();
    riwayatpenyakitsebelumnyaController.clear();
    riwayatAlergiController.clear();
    riwayatObatController.clear();
    tekananDarahController.clear();
    denyutNadiController.clear();
    suhuTubuhController.clear();
    pernafasanController.clear();
    tinggiBadanController.clear();
    beratBadanController.clear();
  }
}

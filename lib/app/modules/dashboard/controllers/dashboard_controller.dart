import 'package:flutter/material.dart'; // Tambahkan import ini untuk menunjukkan dialog
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthrecord/app/modules/antrianpasien/controllers/antrianpasien_controller.dart';

class DashboardController extends GetxController {
  DateTime? currentBackPressTime;
  final String exitWarning = "Tekan lagi untuk keluar";
  var sudahTerdaftarCount = '0 Pasien'.obs;
  var belumDilayaniCount = '0 Pasien'.obs;
  var sudahDilayaniCount = '0 Pasien'.obs;
  var name = ''.obs;
  var profileImageUrl = ''.obs; // Menambahkan variabel profileImageUrl
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPatientStatus();
    fetchProfileData();
    updateCounts();
    fetchSudahTerdaftarCount(); // Panggil fungsi fetchSudahTerdaftarCount di sini
  }

  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: exitWarning); // Menampilkan pesan dengan Fluttertoast
      return Future.value(false);
    }
    return Future.value(true);
  }

  void fetchProfileData() async {
    try {
      isLoading(true);
      DocumentReference docRef = FirebaseFirestore.instance
          .collection('profile')
          .doc('38NjyRltFiX0ezjiFMUe'); // ganti dengan user ID yang sesuai

      // Menggunakan snapshots agar data bisa otomatis berubah
      docRef.snapshots().listen((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          name.value = snapshot['nama'];
          profileImageUrl.value = snapshot['profileImageUrl'];
        } else {
          print('Document does not exist');
          // Tambahkan logika atau handling untuk kasus ketika dokumen tidak ada
        }
      });
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  void fetchPatientStatus() async {
    var jakartaTime = DateTime.now().toUtc().add(const Duration(hours: 7));
    var startOfDay =
        DateTime(jakartaTime.year, jakartaTime.month, jakartaTime.day, 0, 0, 0);
    var endOfDay = DateTime(
        jakartaTime.year, jakartaTime.month, jakartaTime.day, 23, 59, 59);

    try {
      var antrianCollection = FirebaseFirestore.instance.collection('antrian');

      var belumDilayaniQuery = await antrianCollection
          .where('status', isEqualTo: 'Belum Dilayani')
          .where('timestamp', isGreaterThanOrEqualTo: startOfDay)
          .where('timestamp', isLessThanOrEqualTo: endOfDay)
          .orderBy('timestamp')
          .get();
      belumDilayaniCount.value = '${belumDilayaniQuery.size} Pasien';

      var sudahDilayaniQuery = await antrianCollection
          .where('status', isEqualTo: 'Sudah Dilayani')
          .where('timestamp', isGreaterThanOrEqualTo: startOfDay)
          .where('timestamp', isLessThanOrEqualTo: endOfDay)
          .orderBy('timestamp')
          .get();
      sudahDilayaniCount.value = '${sudahDilayaniQuery.size} Pasien';

      var pasienTerdaftarHariIni = <String>{};
      var antrianQuery = await antrianCollection
          .where('timestamp', isGreaterThanOrEqualTo: startOfDay)
          .where('timestamp', isLessThanOrEqualTo: endOfDay)
          .get();

      antrianQuery.docs.forEach((antrianDoc) {
        var pasienId = antrianDoc['pasien_id'];
        if (pasienId != null) {
          pasienTerdaftarHariIni.add(pasienId);
        }
      });

      sudahTerdaftarCount.value = '${pasienTerdaftarHariIni.length} Pasien';
    } catch (e) {
      print('Error fetching patient status: $e');
    }
  }

  void updateCounts() {
    final AntrianpasienController antrianpasienController =
        Get.find<AntrianpasienController>();

    ever(antrianpasienController.antrianList, (antrianList) {
      int belumDilayani = 0;
      int sudahDilayani = 0;

      for (var antrian in antrianList) {
        var status = antrian['status'];
        if (status == 'Belum Dilayani') {
          belumDilayani++;
        } else if (status == 'Sudah Dilayani') {
          sudahDilayani++;
        }
      }

      belumDilayaniCount.value = '$belumDilayani Pasien';
      sudahDilayaniCount.value = '$sudahDilayani Pasien';
    });
  }

  void fetchSudahTerdaftarCount() {
    try {
      var pasienCollection = FirebaseFirestore.instance.collection('pasien');

      pasienCollection.snapshots().listen((querySnapshot) {
        sudahTerdaftarCount.value = '${querySnapshot.size} Pasien';
      });
    } catch (e) {
      print('Error fetching sudah terdaftar count: $e');
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed('/masuk'); // Mengarahkan ke halaman login setelah logout
  }

  void confirmLogout(BuildContext context) {
    Get.defaultDialog(
      title: "Konfirmasi Logout",
      middleText: "Apakah Anda yakin ingin logout?",
      textCancel: "Tidak",
      textConfirm: "Ya",
      confirmTextColor: Colors.white,
      onConfirm: () {
        logout();
      },
    );
  }
}

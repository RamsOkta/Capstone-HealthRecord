import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PasienlistController extends GetxController {
  var pasienList = <Map<String, dynamic>>[].obs;
  var filteredPasienList = <Map<String, dynamic>>[].obs;
  var searchTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchPasienList();
    searchTextController.addListener(_searchPasien);
  }

  void fetchPasienList() {
    FirebaseFirestore.instance
        .collection('pasien')
        .snapshots()
        .listen((snapshot) {
      pasienList.value =
          snapshot.docs.map((doc) => doc.data()..['id'] = doc.id).toList();
      // Update filteredPasienList after pasienList is updated
      _searchPasien();
    });
  }

  void _searchPasien() {
    String query = searchTextController.text.toLowerCase();
    filteredPasienList.value = pasienList.where((pasien) {
      return pasien['nama'].toString().toLowerCase().contains(query) ||
          pasien['alamat'].toString().toLowerCase().contains(query) ||
          pasien['telpon'].toString().toLowerCase().contains(query) ||
          pasien['tanggal_lahir'].toString().toLowerCase().contains(query) ||
          pasien['jenis_kelamin'].toString().toLowerCase().contains(query) ||
          pasien['nik'].toString().toLowerCase().contains(query);
    }).toList();
  }

  void deletePasien(String id) async {
    await FirebaseFirestore.instance.collection('pasien').doc(id).delete();
  }

  void openWhatsApp(String telpon) async {
    String url = "https://wa.me/$telpon";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void onClose() {
    // Clean up controllers
    searchTextController.dispose();
    super.onClose();
  }
}

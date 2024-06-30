import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AntrianpasienController extends GetxController {
  var antrianList = <Map<String, dynamic>>[].obs;
  var originalAntrianList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAntrianHariIni();
  }

  void fetchAntrianHariIni() {
    var jakartaTime = DateTime.now().toUtc().add(const Duration(hours: 7));
    var startOfDay =
        DateTime(jakartaTime.year, jakartaTime.month, jakartaTime.day, 0, 0, 0);
    var endOfDay = DateTime(
        jakartaTime.year, jakartaTime.month, jakartaTime.day, 23, 59, 59);

    FirebaseFirestore.instance
        .collection('antrian')
        .where('timestamp', isGreaterThanOrEqualTo: startOfDay)
        .where('timestamp', isLessThanOrEqualTo: endOfDay)
        .orderBy('timestamp')
        .snapshots()
        .listen((querySnapshot) async {
      if (querySnapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> antrianData = [];

        for (var doc in querySnapshot.docs) {
          var antrian = doc.data();
          antrian['id'] = doc.id;
          var pasienId = antrian['pasien_id'];

          if (pasienId != null) {
            var pasienSnapshot = await FirebaseFirestore.instance
                .collection('pasien')
                .doc(pasienId)
                .get();

            if (pasienSnapshot.exists) {
              var pasienData = pasienSnapshot.data();

              if (pasienData != null) {
                antrian['nama_pasien'] = pasienData['nama'];
                antrian['alamat_pasien'] = pasienData['alamat'];
                antrian['telepon_pasien'] = pasienData['telepon'];
                antrian['nik_pasien'] = pasienData['nik'];
                antrian['jenis_kelamin_pasien'] = pasienData['jenis_kelamin'];
                antrianData.add(antrian);
              } else {
                print('Data pasien null untuk antrian dengan ID: $pasienId');
              }
            } else {
              print('Pasien dengan ID: $pasienId tidak ditemukan');
            }
          } else {
            print('Pasien ID null untuk antrian dengan data: $antrian');
          }
        }

        antrianList.assignAll(antrianData);
        originalAntrianList.assignAll(antrianData);
      } else {
        print('Tidak ada antrian ditemukan untuk hari ini');
        antrianList.clear();
        originalAntrianList.clear();
      }
    });
  }

  void searchPasien(String searchText) async {
    searchText = searchText.toLowerCase();

    var pasienQuery = FirebaseFirestore.instance.collection('pasien');

    var querySnapshot = await pasienQuery.get();

    if (querySnapshot.docs.isEmpty) {
      // Jika tidak ada data pasien, kosongkan antrianList
      antrianList.clear();
      return;
    }

    List<Map<String, dynamic>> antrianData = [];

    for (var doc in querySnapshot.docs) {
      var pasienData = doc.data();
      var pasienId = doc.id;

      if (pasienData != null) {
        var antrianSnapshot = await FirebaseFirestore.instance
            .collection('antrian')
            .where('pasien_id', isEqualTo: pasienId)
            .get();

        for (var antrianDoc in antrianSnapshot.docs) {
          var antrian = antrianDoc.data();
          antrian['id'] = antrianDoc.id;
          antrian['nama_pasien'] = pasienData['nama'];
          antrian['alamat_pasien'] = pasienData['alamat'];
          antrian['telepon_pasien'] = pasienData['telepon'];
          antrian['nik_pasien'] = pasienData['nik'];
          antrian['jenis_kelamin_pasien'] = pasienData['jenis_kelamin'];

          if (_containsSearchQuery(antrian, searchText)) {
            antrianData.add(antrian);
          }
        }
      }
    }

    antrianList.assignAll(antrianData);
  }

  bool _containsSearchQuery(Map<String, dynamic> data, String query) {
    return data['nama_pasien'].toString().toLowerCase().contains(query) ||
        data['alamat_pasien'].toString().toLowerCase().contains(query) ||
        data['telepon_pasien'].toString().toLowerCase().contains(query) ||
        data['tanggal_lahir_pasien'].toString().toLowerCase().contains(query) ||
        data['jenis_kelamin_pasien'].toString().toLowerCase().contains(query) ||
        data['nik_pasien'].toString().toLowerCase().contains(query);
  }

  void clearSearch() {
    antrianList.assignAll(originalAntrianList);
  }

  void updateAntrianStatus(String antrianId, String status) async {
    try {
      if (antrianId != null) {
        await FirebaseFirestore.instance
            .collection('antrian')
            .doc(antrianId)
            .update({
          'status': status,
        });
      } else {
        print('Error: antrianId is null or invalid');
      }
    } catch (e) {
      print('Error updating antrian status: $e');
    }
  }

  void showStatusDialog(String antrianId, String status) {
    if (antrianId != null && antrianId.isNotEmpty) {
      String dropdownValue = status ?? 'Belum dilayani';
      Get.defaultDialog(
        title: "Ubah Status Antrian",
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 200,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: dropdownValue,
                    dropdownColor: const Color.fromARGB(255, 1, 203, 239),
                    items: <String>['Belum Dilayani', 'Sudah Dilayani']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Update status when Validasi button is pressed
                          updateAntrianStatus(antrianId, dropdownValue);
                          Get.back();
                        },
                        child: const Text(
                          'Validasi',
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 1, 203, 239),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          'Batal',
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 1, 203, 239),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    } else {
      print('Error: Invalid antrianId');
    }
  }
}

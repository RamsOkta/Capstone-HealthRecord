import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthrecord/app/routes/app_pages.dart';
import '../controllers/antrianpasien_controller.dart';

class AntrianpasienView extends StatelessWidget {
  final AntrianpasienController controller = Get.put(AntrianpasienController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF01CBEF),
        title: const Text(
          'Antrian Pasien',
          style: TextStyle(
            fontFamily: 'Poppins-Medium',
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  const Icon(Icons.search),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          controller.searchPasien(value);
                        } else {
                          controller.clearSearch();
                        }
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Cari Pasien",
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.antrianList.isEmpty) {
                  return const Center(
                      child: Text("Tidak ada antrian hari ini"));
                } else {
                  return ListView.builder(
                    itemCount: controller.antrianList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var antrian = controller.antrianList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(Routes.TAMBAH_PEMERIKSAAN,
                                arguments: {
                                  'pasienId': antrian['pasien_id'],
                                  'antrianId': antrian['id'],
                                });
                          },
                          child: MyCard(
                            name: antrian['pasien_id'],
                            id: antrian['id'],
                            title:
                                antrian['nama_pasien'] ?? 'Nama tidak tersedia',
                            nomor: antrian['no_antrian'].toString(),
                            status: antrian['status'].toString(),
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final AntrianpasienController controller = Get.put(AntrianpasienController());

  final String name;
  final String title;
  final String nomor;
  final String status;
  final String id;

  MyCard({
    required this.name,
    required this.title,
    required this.nomor,
    required this.status,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    bool belumDilayani = status == 'Belum Dilayani';

    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: belumDilayani
            ? const Color(0xFF01CBEF) // Warna transparan jika Belum Dilayani
            : const Color.fromARGB(
                255, 223, 73, 73), // Warna utama jika sudah dilayani
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 1, color: const Color(0xFFEFEFEF)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: () {
                controller.showStatusDialog(id, status);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                height: 26,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: const Color(0xFFF6F1F1)),
                ),
                child: Center(
                  child: Text(
                    "No Antrian : $nomor",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

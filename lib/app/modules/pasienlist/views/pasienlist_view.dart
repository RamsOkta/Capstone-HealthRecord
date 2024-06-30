import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:healthrecord/app/routes/app_pages.dart';
import '../controllers/pasienlist_controller.dart';

class PasienlistView extends GetView<PasienlistController> {
  const PasienlistView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF01CBEF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pushNamed(context, '/dashboard'),
        ),
        title: const Text(
          'Data Pasien',
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
                      controller: controller.searchTextController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Cari Pasien",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.filteredPasienList.isEmpty) {
                  return const Center(child: Text("Tidak ada data"));
                }
                return ListView.builder(
                  itemCount: controller.filteredPasienList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var pasien = controller.filteredPasienList[index];
                    return Slidable(
                      key: ValueKey(pasien['id']),
                      endActionPane: ActionPane(
                        extentRatio: 0.25,
                        motion: const ScrollMotion(),
                        children: [
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    Get.toNamed(Routes.EDITPASIEN,
                                        arguments: {'pasienId': pasien['id']});
                                  },
                                  icon: Icons.edit_outlined,
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    Get.dialog(
                                      AlertDialog(
                                        title: const Text('Konfirmasi'),
                                        content: const Text(
                                            'Apakah Anda yakin ingin menghapus data pasien ini?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              controller
                                                  .deletePasien(pasien['id']);
                                              Get.back();
                                            },
                                            child: const Text('Ya'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: Icons.delete_outline,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(Routes.DETAILPASIEN,
                                arguments: {'pasienId': pasien['id']});
                          },
                          child: MyCard(
                            title: pasien['id'],
                            name: pasien['nama'],
                            phoneNumber: pasien['telpon'],
                            controller: controller,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Get.toNamed(Routes.ADDPASIEN);
          if (result == true) {
            controller.fetchPasienList();
          }
        },
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        child: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Colors.blue,
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final String name;
  final String title;
  final String phoneNumber;
  final PasienlistController controller;

  const MyCard({
    super.key,
    required this.name,
    required this.title,
    required this.phoneNumber,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: ShapeDecoration(
        color: const Color.fromARGB(255, 1, 203, 239),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFEFEFEF)),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  name,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: () {
                controller.openWhatsApp(phoneNumber);
              },
              child: Container(
                width: 78,
                height: 26,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFF6F1F1)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Chat',
                    textAlign: TextAlign.center,
                    style: TextStyle(
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/jadwalpraktik_controller.dart';

class JadwalPraktikView extends GetView<JadwalpraktikController> {
  const JadwalPraktikView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF01CBEF),
        title: const Text(
          'Jadwal Praktik',
          style: TextStyle(
            fontFamily: 'Poppins-Medium',
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(
              () => Container(
                margin: const EdgeInsets.fromLTRB(1, 0, 0, 29),
                decoration: BoxDecoration(
                  color: const Color(0xFFC4C4C4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 13, 0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF807D7D),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: controller.profileImageUrl.value.isNotEmpty
                            ? Image.network(
                                controller.profileImageUrl.value,
                                width: 104,
                                height: 113,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: 104,
                                height: 113,
                                color: Colors.grey,
                                child: const Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 18, 0, 47),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            controller.name.value,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xFF000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Jadwal Praktik',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.jadwalPraktik.length,
                  itemBuilder: (context, hariIndex) {
                    var jadwal = controller.jadwalPraktik[hariIndex];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF01CBEF),
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: jadwal.waktuPraktik
                                .asMap()
                                .entries
                                .map((entry) {
                              var waktuIndex = entry.key;
                              var waktu = entry.value;
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${jadwal.hari} - ${waktu.jamPraktik}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () async {
                                        var newJamPraktik =
                                            await showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            var controller =
                                                TextEditingController(
                                                    text: waktu.jamPraktik);
                                            return AlertDialog(
                                              title: const Text(
                                                  'Edit Jam Praktik'),
                                              content: TextField(
                                                controller: controller,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Jam Praktik',
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(null);
                                                  },
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(controller.text);
                                                  },
                                                  child: const Text('Save'),
                                                ),
                                              ],
                                            );
                                          },
                                        );

                                        if (newJamPraktik != null) {
                                          controller.updateJamPraktik(hariIndex,
                                              waktuIndex, newJamPraktik);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/tambah_pemeriksaan_controller.dart';

class TambahPemeriksaanView extends GetView<TambahPemeriksaanController> {
  const TambahPemeriksaanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;

    final String? pasienId = Get.arguments['pasienId'];
    final String? antrianId = Get.arguments['antrianId'];

    if (pasienId == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error: Pasien ID is null'),
        ),
      );
    }

    controller.loadPasienDataIfNeeded(pasienId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF01CBEF),
        title: const Text(
          'Tambah Pemeriksaan',
          style: TextStyle(
            fontFamily: 'Poppins-Medium',
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text(
                      'Informasi Pasien',
                      style: TextStyle(
                        fontFamily: 'Poppins-Medium',
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: screenWidth,
                  height: 320,
                  decoration: const BoxDecoration(
                    color: Color(0xFF01CBEF),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: controller.namaPasienController,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'poppins',
                          ),
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            labelText: 'Nama Pasien',
                            labelStyle: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 16,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            floatingLabelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: controller.nikController,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'poppins',
                          ),
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            labelText: 'NIK',
                            labelStyle: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 16,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors
                                      .black), // Black border when focused
                            ),
                            floatingLabelStyle: TextStyle(
                              color:
                                  Colors.black, // Black label text when focused
                            ),
                          ),
                        ),
                        Obx(() => TextFormField(
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100),
                                );
                                if (pickedDate != null) {
                                  controller.tanggalLahirController.value =
                                      pickedDate;
                                }
                              },
                              controller: TextEditingController(
                                text: controller.tanggalLahirController.value !=
                                        null
                                    ? DateFormat('dd-MM-yyyy').format(controller
                                        .tanggalLahirController.value!)
                                    : '',
                              ),
                              decoration: const InputDecoration(
                                labelText: 'Tanggal Lahir',
                                labelStyle: TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 16,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                floatingLabelStyle:
                                    TextStyle(color: Colors.black),
                              ),
                            )),
                        const SizedBox(height: 20),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Jenis Kelamin:',
                              style: TextStyle(
                                fontFamily: 'Poppins-Medium',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Obx(() => Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Row(
                                    children: [
                                      Radio<String>(
                                        value: 'Laki-laki',
                                        groupValue: controller
                                            .jenisKelaminController.value,
                                        onChanged: (value) {
                                          controller.jenisKelaminController
                                              .value = value!;
                                        },
                                        fillColor:
                                            const MaterialStatePropertyAll(
                                                Colors.black),
                                      ),
                                      const Text('Laki-laki'),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: Row(
                                    children: [
                                      Radio<String>(
                                        value: 'Perempuan',
                                        groupValue: controller
                                            .jenisKelaminController.value,
                                        onChanged: (value) {
                                          controller.jenisKelaminController
                                              .value = value!;
                                        },
                                        fillColor:
                                            const MaterialStatePropertyAll(
                                                Colors.black),
                                      ),
                                      const Text('Perempuan'),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Text(
                      'Detail Pemeriksaan',
                      style: TextStyle(
                        fontFamily: 'Poppins-Medium',
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: screenWidth,
                  height: 320,
                  decoration: const BoxDecoration(
                    color: Color(0xFF01CBEF),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        Obx(() => TextFormField(
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDateTime = await showDatePicker(
                                  context: context,
                                  initialDate: controller
                                          .tanggalWaktuPemeriksaanController
                                          .value ??
                                      DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100),
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return Theme(
                                      data: ThemeData.light(),
                                      child: child!,
                                    );
                                  },
                                );

                                if (pickedDateTime != null) {
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    context: Get.context!,
                                    initialTime: TimeOfDay.now(),
                                  );

                                  if (pickedTime != null) {
                                    DateTime selectedDateTime = DateTime(
                                      pickedDateTime.year,
                                      pickedDateTime.month,
                                      pickedDateTime.day,
                                      pickedTime.hour,
                                      pickedTime.minute,
                                    );

                                    // Update Rxn<DateTime> value
                                    controller.tanggalWaktuPemeriksaanController
                                        .value = selectedDateTime;
                                  }
                                }
                              },
                              controller: TextEditingController(
                                text: controller
                                            .tanggalWaktuPemeriksaanController
                                            .value !=
                                        null
                                    ? DateFormat('dd-MM-yyyy HH:mm').format(
                                        controller
                                            .tanggalWaktuPemeriksaanController
                                            .value!)
                                    : '',
                              ),
                              decoration: const InputDecoration(
                                labelText: 'Tanggal dan Waktu Pemeriksaan',
                                labelStyle: TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 16,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                floatingLabelStyle:
                                    TextStyle(color: Colors.black),
                              ),
                            )),
                        const SizedBox(height: 25),
                        Obx(() => Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Row(
                                    children: [
                                      Radio<String>(
                                        value: 'Kunjungan Sehat',
                                        groupValue: controller
                                            .kunjunganTypeController.value,
                                        onChanged: (value) {
                                          controller.kunjunganTypeController
                                              .value = value!;
                                        },
                                        fillColor:
                                            const MaterialStatePropertyAll(
                                                Colors.black),
                                        visualDensity: VisualDensity.compact,
                                      ),
                                      Expanded(
                                        // Add this
                                        child: const Text(
                                          'Kunjungan Sehat',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: Row(
                                    children: [
                                      Radio<String>(
                                        value: 'Kunjungan Sakit',
                                        groupValue: controller
                                            .kunjunganTypeController.value,
                                        onChanged: (value) {
                                          controller.kunjunganTypeController
                                              .value = value!;
                                        },
                                        fillColor:
                                            const MaterialStatePropertyAll(
                                                Colors.black),
                                        visualDensity: VisualDensity.compact,
                                      ),
                                      Expanded(
                                        // Add this
                                        child: const Text(
                                          'Kunjungan Sakit',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        const Divider(
                          color: Colors.black,
                          thickness: 0.5,
                        ),
                        TextFormField(
                          controller: controller.keluhanUtamaController,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'poppins',
                          ),
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            labelText: 'Keluhan Utama',
                            labelStyle: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 16,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors
                                      .black), // Black border when focused
                            ),
                            floatingLabelStyle: TextStyle(
                              color:
                                  Colors.black, // Black label text when focused
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: controller.riwayatPenyakitController,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'poppins',
                          ),
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            labelText: 'Riwayat Penyakit/Keluhan saat ini',
                            labelStyle: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 16,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors
                                      .black), // Black border when focused
                            ),
                            floatingLabelStyle: TextStyle(
                              color:
                                  Colors.black, // Black label text when focused
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Text(
                      'Riwayat Medis',
                      style: TextStyle(
                        fontFamily: 'Poppins-Medium',
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: screenWidth,
                  height: 270,
                  decoration: const BoxDecoration(
                    color: Color(0xFF01CBEF),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        TextFormField(
                          controller:
                              controller.riwayatpenyakitsebelumnyaController,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'poppins',
                          ),
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            labelText: 'Riwayat Penyakit Sebelumnya',
                            labelStyle: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 16,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors
                                      .black), // Black border when focused
                            ),
                            floatingLabelStyle: TextStyle(
                              color:
                                  Colors.black, // Black label text when focused
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: controller.riwayatAlergiController,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'poppins',
                          ),
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            labelText: 'Riwayat Alergi',
                            labelStyle: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 16,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors
                                      .black), // Black border when focused
                            ),
                            floatingLabelStyle: TextStyle(
                              color:
                                  Colors.black, // Black label text when focused
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: controller.riwayatObatController,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'poppins',
                          ),
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            labelText:
                                'Riwayat Obat - obatan yang sedang di konsumsi',
                            labelStyle: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 16,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors
                                      .black), // Black border when focused
                            ),
                            floatingLabelStyle: TextStyle(
                              color:
                                  Colors.black, // Black label text when focused
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Text(
                      'Pemeriksaan Fisik',
                      style: TextStyle(
                        fontFamily: 'Poppins-Medium',
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: screenWidth,
                  height: 270,
                  decoration: const BoxDecoration(
                    color: Color(0xFF01CBEF),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.tekananDarahController,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'poppins',
                                ),
                                cursorColor: Colors.black,
                                decoration: const InputDecoration(
                                  labelText: 'Tekanan Darah Siastole/Diastole',
                                  labelStyle: TextStyle(
                                    fontFamily: 'poppins',
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .black), // Black border when focused
                                  ),
                                  floatingLabelStyle: TextStyle(
                                    color: Colors
                                        .black, // Black label text when focused
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: controller.denyutNadiController,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'poppins',
                                ),
                                cursorColor: Colors.black,
                                decoration: const InputDecoration(
                                  labelText: 'Denyut Nadi',
                                  labelStyle: TextStyle(
                                    fontFamily: 'poppins',
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .black), // Black border when focused
                                  ),
                                  floatingLabelStyle: TextStyle(
                                    color: Colors
                                        .black, // Black label text when focused
                                  ),
                                  suffix: Text('kali/menit'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.suhuTubuhController,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'poppins',
                                ),
                                cursorColor: Colors.black,
                                decoration: const InputDecoration(
                                  labelText: 'Suhu Tubuh',
                                  labelStyle: TextStyle(
                                    fontFamily: 'poppins',
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .black), // Black border when focused
                                  ),
                                  floatingLabelStyle: TextStyle(
                                    color: Colors
                                        .black, // Black label text when focused
                                  ),
                                  suffix: Text('c'),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: controller.pernafasanController,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'poppins',
                                ),
                                cursorColor: Colors.black,
                                decoration: const InputDecoration(
                                  labelText: 'Pernafasan',
                                  labelStyle: TextStyle(
                                    fontFamily: 'poppins',
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .black), // Black border when focused
                                  ),
                                  floatingLabelStyle: TextStyle(
                                    color: Colors
                                        .black, // Black label text when focused
                                  ),
                                  suffix: Text('kali/menit'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.tinggiBadanController,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'poppins',
                                ),
                                cursorColor: Colors.black,
                                decoration: const InputDecoration(
                                  labelText: 'Tinggi Badan',
                                  labelStyle: TextStyle(
                                    fontFamily: 'poppins',
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .black), // Black border when focused
                                  ),
                                  floatingLabelStyle: TextStyle(
                                    color: Colors
                                        .black, // Black label text when focused
                                  ),
                                  suffix: Text('cm'),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: controller.beratBadanController,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'poppins',
                                ),
                                cursorColor: Colors.black,
                                decoration: const InputDecoration(
                                  labelText: 'Berat Badan',
                                  labelStyle: TextStyle(
                                    fontFamily: 'poppins',
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .black), // Black border when focused
                                  ),
                                  floatingLabelStyle: TextStyle(
                                    color: Colors
                                        .black, // Black label text when focused
                                  ),
                                  suffix: Text('kg'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xFF01CBEF)),
                      ),
                      onPressed: () {
                        controller.saveData(antrianId);
                      },
                      child: const Text(
                        'Simpan',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xFF01CBEF)),
                      ),
                      onPressed: () {
                        controller.batal();
                      },
                      child: const Text(
                        'Batal',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

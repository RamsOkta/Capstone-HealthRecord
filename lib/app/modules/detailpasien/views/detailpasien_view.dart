import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detailpasien_controller.dart';

class DetailpasienView extends GetView<DetailpasienController> {
  const DetailpasienView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DetailpasienController controller = Get.put(DetailpasienController());

    final String? pasienId = Get.arguments?['pasienId'];

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
          'Detail Pasien',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Informasi Identitas Pasien',
                style: TextStyle(
                  fontFamily: 'Poppins-Medium',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0xFF01CBEF),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      TextField(
                        controller: controller.namaLengkapController,
                        decoration: const InputDecoration(
                          labelText: 'Nama Lengkap Pasien',
                          labelStyle: TextStyle(color: Colors.black),
                          enabled: false,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF01CBEF)),
                          ),
                        ),
                        style: const TextStyle(color: Colors.black),
                        enabled: false,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: controller.nikController,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF01CBEF)),
                          ),
                          labelText: 'NIK',
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        style: const TextStyle(color: Colors.black),
                        enabled: false,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: controller.tanggalLahirController,
                        readOnly: true,
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null) {
                            controller.tanggalLahirController.text =
                                "${picked.day}-${picked.month}-${picked.year}";
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'Tanggal Lahir',
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF01CBEF)),
                          ),
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: controller.tempatLahirController,
                        decoration: const InputDecoration(
                          labelText: 'Tempat Lahir',
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF01CBEF)),
                          ),
                        ),
                        style: const TextStyle(color: Colors.black),
                        enabled: false,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Jenis Kelamin',
                        style: TextStyle(
                          fontFamily: 'Poppins-Medium',
                          fontSize: 16,
                        ),
                      ),
                      Obx(
                        () => Row(
                          children: [
                            Expanded(
                              child: RadioListTile(
                                title: const Text(
                                  'Laki - Laki',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                                value: 'Laki-laki',
                                groupValue: controller.jenisKelamin.value,
                                onChanged: null,
                                activeColor: Colors.blue,
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                title: const Text(
                                  'Perempuan',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                                value: 'Perempuan',
                                activeColor: Colors.blue,
                                groupValue: controller.jenisKelamin.value,
                                onChanged: null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Informasi Kontak',
                style: TextStyle(
                  fontFamily: 'Poppins-Medium',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0xFF01CBEF),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: controller.alamatLengkapController,
                        decoration: const InputDecoration(
                          labelText: 'Alamat Lengkap Pasien',
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        style: const TextStyle(color: Colors.black),
                        enabled: false,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: controller.nomorTelephoneController,
                        decoration: const InputDecoration(
                          labelText: 'Nomor Telephone',
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        style: const TextStyle(color: Colors.black),
                        enabled: false,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  controller.tambahAntrian(pasienId);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 47,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF01CBEF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: const Center(
                    child: Text(
                      'Tambah Antrian Pasien',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

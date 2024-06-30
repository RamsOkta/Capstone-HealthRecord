import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/addpasien_controller.dart';

class AddpasienView extends GetView<AddpasienController> {
  const AddpasienView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddpasienController controller = Get.put(AddpasienController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF01CBEF),
        title: const Text(
          'Tambah Pasien',
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
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF01CBEF)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: controller.nikController,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF01CBEF)),
                          ),
                          labelText: 'NIK',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: controller.tanggalLahirController,
                        readOnly: true,
                        onTap: () => controller.selectDate(context),
                        decoration: const InputDecoration(
                          labelText: 'Tanggal Lahir',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF01CBEF)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: controller.tempatLahirController,
                        decoration: const InputDecoration(
                          labelText: 'Tempat Lahir',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF01CBEF)),
                          ),
                        ),
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
                                  'Laki-laki',
                                  style: TextStyle(fontSize: 12),
                                ),
                                value: 'Laki-laki',
                                groupValue: controller.jenisKelamin.value,
                                onChanged: (value) {
                                  controller.jenisKelamin.value =
                                      value.toString();
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                title: const Text(
                                  'Perempuan',
                                  style: TextStyle(fontSize: 12),
                                ),
                                value: 'Perempuan',
                                groupValue: controller.jenisKelamin.value,
                                onChanged: (value) {
                                  controller.jenisKelamin.value =
                                      value.toString();
                                },
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
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: controller.nomorTelephoneController,
                        decoration: const InputDecoration(
                          labelText: 'Nomor Telephone',
                        ),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF01CBEF),
                    ),
                    onPressed: () {
                      controller.savePasien();
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF01CBEF),
                    ),
                    onPressed: () {
                      controller.clearForm();
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
    );
  }
}

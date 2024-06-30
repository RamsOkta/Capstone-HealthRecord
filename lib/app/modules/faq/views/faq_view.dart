import 'package:flutter/material.dart';

class FaqView extends StatelessWidget {
  const FaqView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FAQ',
          style: TextStyle(
            fontFamily: 'Poppins-Medium',
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF01CBEF),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFFFFFFFF),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              faqItem(
                'Cara Menambahkan Pasien',
                '1. Buka fitur pasien. \n2. Klik tombol tambah. \n3. Isi field. \n4. Lalu klik simpan',
              ),
              faqItem(
                'Prosedur Pendaftaran Pasien',
                '1. Klik list salah satu pasien. \n2. Maka terbuka halaman detail pasien. \n3. klik tombol Tambah antrian pasien. \n4. Pasien berada dalam antrian.',
              ),
              faqItem(
                'Pencatatan Riwayat Medis',
                '1. Buka fitur rekam medis. \n2. Klik tombol tambah. \n3. Isi field. \n4. Lalu klik simpan',
              ),
              faqItem(
                'Prosedur Antrian Baru',
                '1. Klik list salah satu pasien. \n2. Maka terbuka halaman detail pasien. \n3. klik tombol Tambah antrian pasien. \n4. Pasien berada dalam antrian.',
              ),
              faqItem(
                'Prosedur Hapus dan Ubah',
                '1. Geser list di halaman rekam medis atau pasien. \n2. Akan muncul ikon ubah berbentuk pensil dan hapus berbentuk tempat sampah. \n3. Ketika klik ikon ubah maka akan kehalaman ubah dan silahkan ubah data sesuai keperluan lalu klik simpan. \n4. Jika klik ikon hapus maka akan muncul menu untuk yakin menghapus data atau tidak.',
              ),
              faqItem(
                'Prosedur Validasi Status',
                '1. Klik fitur antrian pasien. \n2. Klik salah satu list pasien yang ingin validasi. \n3. Pilih sudah dilayani dalam menu. \n4. Klik tombol validasi. \n5. Validasi selesai',
              ),
              faqItem(
                'Tentang Aplikasi',
                'Aplikasi ini merupakan aplikasi pendataan klinik, berbasis mobile android yang menerapkan sistem pendataan yang efektif dan efisien',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget faqItem(String title, String content) {
    List<InlineSpan> textSpans = [];

    // Split content by newline character \n
    List<String> paragraphs = content.split('\n');

    // Create TextSpan for each paragraph
    for (String paragraph in paragraphs) {
      textSpans.add(
        TextSpan(
          text: paragraph,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: Color(0xFF000000),
          ),
        ),
      );
      // Add a new line widget after each paragraph except the last one
      if (paragraphs.last != paragraph) {
        textSpans.add(const TextSpan(text: '\n'));
      }
    }

    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Color(0xFF000000),
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListView(shrinkWrap: true, children: [
            RichText(
              text: TextSpan(children: textSpans),
            ),
          ]),
        ),
      ],
    );
  }
}

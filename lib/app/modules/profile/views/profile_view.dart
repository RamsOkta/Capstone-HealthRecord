import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 28),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _profileHeader(context),
                      _infoAkunSection(),
                      _buttonUbahProfil(),
                    ],
                  ),
                  Positioned(
                    right: 64,
                    top: 234,
                    child: _buttonKembaliKeMenu(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _profileHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 38),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerRight,
      child: Container(
        width: MediaQuery.of(context).size.width * 1,
        decoration: BoxDecoration(
          color: const Color(0xFF01CBEF),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 55, 0, 62),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Obx(() {
                  if (controller.profileImageUrl.value.isNotEmpty) {
                    return CircleAvatar(
                        backgroundImage: NetworkImage(
                          controller.profileImageUrl.value,
                        ),
                        radius: 50 // Adjust the radius here for larger avatar
                        );
                  } else {
                    return const CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/images/vector.png',
                      ),
                      radius: 50, // Adjust the radius here for larger avatar
                    );
                  }
                }),
              ),
              Text(
                controller.name.value,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoAkunSection() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 11),
          child: const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Info Akun',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Color(0xFF000000),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 38),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF01CBEF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 26, 0, 22),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoAkunItem('Nama', controller.name.value),
                  _infoAkunItem('Email', controller.email.value),
                  _infoAkunItem('Nomor Telepon', controller.phoneNumber.value),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoAkunItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color(0xFF000000),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 13),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color(0xFF000000),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buttonUbahProfil() {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/ubahprofile');
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(0.1, 0, 0, 0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF01CBEF),
              borderRadius: BorderRadius.circular(20),
            ),
            width: 126.1,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: const Text(
              'Ubah Profil',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonKembaliKeMenu() {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        width: 241,
        height: 41,
        decoration: BoxDecoration(
          color: const Color(0xFFC4C4C4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
          child: Text(
            'Kembali ke menu',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

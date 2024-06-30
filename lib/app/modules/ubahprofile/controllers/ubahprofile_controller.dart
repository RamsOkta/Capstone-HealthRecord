import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UbahprofileController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  RxString profileImageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Load initial profile data from Firestore
    loadProfileData();
  }

  void loadProfileData() async {
    DocumentSnapshot profileData = await _firestore
        .collection('profile')
        .doc('38NjyRltFiX0ezjiFMUe')
        .get();
    if (profileData.exists) {
      nameController.text = profileData['nama'];
      phoneController.text = profileData['no_hp'];
      profileImageUrl.value = profileData['profileImageUrl'];
    }
  }

  Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      String downloadUrl = await uploadImageToFirebase(pickedImage);
      profileImageUrl.value = downloadUrl;
    }
  }

  Future<String> uploadImageToFirebase(XFile image) async {
    String fileName =
        'profile_image/${DateTime.now().millisecondsSinceEpoch}.png';
    Reference reference = _storage.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(File(image.path));
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  void saveProfile() async {
    await _firestore.collection('profile').doc('38NjyRltFiX0ezjiFMUe').set({
      'nama': nameController.text,
      'no_hp': phoneController.text,
      'profileImageUrl': profileImageUrl.value,
    }, SetOptions(merge: true));
    Get.back();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var phoneNumber = ''.obs;
  var profileImageUrl = ''.obs; // Menambahkan variabel profileImageUrl
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
  }

  void fetchProfileData() {
    try {
      isLoading(true);

      FirebaseFirestore.instance
          .collection('profile')
          .doc('38NjyRltFiX0ezjiFMUe') // ganti dengan user ID yang sesuai
          .snapshots()
          .listen((DocumentSnapshot userProfile) {
        name.value = userProfile['nama'];
        email.value = userProfile['email'];
        phoneNumber.value = userProfile['no_hp'];
        profileImageUrl.value = userProfile['profileImageUrl'];
        isLoading(false);
      });
    } catch (e) {
      print(e);
      isLoading(false);
    }
  }
}

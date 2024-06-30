import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  DateTime? currentBackPressTime;
  final String exitWarning = "Tekan lagi untuk keluar";

  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: exitWarning);
      return Future.value(false);
    }
    return Future.value(true);
  }
}

import 'package:get/get.dart';
import 'package:healthrecord/app/modules/tambah_pemeriksaan/views/tambah_pemeriksaannew.dart';

import '../modules/addpasien/bindings/addpasien_binding.dart';
import '../modules/addpasien/views/addpasien_view.dart';
import '../modules/antrianpasien/bindings/antrianpasien_binding.dart';
import '../modules/antrianpasien/views/antrianpasien_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/detail_pemeriksaan/bindings/detail_pemeriksaan_binding.dart';
import '../modules/detail_pemeriksaan/views/detail_pemeriksaan_view.dart';
import '../modules/detailpasien/bindings/detailpasien_binding.dart';
import '../modules/detailpasien/views/detailpasien_view.dart';
import '../modules/editpasien/bindings/editpasien_binding.dart';
import '../modules/editpasien/views/editpasien_view.dart';
import '../modules/faq/bindings/faq_binding.dart';
import '../modules/faq/views/faq_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/jadwalpraktik/bindings/jadwalpraktik_binding.dart';
import '../modules/jadwalpraktik/views/jadwalpraktik_view.dart';
import '../modules/lupapassword/bindings/lupapassword_binding.dart';
import '../modules/lupapassword/views/lupapassword_view.dart';
import '../modules/masuk/bindings/masuk_binding.dart';
import '../modules/masuk/views/masuk_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/pasienlist/bindings/pasienlist_binding.dart';
import '../modules/pasienlist/views/pasienlist_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/rekam_medis/bindings/rekam_medis_binding.dart';
import '../modules/rekam_medis/views/rekam_medis_view.dart';
import '../modules/splashscreen/bindings/splashscreen_binding.dart';
import '../modules/splashscreen/views/splashscreen_view.dart';
import '../modules/tambah_pemeriksaan/bindings/tambah_pemeriksaan_binding.dart';
import '../modules/tambah_pemeriksaan/views/tambah_pemeriksaan_view.dart';
import '../modules/ubah_pemeriksaan/bindings/ubah_pemeriksaan_binding.dart';
import '../modules/ubah_pemeriksaan/views/ubah_pemeriksaan_view.dart';
import '../modules/ubahprofile/bindings/ubahprofile_binding.dart';
import '../modules/ubahprofile/views/ubahprofile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHSCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MASUK,
      page: () => const MasukView(),
      binding: MasukBinding(),
    ),
    GetPage(
      name: _Paths.SPLASHSCREEN,
      page: () => const SplashscreenView(),
      binding: SplashscreenBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.FAQ,
      page: () => FaqView(),
      binding: FaqBinding(),
    ),
    GetPage(
      name: _Paths.JADWALPRAKTIK,
      page: () => const JadwalPraktikView(),
      binding: JadwalpraktikBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.UBAHPROFILE,
      page: () => const UbahprofileView(),
      binding: UbahprofileBinding(),
    ),
    GetPage(
      name: _Paths.LUPAPASSWORD,
      page: () => const LupapasswordView(),
      binding: LupapasswordBinding(),
    ),
    GetPage(
      name: _Paths.ADDPASIEN,
      page: () => const AddpasienView(),
      binding: AddpasienBinding(),
    ),
    GetPage(
      name: _Paths.PASIENLIST,
      page: () => const PasienlistView(),
      binding: PasienlistBinding(),
    ),
    GetPage(
      name: _Paths.EDITPASIEN,
      page: () => const EditPasienView(),
      binding: EditpasienBinding(),
    ),
    GetPage(
      name: _Paths.DETAILPASIEN,
      page: () => DetailpasienView(),
      binding: DetailpasienBinding(),
    ),
    GetPage(
      name: _Paths.ANTRIANPASIEN,
      page: () => AntrianpasienView(),
      binding: AntrianpasienBinding(),
    ),
    GetPage(
      name: _Paths.REKAM_MEDIS,
      page: () => const RekamMedisView(),
      binding: RekamMedisBinding(),
    ),
    GetPage(
      name: _Paths.UBAH_PEMERIKSAAN,
      page: () => const UbahPemeriksaanView(),
      binding: UbahPemeriksaanBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PEMERIKSAAN,
      page: () => const DetailPemeriksaanView(),
      binding: DetailPemeriksaanBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_PEMERIKSAAN,
      page: () => const TambahPemeriksaanView(),
      binding: TambahPemeriksaanBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_PEMERIKSAANNEW,
      page: () => const TambahPemeriksaanNEWView(),
      binding: TambahPemeriksaanBinding(),
    ),
  ];
}

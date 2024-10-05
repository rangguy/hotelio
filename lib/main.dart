import 'package:course_hotelio/config/app_color.dart';
import 'package:course_hotelio/config/app_route.dart';
import 'package:course_hotelio/config/session.dart';
import 'package:course_hotelio/firebase_options.dart';
import 'package:course_hotelio/page/home_page.dart';
import 'package:course_hotelio/page/intro_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // menginisialisasi date format yang akan digunakan pada aplikasi
  initializeDateFormatting('en_US');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          scaffoldBackgroundColor: AppColor.backgroundScaffold,
          primaryColor: AppColor.primary,
          colorScheme: const ColorScheme.light(
              primary: AppColor.primary, secondary: AppColor.secondary)),
      routes: {
        '/': (context) {
          return FutureBuilder(
              future: Session.getUser(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.id == null) {
                  return IntroPage();
                } else {
                  return HomePage();
                }
              });
        },
        AppRoute.intro: (context) => const IntroPage(),
        AppRoute.home: (context) => const HomePage(),
        AppRoute.signin: (context) => const IntroPage(),
        AppRoute.detail: (context) => const IntroPage(),
        AppRoute.checkout: (context) => const IntroPage(),
        AppRoute.checkoutSuccess: (context) => const IntroPage(),
        AppRoute.detailBooking: (context) => const IntroPage(),
      },
    );
  }
}

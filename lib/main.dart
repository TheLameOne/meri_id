import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meri_id/presentation/KYC/AadharPage.dart';
import 'package:meri_id/presentation/KYC/PanPage.dart';
import 'package:meri_id/presentation/KYC/VideoPage.dart';
import 'package:meri_id/presentation/SplashPage.dart';
import 'package:meri_id/presentation/auth/FirstPage.dart';
import 'package:meri_id/presentation/auth/PhoneNumber.dart';
import 'package:meri_id/presentation/features/AddFriend.dart';
import 'package:meri_id/presentation/features/Info.dart';
import 'package:meri_id/presentation/features/Issue.dart';
import 'package:meri_id/presentation/features/Language.dart';
import 'package:meri_id/presentation/kyc/SvgScreen.dart';
import 'package:meri_id/presentation/kyc/KycStepper.dart';
import 'package:meri_id/presentation/kyc/OtherDocumentPage.dart';
import 'presentation/features/Feeds.dart';
import 'utils/strings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        title: StringValues.appName.english,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.white,
            textTheme:
                GoogleFonts.montserratTextTheme(Theme.of(context).textTheme)),
        initialRoute: SplashPage.routeNamed,
        routes: {
          SplashPage.routeNamed: (BuildContext context) => SplashPage(),
          FirstPage.routeNamed: (BuildContext context) => FirstPage(),
          PhoneNumber.routeNamed: (BuildContext context) => PhoneNumber(),
          AddFriend.routeNamed: (BuildContext context) => AddFriend(),
          PANPage.routeNamed: (BuildContext context) => PANPage(),
          AadharPage.routeNamed: (BuildContext context) => AadharPage(),
          VideoPage.routeNamed: (BuildContext context) => VideoPage(),
          OtherDocumentPage.routeNamed: (BuildContext context) =>OtherDocumentPage(),
          KycStepper.routeNamed: (BuildContext context) => KycStepper(),
          SvgScreen.routeNamed: (BuildContext context) => const SvgScreen(),
          Feeds.routeNamed: (BuildContext context) => Feeds(),
          LanguagePage.routeNamed: (BuildContext context) => LanguagePage(),
          Issue.routeNamed: (BuildContext context) => Issue(),
          Info.routeNamed: (BuildContext context) => Info()
        });
  }
}

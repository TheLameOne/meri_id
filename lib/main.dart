import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meri_id/presentation/KYC/AadharPage.dart';
import 'package:meri_id/presentation/KYC/PanPage.dart';
import 'package:meri_id/presentation/KYC/VideoPage.dart';
import 'package:meri_id/presentation/SplashPage.dart';
import 'package:meri_id/presentation/auth/FirstPage.dart';
import 'package:meri_id/presentation/auth/PhoneNumber.dart';
import 'package:meri_id/presentation/auth/otp.dart';
import 'package:meri_id/presentation/features/AddFriend.dart';
import 'package:meri_id/presentation/features/LocationPage.dart';
import 'package:meri_id/presentation/features/SvgScreen.dart';
import 'package:meri_id/presentation/kyc/KycStepper.dart';
import 'package:meri_id/presentation/kyc/OtherDocumentPage.dart';
import 'utils/strings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        ),
        initialRoute: SplashPage.routeNamed,
        routes: {
          SplashPage.routeNamed: (BuildContext context) => SplashPage(),
          FirstPage.routeNamed: (BuildContext context) => FirstPage(),
          OTP.routeNamed: (BuildContext context) => OTP(),
          PhoneNumber.routeNamed: (BuildContext context) => PhoneNumber(),
          Location.routeNamed: (BuildContext context) => Location(),
          AddFriend.routeNamed: (BuildContext context) => AddFriend(),
          PANPage.routeNamed: (BuildContext context) => PANPage(),
          AadharPage.routeNamed: (BuildContext context) => AadharPage(),
          VideoPage.routeNamed: (BuildContext context) => VideoPage(),
          OtherDocumentPage.routeNamed: (BuildContext context) => OtherDocumentPage(),
          KycStepper.routeNamed: (BuildContext context) => KycStepper(),
          SvgScreen.routeNamed: (BuildContext context) => SvgScreen(),
        });
  }
}

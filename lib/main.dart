import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meri_id/presentation/FirstPage.dart';
import 'package:meri_id/presentation/LocationPage.dart';
import 'package:meri_id/presentation/PhoneNumber.dart';
import 'package:meri_id/presentation/SplashPage.dart';
import 'package:meri_id/presentation/otp.dart';
import 'package:meri_id/utils/LanguageChangeProvider.dart';
import 'package:provider/provider.dart';
import 'utils/generated/l10n.dart';
import 'utils/strings.dart';
import 'presentation/SplashPage.dart';
//import 'presentation/location_page.dart';


void main() {
  runApp(MyApp());
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
    return ChangeNotifierProvider<LanguageChangeProvider>(
      create: (context) => LanguageChangeProvider(),
      child: Builder(
        builder: (context) => MaterialApp(
          locale: Provider.of<LanguageChangeProvider>(context, listen: true)
              .currentLocale,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          title: StringValues.APP_NAME,
          debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.white,),
          initialRoute: FirstPage.routeNamed,
                  routes: {
            SplashPage.routeNamed: (BuildContext context) => SplashPage(),     
            FirstPage.routeNamed: (BuildContext context) => FirstPage(),
            OTP.routeNamed: (BuildContext context) => OTP(),
            PhoneNumber.routeNamed: (BuildContext context) => PhoneNumber(),
            Location.routeNamed: (BuildContext context) => Location(),
        }
        ),
      ),
    );
  }
}





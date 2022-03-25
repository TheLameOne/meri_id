import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meri_id/presentation/homepage.dart';
import 'package:meri_id/presentation/location.dart';
import 'package:meri_id/presentation/location2.dart';
import 'package:meri_id/presentation/location_page.dart';
import 'package:meri_id/presentation/otp.dart';
import 'package:meri_id/presentation/splashscreen.dart';
import 'package:meri_id/utils/LanguageChangeProvider.dart';
import 'package:provider/provider.dart';
import 'utils/generated/l10n.dart';
import 'utils/styles.dart';
import 'utils/strings.dart';
import 'presentation/splashscreen.dart';
//import 'presentation/location_page.dart';
import 'presentation/location2.dart';
import "package:meri_id/presentation/homepage.dart";

void main() {
  runApp(const OTPScreen());
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
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: "meri ID"),
        ),
      ),
    );
  }
}

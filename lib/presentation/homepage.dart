import 'package:flutter/material.dart';
import 'package:meri_id/utils/LanguageChangeProvider.dart';
import 'package:meri_id/utils/generated/l10n.dart';
import 'package:meri_id/utils/styles.dart';
import 'package:provider/src/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).welcomeText,
              style: const TextStyle(color: Styles.PURPLE_COLOR),
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<LanguageChangeProvider>().changeLocale("hi");
                },
                child: const Text("Hindi")),
            ElevatedButton(
                onPressed: () {
                  context.read<LanguageChangeProvider>().changeLocale("en");
                },
                child: const Text("English")),
          ],
        ),
      ),
    );
  }
}

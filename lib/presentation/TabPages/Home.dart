import 'package:flutter/material.dart';
import 'package:meri_id/services/widgets/CustomText.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(32), child:
           Column(
                crossAxisAlignment: CrossAxisAlignment.start,
             children: [
              const SizedBox(height: 32),
              CustomText.xLargeText("Home"),
          ])),
    );
  }
}

// buildAvailability(context),
//                 const SizedBox(height: 24),
//                 buildAuthenticate(context),

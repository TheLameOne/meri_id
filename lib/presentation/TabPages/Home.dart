import 'package:flutter/material.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/presentation/custom/CustomCard.dart';
import 'package:meri_id/presentation/features/GoogleMapTracking.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/styles.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _routoTracking() {
    Navigator.pushNamed(context, GoogleMapTracking.routeNamed);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(32),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 32),
            CustomText.xLargeText("Home"),
            CustomCard(
              name: "Harsh Verma",
              date: "22/09/2022",
              time: "3:00 pm",
            ),
            CustomCard(
              name: "Alankar Saxena",
              date: "22/09/2022",
              time: "3:00 pm",
            ),
            CustomCard(
              name: "Savagecarol",
              date: "22/09/2022",
              time: "3:00 pm",
            ),
          ])),
    );
  }
}

// buildAvailability(context),
//                 const SizedBox(height: 24),
//                 buildAuthenticate(context),

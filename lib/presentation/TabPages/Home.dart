import 'package:flutter/material.dart';
import 'package:meri_id/presentation/custom/CustomCard.dart';
import 'package:meri_id/presentation/features/GoogleMapTracking.dart';
import 'package:meri_id/services/widgets/CustomText.dart';

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
            const SizedBox(height: 32),
            for (int i = 0; i < 10; i++)
               CustomCard(
                  name: "Harsh Verma",
                  date: "22/09/2022",
                  time: "3:00 pm",
                  onTap: () {},
                ),              
          ])),
    );
  }
}

// buildAvailability(context),
//                 const SizedBox(height: 24),
//                 buildAuthenticate(context),

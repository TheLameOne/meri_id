import 'package:flutter/material.dart';
import 'package:meri_id/services/widgets/CustomText.dart';


class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(32),
             child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                const SizedBox(height: 32),
                CustomText.xLargeText("Add Booking"),
            ]
          )
        )
      );
  }
}
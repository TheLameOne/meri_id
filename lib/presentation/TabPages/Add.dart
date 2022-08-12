import 'package:flutter/material.dart';
import 'package:meri_id/presentation/custom/CustomTimeBox.dart';
import 'package:meri_id/services/widgets/CustomText.dart';

import '../../utils/styles.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Styles.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              CustomText.xLargeText("Add Bookings"),
              const SizedBox(
                height: 64,
              ),
              CustomTimeBox(),
            ],
          ),
        ),
      ),
    );
  }
}

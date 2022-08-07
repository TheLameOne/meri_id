import 'package:flutter/material.dart';
import 'package:meri_id/utils/styles.dart';
import '../custom/CustomButton.dart';

class Issue extends StatefulWidget {
  const Issue({Key? key}) : super(key: key);

  @override
  State<Issue> createState() => _IssueState();
}

class _IssueState extends State<Issue> {
  _raiseIssue() {
    // print("DF");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              const Text("Raise Issue",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 32)),
              const SizedBox(
                height: 32,
              ),
              Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    border: Border.all(width: 2, color: Styles.iconColor),
                  ),
                  child: TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 3,
                      maxLines: null,
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Montserrat',
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w300))),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: CustomButton(
                    postIcon: Icons.arrow_forward_ios,
                    labelText: "Issue",
                    onTap: () {
                      _raiseIssue();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

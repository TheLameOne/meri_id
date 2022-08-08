import 'package:flutter/material.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';
import 'package:meri_id/presentation/features/CameraScreen.dart';
import 'package:meri_id/utils/global.dart';

import '../custom/Fingerprint.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(children: [
                  Text( (isHindi) ?  "hi my name is khan" : "hi my name "), 
                  buildAvailability(context),
                  const SizedBox(height: 24),
                  buildAuthenticate(context),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CameraScreen()),
                        );
                      },
                      child: const Text("Upload Documents"))
                ]))),
        floatingActionButton: FloatingActionButton(
            elevation: 12,
            tooltip: 'chat bot',
            child: Icon(Icons.people),
            onPressed: () async {
              try {
                dynamic conversationObject = {'appId': '259ee76a76674e8ee1a6d02613a91595f'};
                dynamic result = await KommunicateFlutterPlugin.buildConversation(conversationObject);
                print("Conversation builder success : " + result.toString());
              } on Exception catch (e) {
                print("Conversation builder error occurred : " + e.toString());
              }
            }));
  }

}

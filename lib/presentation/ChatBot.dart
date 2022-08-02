import 'package:flutter/material.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';
// API KEY
// 2NGDNtEYmJvz1o8cC8dKUP13eVtauyks
// APP ID
// 259ee76a76674e8ee1a6d02613a91595f

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5c5aa7),
        title: const Text('Welcome to Kommunicate!'),
      ),
      body: Center(
        child: TextButton(
          child: Icon(Icons.add),
          onPressed: () async {
            try {
              dynamic conversationObject = {
                'appId': '259ee76a76674e8ee1a6d02613a91595f'
              };
              dynamic result = await KommunicateFlutterPlugin.buildConversation(
                  conversationObject);
              print("Conversation builder success : " + result.toString());
            } on Exception catch (e) {
              print("Conversation builder error occurred : " + e.toString());
            }
          },
        ),
      ),
    ));
  }
}

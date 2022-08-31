import 'package:flutter/material.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';
import 'package:meri_id/presentation/TabPages/Add.dart';
import 'package:meri_id/presentation/TabPages/Home.dart';
import 'package:meri_id/presentation/TabPages/Profile.dart';
import 'package:meri_id/utils/global.dart';
import 'package:meri_id/utils/styles.dart';

class SplashPage extends StatefulWidget {
  static const String routeNamed = 'SplashPage';
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isButtonLoading = false;
  _getBody() {
    switch (currentPage) {
      case 0:
        return const Home();
      case 1:
        return const Add();
      case 2:
        return const Profile();
      default:
        return const Home();
    }
  }

  _getBottomBar() {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: Styles.creamColor,
          boxShadow: [
            BoxShadow(
                color: Styles.creamColor, blurRadius: 10, offset: Offset(4, 2))
          ]),
      child: Card(
        color: Styles.creamColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _getBottomBarItem(index: 0, icontab: Icons.home, text: "Home"),
            _getBottomBarItem(index: 1, icontab: Icons.add, text: "Add"),
            _getBottomBarItem(
                index: 2, icontab: Icons.account_circle, text: "Profile"),
          ],
        ),
      ),
    );
  }

  _getBottomBarItem(
      {required int index, required IconData icontab, required String text}) {
    return InkWell(
      onTap: () {
        setState(() {
          currentPage = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color:
                    currentPage == index ? Styles.redColor : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(icontab,
                        color: currentPage == index
                            ? Styles.backgroundColor
                            : Styles.blackColor,
                        size: (28)),
                    // (currentPage == index) ? Container(margin:const EdgeInsets.only(left: 8) ,child: CustomText.smalltext(text)) : const Text('')
                  ],
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: _getBottomBar(),
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[Expanded(child: _getBody())],
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Styles.grayColor,
              elevation: 12,
              tooltip: 'chat bot',
              child: (isButtonLoading)
                  ? Container(
                      height: 14,
                      width: 14,
                      child: const CircularProgressIndicator(
                        color: Styles.blackColor,
                      ),
                    )
                  : const Icon(Icons.help, color: Styles.blackColor),
              onPressed: () async {
                setState(() {
                  isButtonLoading = true;
                });
                try {
                  dynamic conversationObject = {
                    'appId': '259ee76a76674e8ee1a6d02613a91595f'
                  };
                  dynamic result =
                      await KommunicateFlutterPlugin.buildConversation(
                          conversationObject);
                  print("Conversation builder success : " + result.toString());
                } on Exception catch (e) {
                  print(
                      "Conversation builder error occurred : " + e.toString());
                  errorToast("!OOps Some Error Occur", context);
                }
                setState(() {
                  isButtonLoading = false;
                });
              })),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meri_id/presentation/TabPages/Add.dart';
import 'package:meri_id/presentation/TabPages/Home.dart';
import 'package:meri_id/presentation/TabPages/Info.dart';
import 'package:meri_id/utils/global.dart';
import 'package:meri_id/utils/styles.dart';

import 'TabPages/Issue.dart';

class SplashPage extends StatefulWidget {
  static const String routeNamed = 'SplashPage';
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  _getBody() {
    switch (currentPage) {
      case 0:
        return Home();
      case 1:
        return Add();
      case 2:
        return const Info();
      case 3:
        return const Issue();
      case 4:
        return  Add();
      default:
        return Home();
    }
  }

  _getBottomBar() {
    return Card(
      elevation: 20,
      margin: const EdgeInsets.all(0),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)  , topRight: Radius.circular(5) ,  bottomRight : Radius.circular(5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _getBottomBarItem(index: 0, icontab: Icons.home),
          _getBottomBarItem(index: 1, icontab: Icons.add),
          _getBottomBarItem(index: 2, icontab: Icons.info),
          _getBottomBarItem(index: 3, icontab: Icons.info),
          _getBottomBarItem(index: 4, icontab: Icons.info),
        ],
      ),
    );
  }

  void _onPressedAction() {}

  _getBottomBarItem({
    required int index,
    required IconData icontab,
  }) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      margin:  const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: currentPage == index ? Styles.iconColor : Colors.transparent,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
                child: IconButton(
              icon: Icon(icontab, color: currentPage == index ? Colors.white : Colors.black38, size: (28)),
              onPressed: () {
                setState(() {
                  currentPage = index;
                });
              },
            )),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[Expanded(child: _getBody()), _getBottomBar()],
        ),
      ),
    );
  }
}

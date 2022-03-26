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
        break;
      case 1:
        return Add();
        break;
      case 2:
        return Info();
        break;
      case 3:
        return Issue();
        break;
      default:
        return Home();
    }
  }

  _getBottomBar() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      margin: EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _getBottomBarItem(index: 0, icontab: Icons.home),
          _getBottomBarItem(index: 1, icontab: Icons.add),
          _getBottomBarItem(index: 2, icontab: Icons.info),
          _getBottomBarItem(index: 3, icontab: Icons.info),
        ],
      ),
    );
  }

  _getBottomBarItem({
    required int index,
    required IconData icontab,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentPage = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: currentPage == index
                    ? Styles.LightBLue_COLOR
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Icon(
                  icontab,
                  color: currentPage == index ? Colors.white : Colors.black38,
                  size: (32),
                ),
              ),
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
        body: Column(
          children: <Widget>[Expanded(child: _getBody()), _getBottomBar()],
        ),
      ),
    );
  }
}

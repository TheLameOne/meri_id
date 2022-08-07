import 'package:flutter/material.dart';
import 'package:meri_id/utils/styles.dart';

class CustomTextIconCard extends StatelessWidget {
  final String text;
  final double textSize;
  final IconData postIcon;
  final double postIconSize;
  final bool visiblePostIcon;
  final IconData preIcon;
  final double preIconSize;
  final bool visiblePreIcon;
  final Color preIconColor;
  final double sizelabelText;
  final Function onTap;
  final Color defaultColor;
  final bool otherContainer;
  final Color postIconColor;
  final bool onRegpage;
  CustomTextIconCard(
      {required this.onTap,
      required this.text,
      this.textSize = 19,
      required this.postIcon,
      this.postIconSize = 20,
      this.visiblePostIcon = false,
      required this.preIcon,
      this.preIconSize = 24,
      this.visiblePreIcon = false,
      this.sizelabelText = 20,
      this.defaultColor = Styles.iconColor,
      this.preIconColor =Styles.iconColor,
      this.otherContainer = false,
      this.postIconColor = Colors.black,
      this.onRegpage = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
        child: GestureDetector(
          onTap: (otherContainer == true) ? onTap() : () {},
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            height: 60,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: (onRegpage == false)
                ? BoxDecoration(
                    color: defaultColor,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                        BoxShadow(
                            color: Styles.iconColor,
                            blurRadius: 15,
                            offset: Offset(0, 2))
                      ])
                : BoxDecoration(
                    color: defaultColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
            child: Builder(builder: (BuildContext context) {
              if (otherContainer == true) {
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        text,
                        style: TextStyle(
                            fontSize: textSize,
                            color: Styles.iconColor,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: (visiblePostIcon == true)
                            ? Icon(
                              postIcon,
                              size: postIconSize,
                              color: postIconColor,
                            )
                            : Container(),
                      ),
                    ],
                  ),
                );
              } else {
                if ((visiblePreIcon == false && visiblePostIcon == false)) {
                  return Center(
                    child: Container(
                      child: Text(
                        text,
                        style: TextStyle(
                            fontSize: textSize,
                            color: Colors.black,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: (visiblePreIcon == true)
                            ? Icon(
                              preIcon,
                              size: preIconSize,
                              color: preIconColor,
                            )
                            : Container(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            text,
                            style: TextStyle(
                                fontSize: textSize,
                                color: Colors.black,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500),
                          ),
                          Container(
                              child: (visiblePreIcon == true)
                                  ? const SizedBox(
                                      width: 10,
                                    )
                                  : Container()),
                          Container(
                            child: (visiblePostIcon == true)
                                ? GestureDetector(
                                    onTap: (onRegpage == false)
                                        ? onTap()
                                        : () {},
                                    child: Container(
                                      child: Icon(
                                        postIcon,
                                        size: postIconSize,
                                      ),
                                    ),
                                  )
                                : Container(),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              }
            }),
          ),
        ));
  }
}

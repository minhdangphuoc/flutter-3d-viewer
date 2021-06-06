import '../custom_navigation_drawer.dart';
import 'package:flutter/material.dart';

class CollapsingNavigationDrawer extends StatefulWidget {
  @override
  CollapsingNavigationDrawerState createState() {
    return new CollapsingNavigationDrawerState();
  }
}

class CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer>
    with SingleTickerProviderStateMixin {
  double maxWidth = 384;
  double minWidth = 98;
  bool isCollapsed = false;
  late AnimationController _animationController;
  late Animation<double> widthAnimation;
  int currentSelectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    widthAnimation = Tween<double>(begin: maxWidth, end: minWidth)
        .animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, widget) => getWidget(context, widget));
  }

  Widget getWidget(context, widget) {
    return Material(
      elevation: 4.0,
      child: Container(
        width: MediaQuery.of(context).size.width > 540 ? 384 : 98,
        color: drawerBackgroundColor,
        child: Column(
          children: <Widget>[
            Divider(
              height: 8.0,
              color: Colors.transparent,
            ),
            RichText(
              textAlign: TextAlign.right,
              text: TextSpan(
                  text: 'History',
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.w500,
                    fontSize: MediaQuery.of(context).size.width > 540 ? 32 : 0,
                    color: MediaQuery.of(context).size.width > 540
                        ? Color(0xFFE1F6F4)
                        : Colors.transparent,
                  )),
            ),
            Divider(
              height: 8.0,
              color: Colors.transparent,
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, counter) {
                  return Divider(
                    height: 0.0,
                    color: Colors.transparent,
                  );
                },
                itemBuilder: (context, counter) {
                  return CollapsingListTile(
                    onTap: () {
                      setState(() {
                        currentSelectedIndex = counter;
                      });
                    },
                    isSelected: currentSelectedIndex == counter,
                    title: navigationItems[counter].title,
                    icon: navigationItems[counter].icon,
                    animationController: _animationController,
                  );
                },
                itemCount: navigationItems.length,
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
          ],
        ),
      ),
    );
  }
}

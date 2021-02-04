import 'package:flutter/material.dart';
import 'file:///C:/Users/Student/Desktop/New%20folder/inovar/lib/services/routes.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: _drawerItems(),
    );
  }

  Widget _drawerItems() {
    List<ScreenRoute> routes = Routes().routes;
    return ListView.builder(itemBuilder: (context, i) {
      if (i.isOdd) {
        return Divider(
          color: Theme
              .of(context)
              .primaryColorLight,
          endIndent: 20.0,
          indent: 20.0,
          height: 0.0,
          thickness: 0.5,
        );
      }
      return _getItem(routes[i ~/ 2], context);
    },
        itemCount: routes.length * 2
    );
  }

  Widget _getItem(ScreenRoute route, BuildContext context) {
    return ListTile(
        leading: route.logo(Theme.of(context).accentColor),
        title: Text(route.title()),
        visualDensity: VisualDensity(vertical: -2),
        onTap: () {
          Navigator.pop(context);

          bool sameRoute = false;
          Navigator.popUntil(context, (currentRoute) {
            if (currentRoute.settings.name == route.toString()) {
              sameRoute = true;
            }
            return true;
          });
          if (!sameRoute) {
            Navigator.pushNamed(context, route.toString());
          }
        },
    );
  }
}
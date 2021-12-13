import 'package:compound/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:compound/constants/route_names.dart';
import 'package:compound/services/navigation_service.dart';

class NavigationDrawer extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Home Page'),
            leading: Icon(Icons.list),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            title: Text('Patient List'),
            leading: Icon(Icons.contact_page_outlined),
            onTap: () {
              Navigator.of(context).pop();
              _navigationService.navigateTo(PatientViewRoute);
            },
          ),
          ListTile(
            title: Text('Dashborad'),
            leading: Icon(Icons.analytics_outlined),
            onTap: () {
              Navigator.of(context).pop();
              _navigationService.navigateTo(DashboardViewRoute);
            },
          ),
          ListTile(
            title: Text('Log off'),
            leading: Icon(Icons.exit_to_app_outlined),
            onTap: () {
              Navigator.of(context).pop();
              _navigationService.navigateTo(LoginViewRoute);
            },
          ),
        ],
      ),
    );
  }
}

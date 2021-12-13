import 'package:compound/models/Logbook.dart';
import 'package:compound/ui/views/add_new_patient.dart';
import 'package:compound/ui/views/create_logbook_view.dart';
import 'package:compound/ui/views/dashborad_view.dart';
import 'package:compound/ui/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:compound/constants/route_names.dart';
import 'package:compound/ui/views/login_view.dart';
import 'package:compound/ui/views/signup_view.dart';
import 'package:compound/ui/views/Back_up_patient_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginView(),
      );
    case SignUpViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignUpView(),
      );
    case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeView(),
      );

    case DashboardViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: DashboardView(),
      );

    case CreateLogbookViewRoute:
      var logbookToEdit = settings.arguments as Logbook;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CreateLogbookView(
          edittingLogbook: logbookToEdit,
        ),
      );

    case AddPatientViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: AddPatientView(),
      );

    case PatientViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: PatientView(),
      );
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}

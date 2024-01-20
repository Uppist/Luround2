
//model
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/default_route.dart';
import 'package:luround/parsing_url_accviewer/routes.dart';
import 'package:luround/views/account_viewer/people_profile/screen/profile_page_acc_viewer.dart';
import 'package:luround/views/account_viewer/services/screen/services_screen.dart';

class RoutingData {
  final String route;
  final Map<String, String> _queryParameters;
  RoutingData({
    required this.route,
    required Map<String, String> queryParameters,
  }) : _queryParameters = queryParameters;
  operator [](String key) => _queryParameters[key];
}


//extension
extension StringExtension on String {
  RoutingData get getRoutingData {
    var uriData = Uri.parse(this);
    print('queryParameters: ${uriData.queryParameters} path: ${uriData.path}');
    return RoutingData(
      queryParameters: uriData.queryParameters,
      route: uriData.path,
    );
  }
}


//ongenerate func
Route<dynamic> generateRoute(RouteSettings settings) {
  var routingData = settings.name!.getRoutingData; // Get the routing Data
  switch (routingData.route) { // Switch on the path from the data
    case ProfileRoute:
      var name = routingData['user'].toString(); // Get the id from the data.
      return GetPageRoute(
        settings: settings,
        page: () => AccViewerProfilePage(),
      );
    case ServicesRoute:
      var name = routingData['user'].toString(); // Get the id from the data.
      return GetPageRoute(
        settings: settings,
        page: () => AccViewerServicesPage(),
      );
    default:
      var name = routingData['user'].toString(); // Get the id from the data.
      return GetPageRoute(
        settings: settings,
        page: () => AccViewerProfilePage(),
      );
  }
}

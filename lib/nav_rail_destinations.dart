import 'package:flutter/material.dart';
import 'navigationrail_custom.dart';

List<NavigationRailDestination> buildNavRailDestinations(bool extended) {
  //왼쪽 메뉴
  final icons = [
    Icons.local_activity,
    Icons.paragliding,
    Icons.airplanemode_active,
    Icons.route,
  ];
  final labels = [ "Ticket", "Activity", "Tour","Transport"];
  return List.generate(icons.length, (index) {
    return buildCustomNavigationRailDestination(
      icon: icons[index],
      isExtended: extended,
      label: labels[index],
    );
  });
}
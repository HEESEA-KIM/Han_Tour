import 'package:flutter/material.dart';
import 'navigationrail_custom.dart';

List<NavigationRailDestination> buildNavRailDestinations(bool extended) {
  //왼쪽 메뉴
  final icons = [
    Icons.airplanemode_active,
    Icons.paragliding,
    Icons.local_activity,
    Icons.route,
  ];
  final labels = [ "Tour", "Activity", "Ticket","Transport"];
  return List.generate(icons.length, (index) {
    return buildCustomNavigationRailDestination(
      icon: icons[index],
      isExtended: extended,
      label: labels[index],
    );
  });
}
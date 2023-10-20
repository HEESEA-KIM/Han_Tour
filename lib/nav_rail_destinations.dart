import 'package:flutter/material.dart';

import 'navigationrail_custom.dart';

List<NavigationRailDestination> buildNavRailDestinations(bool extended) {
  final icons = [
    Icons.airplane_ticket,
    Icons.airplanemode_active,
    Icons.paragliding,
    Icons.route,
    Icons.hotel
  ];
  final labels = ["Ticket", "Tour", "Activity", "Transport", "Hotel"];
  return List.generate(icons.length, (index) {
    return buildCustomNavigationRailDestination(
      icon: icons[index],
      isExtended: extended,
      label: labels[index],
    );
  });
}
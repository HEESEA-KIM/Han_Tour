import 'package:flutter/material.dart';

NavigationRailDestination buildCustomNavigationRailDestination1({
  required IconData icon,
  required String label,
}) {
  return NavigationRailDestination(
    icon: Row(
      children: [
        Icon(icon),
        SizedBox(width: 8), // 아이콘과 라벨 사이의 간격 조정
        Text(
          'Tour',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),
      ],
    ),
    label: Text(label),
  );
}

NavigationRailDestination buildCustomNavigationRailDestination2({
  required IconData icon,
  required String label,
}) {
  return NavigationRailDestination(
    icon: Row(
      children: [
        Icon(icon),
        SizedBox(width: 8), // 아이콘과 라벨 사이의 간격 조정
        Text(
          'Activity',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),
      ],
    ),
    label: Text(label),
  );
}

NavigationRailDestination buildCustomNavigationRailDestination3({
  required IconData icon,
  required String label,
}) {
  return NavigationRailDestination(
    icon: Row(
      children: [
        Icon(icon),
        SizedBox(width: 6), // 아이콘과 라벨 사이의 간격 조정
        Text(
          'Trans port',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),
      ],
    ),
    label: Text(label),
  );
}

NavigationRailDestination buildCustomNavigationRailDestination4({
  required IconData icon,
  required String label,
}) {
  return NavigationRailDestination(
    icon: Row(
      children: [
        Icon(icon),
        SizedBox(width: 8), // 아이콘과 라벨 사이의 간격 조정
        Text(
          'Ticket',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),
      ],
    ),
    label: Text(label),
  );
}


NavigationRailDestination buildCustomNavigationRailDestination5({
  required IconData icon,
  required String label,
}) {
  return NavigationRailDestination(
    icon: Row(
      children: [
        Icon(icon),
        SizedBox(width: 8), // 아이콘과 라벨 사이의 간격 조정
        Text(
          'Hotel',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),
      ],
    ),
    label: Text(label),
  );
}

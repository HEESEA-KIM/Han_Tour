import 'package:flutter/material.dart';

NavigationRailDestination buildCustomNavigationRailDestination({
  required IconData icon,
  required String label,
  required bool isExtended,
}) {
  return NavigationRailDestination(
    icon: Row(
      children: [
        Icon(icon),
        SizedBox(width: 8), // 아이콘과 라벨 사이의 간격 조정
        if (isExtended)
          Text(
            label,
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

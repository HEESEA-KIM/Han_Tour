import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

NavigationRailDestination buildCustomNavigationRailDestination({
  required IconData icon,
  required String label,
  required bool isExtended,
}) {
  return NavigationRailDestination(
    icon: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SafeArea(
        child: Row(
          children: [
            Icon(icon),
            SizedBox(
              width: 4,
            ), // 아이콘과 라벨 사이의 간격 조정
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
      ),
    ),
    label: Text(label),
  );
}

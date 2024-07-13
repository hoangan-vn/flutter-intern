import 'package:flutter/material.dart';
import 'package:safebump/src/router/route_name.dart';

enum XNavigationBarItems {
  home(
    route: AppRouteNames.home,
    icon: Icons.view_quilt_outlined,
    selectedIcon: Icons.view_quilt,
  ),
  calendar(
    route: AppRouteNames.calendar,
    icon: Icons.calendar_month_outlined,
    selectedIcon: Icons.calendar_month,
  ),
  account(
    route: AppRouteNames.profile,
    icon: Icons.account_circle_outlined,
    selectedIcon: Icons.account_circle,
  );

  const XNavigationBarItems({
    required this.route,
    required this.icon,
    this.selectedIcon,
  });

  final AppRouteNames route;
  final IconData icon;
  final IconData? selectedIcon;

  static XNavigationBarItems fromLocation(String location) {
    if (location == XNavigationBarItems.home.route.name) {
      return XNavigationBarItems.home;
    }

    return XNavigationBarItems.home;
  }
}

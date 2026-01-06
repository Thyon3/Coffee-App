import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Domain entity representing a bottom navigation menu item
class MenuItemEntity extends Equatable {
  const MenuItemEntity({
    required this.icon,
    required this.name,
    required this.route,
  });

  final IconData icon;
  final String name;
  final String route;

  @override
  List<Object?> get props => [icon, name, route];
}

import 'package:flutter/material.dart';

class AppShadow {
  static List<BoxShadow> get soft => [
        BoxShadow(
          color: Colors.black.withAlpha((0.04 * 255).round()),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get medium => [
        BoxShadow(
          color: Colors.black.withAlpha((0.08 * 255).round()),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ];

  static List<BoxShadow> get card => [
        BoxShadow(
          color: const Color(0xFF0F172A).withAlpha((0.05 * 255).round()),
          blurRadius: 12,
          spreadRadius: 0,
          offset: const Offset(0, 2),
        ),
      ];
}

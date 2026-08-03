import 'package:flutter/material.dart';
import 'package:simak_mobile/core/theme/app_colors.dart';
import 'package:simak_mobile/core/theme/app_radius.dart';

class StatusBadge extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const StatusBadge({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });

  factory StatusBadge.success(String label) {
    return StatusBadge(
      label: label,
      backgroundColor: AppColors.successLight,
      textColor: AppColors.success,
    );
  }

  factory StatusBadge.warning(String label) {
    return StatusBadge(
      label: label,
      backgroundColor: AppColors.warningLight,
      textColor: AppColors.warning,
    );
  }

  factory StatusBadge.danger(String label) {
    return StatusBadge(
      label: label,
      backgroundColor: AppColors.dangerLight,
      textColor: AppColors.danger,
    );
  }

  factory StatusBadge.info(String label) {
    return StatusBadge(
      label: label,
      backgroundColor: AppColors.infoLight,
      textColor: AppColors.info,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: AppRadius.radiusFull,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}

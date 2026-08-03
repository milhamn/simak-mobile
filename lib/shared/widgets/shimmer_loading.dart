import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simak_mobile/core/theme/app_colors.dart';
import 'package:simak_mobile/core/theme/app_radius.dart';

class ShimmerLoading extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const ShimmerLoading({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? const Color(0xFF334155) : AppColors.skeletonBase,
      highlightColor: isDark ? const Color(0xFF475569) : AppColors.skeletonHighlight,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF334155) : AppColors.skeletonBase,
          borderRadius: borderRadius ?? AppRadius.radiusSm,
        ),
      ),
    );
  }
}

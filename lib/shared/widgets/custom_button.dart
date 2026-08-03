import 'package:flutter/material.dart';
import 'package:simak_mobile/core/theme/app_colors.dart';
import 'package:simak_mobile/core/theme/app_radius.dart';
import 'package:simak_mobile/core/theme/app_spacing.dart';

enum ButtonType { primary, secondary, outline, text }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final bool isLoading;
  final IconData? icon;
  final double? width;
  final double height;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height = 48.0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color getBackgroundColor() {
      switch (type) {
        case ButtonType.primary:
          return AppColors.primary;
        case ButtonType.secondary:
          return AppColors.secondary;
        case ButtonType.outline:
        case ButtonType.text:
          return Colors.transparent;
      }
    }

    Color getTextColor() {
      switch (type) {
        case ButtonType.primary:
        case ButtonType.secondary:
          return Colors.white;
        case ButtonType.outline:
          return isDark ? AppColors.primaryLight : AppColors.primary;
        case ButtonType.text:
          return isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
      }
    }

    BorderSide getBorderSide() {
      if (type == ButtonType.outline) {
        return BorderSide(
          color: isDark ? AppColors.primaryLight : AppColors.primary,
          width: 1.5,
        );
      }
      return BorderSide.none;
    }

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: getBackgroundColor(),
          foregroundColor: getTextColor(),
          elevation: type == ButtonType.primary ? 2 : 0,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.radiusMd,
            side: getBorderSide(),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20, color: getTextColor()),
                    const SizedBox(width: AppSpacing.xs),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: getTextColor(),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

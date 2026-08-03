import 'package:flutter/material.dart';
import 'package:simak_mobile/core/theme/app_colors.dart';

class BackToTopButton extends StatelessWidget {
  final ScrollController scrollController;

  const BackToTopButton({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      onPressed: () {
        scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
      },
      child: const Icon(Icons.arrow_upward_rounded),
    );
  }
}

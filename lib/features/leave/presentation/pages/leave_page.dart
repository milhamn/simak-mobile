import 'package:flutter/material.dart';
import 'package:simak_mobile/core/theme/app_colors.dart';
import 'package:simak_mobile/core/theme/app_spacing.dart';
import 'package:simak_mobile/shared/widgets/custom_app_bar.dart';
import 'package:simak_mobile/shared/widgets/custom_button.dart';
import 'package:simak_mobile/shared/widgets/custom_card.dart';
import 'package:simak_mobile/shared/widgets/custom_text_field.dart';
import 'package:simak_mobile/shared/widgets/status_badge.dart';

class LeavePage extends StatefulWidget {
  const LeavePage({super.key});

  @override
  State<LeavePage> createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> {
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Pengajuan Cuti Akademik'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Form Permohonan Cuti',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            CustomCard(
              child: Column(
                children: [
                  const CustomTextField(
                    label: 'Semester Cuti',
                    hint: 'Semester Genap 2026/2027',
                    readOnly: true,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  CustomTextField(
                    label: 'Alasan Cuti Akademik',
                    hint: 'Jelaskan alasan pengajuan cuti...',
                    controller: _reasonController,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  CustomButton(
                    text: 'Kirim Pengajuan Cuti',
                    onPressed: () {
                      if (_reasonController.text.trim().isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Pengajuan cuti berhasil dikirimkan ke BAAK & DPA.'),
                            backgroundColor: AppColors.success,
                          ),
                        );
                        _reasonController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            Text(
              'Riwayat Pengajuan Cuti',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Semester Genap 2024/2025', style: TextStyle(fontWeight: FontWeight.bold)),
                      StatusBadge.success('Disetujui'),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text('Alasan: Pekerjaan / Magang Industri', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 4),
                  const Text('Tanggal disetujui: 15 Januari 2025', style: TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

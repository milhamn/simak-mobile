import 'package:flutter/material.dart';
import 'package:simak_mobile/core/theme/app_colors.dart';
import 'package:simak_mobile/core/theme/app_spacing.dart';
import 'package:simak_mobile/shared/widgets/custom_app_bar.dart';
import 'package:simak_mobile/shared/widgets/custom_card.dart';
import 'package:simak_mobile/shared/widgets/status_badge.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final notifications = [
      {
        'title': 'KRS Disetujui DPA',
        'desc': 'Kartu Rencana Studi Semester Ganjil 2026/2027 Anda telah disetujui oleh Dr. Ir. Budi Santoso, M.Kom.',
        'time': '2 jam yang lalu',
        'type': 'Akademik',
      },
      {
        'title': 'Tagihan UKT Berhasil Diperbarui',
        'desc': 'Rincian tagihan UKT Semester Ganjil 2026/2027 telah terbit di menu Tagihan.',
        'time': '1 hari yang lalu',
        'type': 'Keuangan',
      },
      {
        'title': 'Jadwal Kuliah Pengganti',
        'desc': 'Mata kuliah Pemrograman Mobile Lanjut hari Senin diganti ke hari Rabu pukul 10:00 di Lab 3.',
        'time': '3 hari yang lalu',
        'type': 'Jadwal',
      },
    ];

    return Scaffold(
      appBar: const CustomAppBar(title: 'Notifikasi Akademik'),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StatusBadge.info(item['type']!),
                      Text(item['time']!, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    item['title']!,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['desc']!,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

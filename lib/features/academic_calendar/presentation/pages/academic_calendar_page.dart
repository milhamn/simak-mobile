import 'package:flutter/material.dart';
import 'package:simak_mobile/core/theme/app_colors.dart';
import 'package:simak_mobile/core/theme/app_spacing.dart';
import 'package:simak_mobile/shared/widgets/custom_app_bar.dart';
import 'package:simak_mobile/shared/widgets/custom_card.dart';
import 'package:simak_mobile/shared/widgets/status_badge.dart';

class AcademicCalendarPage extends StatelessWidget {
  const AcademicCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Dummy data for Kalender Studi
    final List<Map<String, dynamic>> agendaList = [
      {
        'title': 'Pembayaran Uang Kuliah Semester Ganjil',
        'date': '01 Agu - 25 Agu 2026',
        'status': 'Aktif',
        'description': 'Batas akhir pembayaran uang kuliah untuk semester ganjil.',
      },
      {
        'title': 'Pengisian KRS Online',
        'date': '10 Agu - 28 Agu 2026',
        'status': 'Akan Datang',
        'description': 'Pengisian Kartu Rencana Studi oleh mahasiswa secara online melalui portal.',
      },
      {
        'title': 'Awal Perkuliahan Semester Ganjil',
        'date': '07 Sep 2026',
        'status': 'Akan Datang',
        'description': 'Hari pertama perkuliahan untuk semester ganjil tahun akademik berjalan.',
      },
      {
        'title': 'Batas Akhir Perubahan KRS (Batal Tambah)',
        'date': '18 Sep 2026',
        'status': 'Akan Datang',
        'description': 'Batas akhir bagi mahasiswa untuk melakukan perubahan KRS (Batal Tambah).',
      },
      {
        'title': 'Ujian Tengah Semester (UTS)',
        'date': '26 Okt - 06 Nov 2026',
        'status': 'Akan Datang',
        'description': 'Pelaksanaan Ujian Tengah Semester ganjil.',
      },
      {
        'title': 'Ujian Akhir Semester (UAS)',
        'date': '04 Jan - 15 Jan 2027',
        'status': 'Akan Datang',
        'description': 'Pelaksanaan Ujian Akhir Semester ganjil.',
      },
    ];

    return Scaffold(
      appBar: const CustomAppBar(title: 'Kalender Studi'),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: agendaList.length,
        itemBuilder: (context, index) {
          final item = agendaList[index];
          final String status = item['status'];
          
          Widget badge;
          if (status == 'Aktif') {
            badge = StatusBadge.success(status);
          } else if (status == 'Akan Datang') {
            badge = StatusBadge.info(status);
          } else {
            badge = StatusBadge.warning(status);
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item['title'],
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      badge,
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 14,
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        item['date'],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    item['description'],
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColors.textHintDark : AppColors.textHintLight,
                      height: 1.4,
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

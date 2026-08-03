import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simak_mobile/core/theme/app_colors.dart';
import 'package:simak_mobile/core/theme/app_radius.dart';
import 'package:simak_mobile/core/theme/app_spacing.dart';
import 'package:simak_mobile/features/krs/presentation/bloc/krs_bloc.dart';
import 'package:simak_mobile/features/krs/presentation/bloc/krs_event.dart';
import 'package:simak_mobile/features/krs/presentation/bloc/krs_state.dart';
import 'package:simak_mobile/shared/widgets/custom_app_bar.dart';
import 'package:simak_mobile/shared/widgets/custom_button.dart';
import 'package:simak_mobile/shared/widgets/custom_card.dart';
import 'package:simak_mobile/shared/widgets/error_state_widget.dart';
import 'package:simak_mobile/shared/widgets/shimmer_loading.dart';
import 'package:simak_mobile/shared/widgets/status_badge.dart';

class KrsPage extends StatefulWidget {
  const KrsPage({super.key});

  @override
  State<KrsPage> createState() => _KrsPageState();
}

class _KrsPageState extends State<KrsPage> {
  @override
  void initState() {
    super.initState();
    context.read<KrsBloc>().add(KrsFetchRequested());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Kartu Rencana Studi (KRS)'),
      body: BlocBuilder<KrsBloc, KrsState>(
        builder: (context, state) {
          if (state.status == KrsStatus.loading) {
            return ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: 6,
              itemBuilder: (_, __) => const Padding(
                padding: EdgeInsets.only(bottom: AppSpacing.md),
                child: ShimmerLoading(width: double.infinity, height: 80),
              ),
            );
          } else if (state.status == KrsStatus.failure) {
            return ErrorStateWidget(
              message: state.errorMessage ?? 'Gagal memuat KRS.',
              onRetry: () => context.read<KrsBloc>().add(KrsFetchRequested()),
            );
          }

          return Column(
            children: [
              // Header Summary Status KRS & DPA
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.md),
                color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Semester Ganjil 2026/2027',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Dosen PA: ${state.dpaName}',
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                              ),
                            ),
                          ],
                        ),
                        StatusBadge.success('Disetujui DPA'),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    LinearProgressIndicator(
                      value: state.totalSksTaken / state.maxSks,
                      backgroundColor: isDark ? AppColors.borderDark : AppColors.borderLight,
                      color: AppColors.primary,
                      minHeight: 6,
                      borderRadius: AppRadius.radiusFull,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total SKS Diambil: ${state.totalSksTaken} SKS',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Maksimal SKS: ${state.maxSks} SKS',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),

              // KRS List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  itemCount: state.krsItems.length,
                  itemBuilder: (context, index) {
                    final item = state.krsItems[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withAlpha(25),
                                    borderRadius: AppRadius.radiusXs,
                                  ),
                                  child: Text(
                                    '${item.courseCode} • ${item.classGroup}',
                                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary),
                                  ),
                                ),
                                Text(
                                  '${item.sks} SKS',
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              item.courseName,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.access_time_rounded, size: 14, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(
                                  item.scheduleTime,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Bottom Action Button
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: CustomButton(
                  text: 'Cetak / Unduh Dokumen KRS (PDF)',
                  icon: Icons.picture_as_pdf_rounded,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Dokumen KRS berhasil diunduh ke format PDF.')),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

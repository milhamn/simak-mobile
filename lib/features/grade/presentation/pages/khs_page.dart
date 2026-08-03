import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simak_mobile/core/theme/app_colors.dart';
import 'package:simak_mobile/core/theme/app_radius.dart';
import 'package:simak_mobile/core/theme/app_spacing.dart';
import 'package:simak_mobile/features/grade/presentation/bloc/grade_bloc.dart';
import 'package:simak_mobile/features/grade/presentation/bloc/grade_event.dart';
import 'package:simak_mobile/features/grade/presentation/bloc/grade_state.dart';
import 'package:simak_mobile/shared/widgets/custom_app_bar.dart';
import 'package:simak_mobile/shared/widgets/custom_card.dart';
import 'package:simak_mobile/shared/widgets/error_state_widget.dart';
import 'package:simak_mobile/shared/widgets/shimmer_loading.dart';

class KhsPage extends StatefulWidget {
  const KhsPage({super.key});

  @override
  State<KhsPage> createState() => _KhsPageState();
}

class _KhsPageState extends State<KhsPage> {
  int _selectedSemester = 5;

  @override
  void initState() {
    super.initState();
    context.read<GradeBloc>().add(GradeFetchKhsRequested(_selectedSemester));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Kartu Hasil Studi (KHS)'),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            // Semester Filter Dropdown
            CustomCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pilih Semester:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    ),
                  ),
                  DropdownButton<int>(
                    value: _selectedSemester,
                    underline: const SizedBox(),
                    items: List.generate(8, (index) => index + 1).map((sem) {
                      return DropdownMenuItem<int>(
                        value: sem,
                        child: Text('Semester $sem'),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _selectedSemester = val;
                        });
                        context.read<GradeBloc>().add(GradeFetchKhsRequested(val));
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            Expanded(
              child: BlocBuilder<GradeBloc, GradeState>(
                builder: (context, state) {
                  if (state.status == GradeStatus.loading) {
                    return ListView.builder(
                      itemCount: 5,
                      itemBuilder: (_, __) => const Padding(
                        padding: EdgeInsets.only(bottom: AppSpacing.md),
                        child: ShimmerLoading(width: double.infinity, height: 90),
                      ),
                    );
                  } else if (state.status == GradeStatus.failure) {
                    return ErrorStateWidget(
                      message: state.errorMessage ?? 'Gagal memuat KHS.',
                      onRetry: () => context.read<GradeBloc>().add(GradeFetchKhsRequested(_selectedSemester)),
                    );
                  }

                  return Column(
                    children: [
                      // Summary IPS Card
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(25),
                          borderRadius: AppRadius.radiusMd,
                          border: Border.all(color: AppColors.primary.withAlpha(75)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'Indeks Prestasi Semester (IPS)',
                                  style: TextStyle(fontSize: 12, color: AppColors.primary),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  state.calculatedIps.toStringAsFixed(2),
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                            Container(height: 30, width: 1, color: AppColors.primary.withAlpha(75)),
                            Column(
                              children: [
                                const Text(
                                  'Total SKS Diambil',
                                  style: TextStyle(fontSize: 12, color: AppColors.primary),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${state.totalSks} SKS',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // KHS List
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.khsItems.length,
                          itemBuilder: (context, index) {
                            final item = state.khsItems[index];
                            final gradeColor = _gradeColor(item.gradeLetter);

                            return Padding(
                              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                              child: CustomCard(
                                padding: const EdgeInsets.all(AppSpacing.md),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Grade circle
                                    Container(
                                      width: 52,
                                      height: 52,
                                      decoration: BoxDecoration(
                                        color: gradeColor.withAlpha(30),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          item.gradeLetter,
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: gradeColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: AppSpacing.md),

                                    // Course info
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Course code & SKS
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${item.courseCode} • ${item.sks} SKS',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: isDark ? AppColors.textHintDark : AppColors.textHintLight,
                                                ),
                                              ),
                                              Text(
                                                '(${item.gradePoint.toStringAsFixed(2)})',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                  color: gradeColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 3),

                                          // Course name
                                          Text(
                                            item.courseName,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                                            ),
                                          ),
                                          const SizedBox(height: 5),

                                          // Lecturer name
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.person_outline_rounded,
                                                size: 13,
                                                color: isDark ? AppColors.textHintDark : AppColors.textHintLight,
                                              ),
                                              const SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  item.lecturerName,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Warna grade: A = success, B = primary, C = warning, D/E = danger
  Color _gradeColor(String grade) {
    if (grade.startsWith('A')) return AppColors.success;
    if (grade.startsWith('B')) return AppColors.primary;
    if (grade.startsWith('C')) return AppColors.warning;
    return AppColors.danger;
  }
}

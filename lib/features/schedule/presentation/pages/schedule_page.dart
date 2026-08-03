import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simak_mobile/core/theme/app_colors.dart';
import 'package:simak_mobile/core/theme/app_radius.dart';
import 'package:simak_mobile/core/theme/app_spacing.dart';
import 'package:simak_mobile/features/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:simak_mobile/features/schedule/presentation/bloc/schedule_event.dart';
import 'package:simak_mobile/features/schedule/presentation/bloc/schedule_state.dart';
import 'package:simak_mobile/shared/widgets/custom_app_bar.dart';
import 'package:simak_mobile/shared/widgets/custom_card.dart';
import 'package:simak_mobile/shared/widgets/empty_state_widget.dart';
import 'package:simak_mobile/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:simak_mobile/features/lecturer_schedule/presentation/pages/lecturer_schedule_detail_page.dart';
import 'package:simak_mobile/shared/widgets/error_state_widget.dart';
import 'package:simak_mobile/shared/widgets/shimmer_loading.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];

  @override
  void initState() {
    super.initState();
    
    int currentWeekday = DateTime.now().weekday;
    int initialIndex = currentWeekday - 1;
    if (initialIndex < 0 || initialIndex >= _days.length) {
      initialIndex = 0; // Jika hari Minggu (7), default ke Senin (0)
    }

    _tabController = TabController(initialIndex: initialIndex, length: _days.length, vsync: this);
    context.read<ScheduleBloc>().add(ScheduleFetchRequested());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Jadwal Perkuliahan'),
      body: Column(
        children: [
          Container(
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: AppColors.primary,
              unselectedLabelColor: isDark ? AppColors.textHintDark : AppColors.textHintLight,
              indicatorColor: AppColors.primary,
              tabs: _days.map((day) => Tab(text: day)).toList(),
            ),
          ),
          Expanded(
            child: BlocBuilder<ScheduleBloc, ScheduleState>(
              builder: (context, state) {
                if (state.status == ScheduleStatus.loading) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    itemCount: 4,
                    itemBuilder: (_, __) => const Padding(
                      padding: EdgeInsets.only(bottom: AppSpacing.md),
                      child: ShimmerLoading(width: double.infinity, height: 100),
                    ),
                  );
                } else if (state.status == ScheduleStatus.failure) {
                  return ErrorStateWidget(
                    message: state.errorMessage ?? 'Gagal memuat jadwal.',
                    onRetry: () => context.read<ScheduleBloc>().add(ScheduleFetchRequested()),
                  );
                }

                return TabBarView(
                  controller: _tabController,
                  children: _days.map((day) {
                    final daySchedules = state.schedules.where((s) => s.day == day).toList();

                    if (daySchedules.isEmpty) {
                      return EmptyStateWidget(
                        title: 'Tidak Ada Kuliah',
                        subtitle: 'Tidak ada jadwal perkuliahan pada hari $day.',
                        icon: Icons.event_available_outlined,
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      itemCount: daySchedules.length,
                      itemBuilder: (context, index) {
                        final item = daySchedules[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.md),
                          child: CustomCard(
                            onTap: () {
                              final user = context.read<AuthBloc>().state.user;
                              if (user?.role == 'dosen') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => LecturerScheduleDetailPage(schedule: item),
                                  ),
                                );
                              }
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withAlpha(25),
                                    borderRadius: AppRadius.radiusSm,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        item.timeStart,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      Text(
                                        item.timeEnd,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: AppColors.secondary.withAlpha(40),
                                              borderRadius: AppRadius.radiusXs,
                                            ),
                                            child: Text(
                                              '${item.sks} SKS',
                                              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.secondary),
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            item.courseCode,
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: isDark ? AppColors.textHintDark : AppColors.textHintLight,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
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
                                          const Icon(Icons.room_outlined, size: 14, color: AppColors.warning),
                                          const SizedBox(width: 4),
                                          Text(
                                            item.room,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          const Icon(Icons.group_outlined, size: 14, color: Colors.blue),
                                          const SizedBox(width: 4),
                                          Text(
                                            item.classGroup,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Row(
                                        children: [
                                          const Icon(Icons.person_outline, size: 14, color: Colors.blue),
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
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

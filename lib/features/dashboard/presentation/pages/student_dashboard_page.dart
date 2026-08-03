import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simak_mobile/core/theme/app_colors.dart';
import 'package:simak_mobile/core/theme/app_radius.dart';
import 'package:simak_mobile/core/theme/app_spacing.dart';
import 'package:simak_mobile/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:simak_mobile/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:simak_mobile/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:simak_mobile/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:simak_mobile/shared/widgets/custom_card.dart';
import 'package:simak_mobile/shared/widgets/shimmer_loading.dart';
import 'package:simak_mobile/shared/widgets/status_badge.dart';

class StudentDashboardPage extends StatefulWidget {
  const StudentDashboardPage({super.key});

  @override
  State<StudentDashboardPage> createState() => _StudentDashboardPageState();
}

class _StudentDashboardPageState extends State<StudentDashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(DashboardFetchRequested());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthBloc>().state.user;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<DashboardBloc>().add(DashboardFetchRequested());
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header profile
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.primary.withAlpha(50),
                      backgroundImage: user?.avatarUrl != null ? NetworkImage(user!.avatarUrl!) : null,
                      child: user?.avatarUrl == null
                          ? const Icon(Icons.person, color: AppColors.primary)
                          : null,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.name ?? 'Mahasiswa',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                            ),
                          ),
                          Text(
                            'NIM: ${user?.identifier ?? "-"} • ${user?.programStudi ?? "-"}',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications_outlined),
                      onPressed: () => context.push('/notifications'),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),

                // IPK & IPS Summary Card
                BlocBuilder<DashboardBloc, DashboardState>(
                  builder: (context, state) {
                    if (state.status == DashboardStatus.loading) {
                      return const ShimmerLoading(width: double.infinity, height: 110);
                    }
                    final summary = state.summary;
                    return Container(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.primaryLight],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: AppRadius.radiusLg,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withAlpha(75),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Semester ${summary?.activeSemester ?? 5}',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              StatusBadge.success(summary?.statusAkademik ?? 'Aktif'),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _SummaryStat(
                                label: 'IPK Kumulatif',
                                value: summary?.ipk.toStringAsFixed(2) ?? '3.82',
                              ),
                              Container(height: 30, width: 1, color: Colors.white24),
                              _SummaryStat(
                                label: 'IPS Semester',
                                value: summary?.ips.toStringAsFixed(2) ?? '3.90',
                              ),
                              Container(height: 30, width: 1, color: Colors.white24),
                              _SummaryStat(
                                label: 'Total SKS',
                                value: '${summary?.totalSks ?? 84}',
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.xl),

                // Quick Menu Grid
                Text(
                  'Layanan Akademik',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  mainAxisSpacing: AppSpacing.md,
                  crossAxisSpacing: AppSpacing.sm,
                  children: [
                    _MenuItem(
                      title: 'KRS',
                      icon: Icons.assignment_outlined,
                      color: Colors.orange,
                      onTap: () => context.push('/krs'),
                    ),
                    _MenuItem(
                      title: 'KHS / Nilai',
                      icon: Icons.grade_outlined,
                      color: Colors.blue,
                      onTap: () => context.push('/khs'),
                    ),
                    _MenuItem(
                      title: 'Jadwal',
                      icon: Icons.calendar_month_outlined,
                      color: Colors.green,
                      onTap: () => context.push('/schedule'),
                    ),
                    _MenuItem(
                      title: 'Presensi',
                      icon: Icons.qr_code_scanner_rounded,
                      color: Colors.purple,
                      onTap: () => context.push('/attendance'),
                    ),
                    _MenuItem(
                      title: 'Tagihan',
                      icon: Icons.account_balance_wallet_outlined,
                      color: Colors.teal,
                      onTap: () => context.push('/billing'),
                    ),
                    _MenuItem(
                      title: 'Cuti',
                      icon: Icons.event_busy_outlined,
                      color: Colors.redAccent,
                      onTap: () => context.push('/leave'),
                    ),
                    _MenuItem(
                      title: 'Transkrip',
                      icon: Icons.description_outlined,
                      color: Colors.indigo,
                      onTap: () => context.push('/khs'),
                    ),
                    _MenuItem(
                      title: 'Kalender Studi',
                      icon: Icons.calendar_today_outlined,
                      color: Colors.pink,
                      onTap: () => context.push('/academic-calendar'),
                    ),
                    _MenuItem(
                      title: 'Profil',
                      icon: Icons.person_outline_rounded,
                      color: Colors.blueGrey,
                      onTap: () => context.push('/profile'),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),

                // Pengumuman Section
                Text(
                  'Pengumuman Kampus',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                BlocBuilder<DashboardBloc, DashboardState>(
                  builder: (context, state) {
                    if (state.status == DashboardStatus.loading) {
                      return const ShimmerLoading(width: double.infinity, height: 90);
                    }
                    return Column(
                      children: state.announcements.map((ann) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: CustomCard(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    StatusBadge.info(ann.category),
                                    Text(
                                      '${ann.date.day}/${ann.date.month}/${ann.date.year}',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: isDark ? AppColors.textHintDark : AppColors.textHintLight,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                Text(
                                  ann.title,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  ann.content,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SummaryStat extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _MenuItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.radiusMd,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              borderRadius: AppRadius.radiusMd,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

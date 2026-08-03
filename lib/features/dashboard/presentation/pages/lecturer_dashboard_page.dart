import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simak_mobile/core/theme/app_colors.dart';
import 'package:simak_mobile/core/theme/app_radius.dart';
import 'package:simak_mobile/core/theme/app_spacing.dart';
import 'package:simak_mobile/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:simak_mobile/shared/widgets/custom_card.dart';
import 'package:simak_mobile/features/schedule/domain/entities/schedule_entity.dart';
import 'package:simak_mobile/features/lecturer_schedule/presentation/pages/lecturer_schedule_detail_page.dart';

class LecturerDashboardPage extends StatelessWidget {
  const LecturerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthBloc>().state.user;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Lecturer Header
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.secondary.withAlpha(50),
                    backgroundImage: user?.avatarUrl != null ? NetworkImage(user!.avatarUrl!) : null,
                    child: user?.avatarUrl == null
                        ? const Icon(Icons.person, color: AppColors.secondary)
                        : null,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.name ?? 'Dosen Pengampu',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                          ),
                        ),
                        Text(
                          'NIDN: ${user?.identifier ?? "-"} • ${user?.programStudi ?? "-"}',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // Summary Banner Dosen
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryDark, AppColors.secondary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: AppRadius.radiusLg,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _LecturerStat(label: 'Kelas Mengajar', value: '4'),
                    Container(height: 30, width: 1, color: Colors.white24),
                    _LecturerStat(label: 'Mahasiswa Bimbingan', value: '18'),
                    Container(height: 30, width: 1, color: Colors.white24),
                    _LecturerStat(label: 'Presensi Hari Ini', value: '2 Kelas'),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Menu Dosen
              Text(
                'Menu Utama Dosen',
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
                crossAxisCount: 3,
                mainAxisSpacing: AppSpacing.md,
                crossAxisSpacing: AppSpacing.md,
                children: [
                  _LecturerMenuItem(
                    title: 'Input Nilai',
                    icon: Icons.edit_note_rounded,
                    color: Colors.blue,
                    onTap: () => context.push('/lecturer-grade'),
                  ),
                  _LecturerMenuItem(
                    title: 'Input Presensi',
                    icon: Icons.how_to_reg_rounded,
                    color: Colors.green,
                    onTap: () => context.push('/lecturer-attendance'),
                  ),
                  _LecturerMenuItem(
                    title: 'Jadwal Mengajar',
                    icon: Icons.calendar_today_rounded,
                    color: Colors.orange,
                    onTap: () => context.push('/schedule'),
                  ),
                  _LecturerMenuItem(
                    title: 'Bimbingan DPA',
                    icon: Icons.people_alt_outlined,
                    color: Colors.purple,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Daftar mahasiswa bimbingan DPA aktif (18 Mahasiswa).')),
                      );
                    },
                  ),
                  _LecturerMenuItem(
                    title: 'Pengumuman',
                    icon: Icons.campaign_outlined,
                    color: Colors.teal,
                    onTap: () => context.push('/notifications'),
                  ),
                  _LecturerMenuItem(
                    title: 'Profil Saya',
                    icon: Icons.person_outline_rounded,
                    color: Colors.blueGrey,
                    onTap: () => context.push('/profile'),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),

              // Schedule Today Preview
              Text(
                'Jadwal Mengajar Hari Ini',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              CustomCard(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LecturerScheduleDetailPage(
                        schedule: ScheduleEntity(
                          id: 'SCH-01',
                          courseCode: 'TIF501',
                          courseName: 'Pemrograman Mobile Lanjut',
                          sks: 3,
                          day: 'Senin',
                          timeStart: '08:00',
                          timeEnd: '10:30',
                          room: 'Lab Komputer 3',
                          lecturerName: 'Dr. Ir. Budi Santoso, M.Kom.',
                          classGroup: 'TI-5A',
                        ),
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withAlpha(25),
                        borderRadius: AppRadius.radiusSm,
                      ),
                      child: const Column(
                        children: [
                          Text('08:00', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                          Text('10:30', style: TextStyle(fontSize: 11, color: AppColors.primary)),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pemrograman Mobile Lanjut',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Text('Ruang Lab Komputer 3 • Kelas TI-5A (35 Mahasiswa)', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LecturerStat extends StatelessWidget {
  final String label;
  final String value;

  const _LecturerStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.white70)),
      ],
    );
  }
}

class _LecturerMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _LecturerMenuItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CustomCard(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

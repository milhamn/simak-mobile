import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simak_mobile/core/theme/app_colors.dart';
import 'package:simak_mobile/core/theme/app_radius.dart';
import 'package:simak_mobile/core/theme/app_spacing.dart';
import 'package:simak_mobile/features/attendance/presentation/bloc/attendance_bloc.dart';
import 'package:simak_mobile/features/attendance/presentation/bloc/attendance_event.dart';
import 'package:simak_mobile/features/attendance/presentation/bloc/attendance_state.dart';
import 'package:simak_mobile/shared/widgets/custom_app_bar.dart';
import 'package:simak_mobile/shared/widgets/custom_card.dart';
import 'package:simak_mobile/shared/widgets/custom_text_field.dart';
import 'package:simak_mobile/shared/widgets/error_state_widget.dart';
import 'package:simak_mobile/shared/widgets/shimmer_loading.dart';

class StudentAttendancePage extends StatefulWidget {
  const StudentAttendancePage({super.key});

  @override
  State<StudentAttendancePage> createState() => _StudentAttendancePageState();
}

class _StudentAttendancePageState extends State<StudentAttendancePage> {
  final _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AttendanceBloc>().add(AttendanceFetchRequested());
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _showScanDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Presensi Perkuliahan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Masukkan 6 digit kode presensi yang ditampilkan oleh dosen pengampu.'),
              const SizedBox(height: AppSpacing.md),
              CustomTextField(
                label: 'Kode Presensi',
                hint: 'Contoh: SIMAK2026',
                controller: _codeController,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final code = _codeController.text.trim();
                if (code.isNotEmpty) {
                  Navigator.pop(dialogContext);
                  context.read<AttendanceBloc>().add(AttendanceCodeSubmitted(code));
                }
              },
              child: const Text('Kirim Presensi'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Rekap Presensi Mahasiswa'),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showScanDialog,
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.qr_code_scanner_rounded, color: Colors.white),
        label: const Text('Input Kode Presensi', style: TextStyle(color: Colors.white)),
      ),
      body: BlocConsumer<AttendanceBloc, AttendanceState>(
        listener: (context, state) {
          if (state.status == AttendanceStatus.submitSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.successMessage ?? 'Presensi berhasil!'), backgroundColor: AppColors.success),
            );
          } else if (state.status == AttendanceStatus.failure && state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!), backgroundColor: AppColors.danger),
            );
          }
        },
        builder: (context, state) {
          if (state.status == AttendanceStatus.loading) {
            return ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: 5,
              itemBuilder: (_, __) => const Padding(
                padding: EdgeInsets.only(bottom: AppSpacing.md),
                child: ShimmerLoading(width: double.infinity, height: 80),
              ),
            );
          } else if (state.status == AttendanceStatus.failure && state.attendanceItems.isEmpty) {
            return ErrorStateWidget(
              message: state.errorMessage ?? 'Gagal memuat presensi.',
              onRetry: () => context.read<AttendanceBloc>().add(AttendanceFetchRequested()),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: state.attendanceItems.length,
            itemBuilder: (context, index) {
              final item = state.attendanceItems[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: CustomCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.courseCode,
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary),
                          ),
                          Text(
                            '${item.percentage.toStringAsFixed(1)}%',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: item.percentage >= 80 ? AppColors.success : AppColors.danger,
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
                      const SizedBox(height: AppSpacing.sm),
                      LinearProgressIndicator(
                        value: item.percentage / 100,
                        backgroundColor: isDark ? AppColors.borderDark : AppColors.borderLight,
                        color: item.percentage >= 80 ? AppColors.success : AppColors.danger,
                        minHeight: 6,
                        borderRadius: AppRadius.radiusFull,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Kehadiran: ${item.attendedMeetings} dari ${item.totalMeetings} Pertemuan',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

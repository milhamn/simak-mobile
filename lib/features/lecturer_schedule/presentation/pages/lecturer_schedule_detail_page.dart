import 'package:flutter/material.dart';
import 'package:simak_mobile/core/theme/app_colors.dart';
import 'package:simak_mobile/core/theme/app_radius.dart';
import 'package:simak_mobile/core/theme/app_spacing.dart';
import 'package:simak_mobile/features/lecturer_schedule/domain/entities/student_enrollment_entity.dart';
import 'package:simak_mobile/features/schedule/domain/entities/schedule_entity.dart';
import 'package:simak_mobile/shared/widgets/custom_app_bar.dart';
import 'package:simak_mobile/shared/widgets/custom_button.dart';
import 'package:simak_mobile/shared/widgets/custom_card.dart';
import 'package:simak_mobile/shared/widgets/status_badge.dart';

/// Halaman detail jadwal mengajar dosen — menampilkan info kelas,
/// daftar mahasiswa terdaftar, dan aksi langsung Input Presensi / Input Nilai.
class LecturerScheduleDetailPage extends StatelessWidget {
  final ScheduleEntity schedule;

  const LecturerScheduleDetailPage({super.key, required this.schedule});

  // Dummy daftar mahasiswa per kelas
  static final List<StudentEnrollmentEntity> _dummyStudents = [
    const StudentEnrollmentEntity(nim: '220512044', name: 'M. Ilham Nurdiansyah', programStudi: 'S1 Teknik Informatika', avatarUrl: 'https://i.pravatar.cc/100?img=12'),
    const StudentEnrollmentEntity(nim: '220512045', name: 'Anisa Rahmawati', programStudi: 'S1 Teknik Informatika', avatarUrl: 'https://i.pravatar.cc/100?img=47'),
    const StudentEnrollmentEntity(nim: '220512046', name: 'Budi Pratama', programStudi: 'S1 Teknik Informatika', avatarUrl: 'https://i.pravatar.cc/100?img=57'),
    const StudentEnrollmentEntity(nim: '220512047', name: 'Citra Lestari', programStudi: 'S1 Teknik Informatika', avatarUrl: 'https://i.pravatar.cc/100?img=44'),
    const StudentEnrollmentEntity(nim: '220512048', name: 'Dian Permana', programStudi: 'S1 Teknik Informatika', avatarUrl: 'https://i.pravatar.cc/100?img=52'),
    const StudentEnrollmentEntity(nim: '220512049', name: 'Eko Santoso', programStudi: 'S1 Teknik Informatika', avatarUrl: 'https://i.pravatar.cc/100?img=56'),
    const StudentEnrollmentEntity(nim: '220512050', name: 'Fitriana Dewi', programStudi: 'S1 Teknik Informatika', avatarUrl: 'https://i.pravatar.cc/100?img=49'),
    const StudentEnrollmentEntity(nim: '220512051', name: 'Gunawan Putra', programStudi: 'S1 Teknik Informatika', avatarUrl: 'https://i.pravatar.cc/100?img=60'),
    const StudentEnrollmentEntity(nim: '220512052', name: 'Hana Setiawati', programStudi: 'S1 Teknik Informatika', avatarUrl: 'https://i.pravatar.cc/100?img=48'),
    const StudentEnrollmentEntity(nim: '220512053', name: 'Irwan Hakim', programStudi: 'S1 Teknik Informatika', avatarUrl: 'https://i.pravatar.cc/100?img=58'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Detail Kelas'),
      body: Column(
        children: [
          // ── Header info kelas ───────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primaryDark, AppColors.primary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: AppRadius.radiusLg.bottomLeft,
                bottomRight: AppRadius.radiusLg.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: AppRadius.radiusXs,
                      ),
                      child: Text(
                        schedule.courseCode,
                        style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${schedule.sks} SKS',
                      style: const TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  schedule.courseName,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    _InfoChip(icon: Icons.group_outlined, label: 'Kelas ${schedule.classGroup}'),
                    const SizedBox(width: 8),
                    _InfoChip(icon: Icons.people_alt_outlined, label: '${_dummyStudents.length} Mahasiswa'),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _InfoChip(icon: Icons.access_time_rounded, label: '${schedule.timeStart} – ${schedule.timeEnd}'),
                    const SizedBox(width: 8),
                    _InfoChip(icon: Icons.room_outlined, label: schedule.room),
                  ],
                ),
              ],
            ),
          ),

          // ── Aksi cepat ─────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.md, AppSpacing.md, 0),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Input Presensi',
                    icon: Icons.how_to_reg_rounded,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => _LecturerAttendanceInputPage(schedule: schedule, students: _dummyStudents),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: CustomButton(
                    text: 'Input Nilai',
                    icon: Icons.edit_note_rounded,
                    type: ButtonType.secondary,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => _LecturerGradeInputInlinePage(schedule: schedule, students: _dummyStudents),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // ── Daftar mahasiswa ────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.xs),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Daftar Mahasiswa (${_dummyStudents.length})',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  ),
                ),
                StatusBadge.success('Terdaftar'),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              itemCount: _dummyStudents.length,
              itemBuilder: (context, index) {
                final student = _dummyStudents[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: CustomCard(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                    child: Row(
                      children: [
                        // Nomor urut
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withAlpha(25),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        // Avatar
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(student.avatarUrl),
                          backgroundColor: AppColors.primary.withAlpha(25),
                          onBackgroundImageError: (_, __) {},
                          child: student.avatarUrl.isEmpty
                              ? Text(student.name[0], style: const TextStyle(fontWeight: FontWeight.bold))
                              : null,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        // Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                student.name,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                                ),
                              ),
                              Text(
                                'NIM: ${student.nim}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark ? AppColors.textHintDark : AppColors.textHintLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                        StatusBadge.success('Aktif'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// INLINE: Input Presensi untuk kelas yang dipilih dari detail jadwal
// ────────────────────────────────────────────────────────────────────────────
class _LecturerAttendanceInputPage extends StatefulWidget {
  final ScheduleEntity schedule;
  final List<StudentEnrollmentEntity> students;

  const _LecturerAttendanceInputPage({required this.schedule, required this.students});

  @override
  State<_LecturerAttendanceInputPage> createState() => _LecturerAttendanceInputPageState();
}

class _LecturerAttendanceInputPageState extends State<_LecturerAttendanceInputPage> {
  final Map<String, String> _status = {}; // nim → status

  @override
  void initState() {
    super.initState();
    for (final s in widget.students) {
      _status[s.nim] = 'Hadir';
    }
  }

  static const List<String> _statusOptions = ['Hadir', 'Izin', 'Sakit', 'Alpa'];

  Color _statusColor(String status) {
    switch (status) {
      case 'Hadir': return AppColors.success;
      case 'Izin': return AppColors.warning;
      case 'Sakit': return Colors.blue;
      default: return AppColors.danger;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hadirCount = _status.values.where((v) => v == 'Hadir').length;

    return Scaffold(
      appBar: CustomAppBar(title: 'Presensi ${widget.schedule.classGroup}'),
      body: Column(
        children: [
          // Header info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.schedule.courseName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 2),
                Text(
                  '${widget.schedule.day} • ${widget.schedule.timeStart}–${widget.schedule.timeEnd} • ${widget.schedule.room}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    _AttendanceStat(label: 'Hadir', count: _status.values.where((v) => v == 'Hadir').length, color: AppColors.success),
                    const SizedBox(width: 12),
                    _AttendanceStat(label: 'Izin', count: _status.values.where((v) => v == 'Izin').length, color: AppColors.warning),
                    const SizedBox(width: 12),
                    _AttendanceStat(label: 'Sakit', count: _status.values.where((v) => v == 'Sakit').length, color: Colors.blue),
                    const SizedBox(width: 12),
                    _AttendanceStat(label: 'Alpa', count: _status.values.where((v) => v == 'Alpa').length, color: AppColors.danger),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: widget.students.length,
              itemBuilder: (context, index) {
                final student = widget.students[index];
                final currentStatus = _status[student.nim] ?? 'Hadir';

                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: CustomCard(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: _statusColor(currentStatus).withAlpha(25),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text('${index + 1}',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: _statusColor(currentStatus)),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(student.name, style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                              )),
                              Text('NIM: ${student.nim}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                            ],
                          ),
                        ),
                        // Status selector chips
                        Row(
                          children: _statusOptions.map((opt) {
                            final selected = currentStatus == opt;
                            return Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: GestureDetector(
                                onTap: () => setState(() => _status[student.nim] = opt),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: selected ? _statusColor(opt) : _statusColor(opt).withAlpha(25),
                                    borderRadius: AppRadius.radiusXs,
                                    border: Border.all(color: _statusColor(opt).withAlpha(100)),
                                  ),
                                  child: Text(
                                    opt[0], // 'H', 'I', 'S', 'A'
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: selected ? Colors.white : _statusColor(opt),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: CustomButton(
              text: 'Simpan Presensi ($hadirCount Hadir dari ${widget.students.length})',
              icon: Icons.check_circle_rounded,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Presensi berhasil disimpan ke sistem SIMAK.'),
                    backgroundColor: AppColors.success,
                  ),
                );
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AttendanceStat extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _AttendanceStat({required this.label, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text('$count $label', style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// INLINE: Input Nilai untuk kelas yang dipilih dari detail jadwal
// ────────────────────────────────────────────────────────────────────────────
class _LecturerGradeInputInlinePage extends StatefulWidget {
  final ScheduleEntity schedule;
  final List<StudentEnrollmentEntity> students;

  const _LecturerGradeInputInlinePage({required this.schedule, required this.students});

  @override
  State<_LecturerGradeInputInlinePage> createState() => _LecturerGradeInputInlinePageState();
}

class _LecturerGradeInputInlinePageState extends State<_LecturerGradeInputInlinePage> {
  late final Map<String, Map<String, double>> _scores;

  @override
  void initState() {
    super.initState();
    _scores = {
      for (final s in widget.students)
        s.nim: {'tugas': 80.0, 'uts': 75.0, 'uas': 78.0},
    };
  }

  String _gradeFromScore(double t, double uts, double uas) {
    final total = t * 0.3 + uts * 0.3 + uas * 0.4;
    if (total >= 85) return 'A';
    if (total >= 75) return 'B';
    if (total >= 65) return 'C';
    if (total >= 50) return 'D';
    return 'E';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(title: 'Input Nilai ${widget.schedule.classGroup}'),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.schedule.courseName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 2),
                const Text('Bobot: Tugas 30% • UTS 30% • UAS 40%', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          const Divider(height: 1),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: widget.students.length,
              itemBuilder: (context, index) {
                final student = widget.students[index];
                final grades = _scores[student.nim]!;
                final grade = _gradeFromScore(grades['tugas']!, grades['uts']!, grades['uas']!);
                final gradeColor = grade == 'A' ? AppColors.success : grade == 'B' ? AppColors.primary : AppColors.warning;

                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: CustomCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text('NIM: ${student.nim}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                              Text(student.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,
                                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                              )),
                            ]),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                color: gradeColor.withAlpha(25),
                                borderRadius: AppRadius.radiusMd,
                                border: Border.all(color: gradeColor.withAlpha(80)),
                              ),
                              child: Text('Nilai: $grade', style: TextStyle(fontWeight: FontWeight.bold, color: gradeColor)),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Row(
                          children: [
                            _ScoreSlider(label: 'Tugas', value: grades['tugas']!, color: Colors.orange,
                              onChanged: (v) => setState(() => _scores[student.nim]!['tugas'] = v),
                            ),
                            const SizedBox(width: 8),
                            _ScoreSlider(label: 'UTS', value: grades['uts']!, color: Colors.blue,
                              onChanged: (v) => setState(() => _scores[student.nim]!['uts'] = v),
                            ),
                            const SizedBox(width: 8),
                            _ScoreSlider(label: 'UAS', value: grades['uas']!, color: Colors.purple,
                              onChanged: (v) => setState(() => _scores[student.nim]!['uas'] = v),
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

          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: CustomButton(
              text: 'Finalisasi & Simpan Seluruh Nilai',
              icon: Icons.lock_rounded,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Nilai berhasil dikunci & disimpan ke sistem SIMAK.'), backgroundColor: AppColors.success),
                );
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreSlider extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  final ValueChanged<double> onChanged;

  const _ScoreSlider({required this.label, required this.value, required this.color, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: AppRadius.radiusXs,
            ),
            child: Text(value.toStringAsFixed(0),
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: color),
            ),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              trackHeight: 3,
              activeTrackColor: color,
              inactiveTrackColor: color.withAlpha(40),
              thumbColor: color,
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
            ),
            child: Slider(value: value, min: 0, max: 100, divisions: 100, onChanged: onChanged),
          ),
        ],
      ),
    );
  }
}

// Helper widget
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: Colors.white),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.white)),
        ],
      ),
    );
  }
}

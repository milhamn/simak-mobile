import 'package:flutter/material.dart';
import 'package:simak_mobile/core/theme/app_colors.dart';
import 'package:simak_mobile/core/theme/app_spacing.dart';
import 'package:simak_mobile/shared/widgets/custom_app_bar.dart';
import 'package:simak_mobile/shared/widgets/custom_button.dart';
import 'package:simak_mobile/shared/widgets/custom_card.dart';

class LecturerAttendancePage extends StatefulWidget {
  const LecturerAttendancePage({super.key});

  @override
  State<LecturerAttendancePage> createState() => _LecturerAttendancePageState();
}

class _LecturerAttendancePageState extends State<LecturerAttendancePage> {
  final Map<int, String> _studentStatus = {
    0: 'Hadir',
    1: 'Hadir',
    2: 'Izin',
    3: 'Hadir',
    4: 'Sakit',
  };

  final List<String> _students = [
    '220512044 - M. Ilham Nurdiansyah',
    '220512045 - Anisa Rahmawati',
    '220512046 - Budi Pratama',
    '220512047 - Citra Dewi',
    '220512048 - Dedi Kurniawan',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Input Presensi Mahasiswa'),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pemrograman Mobile Lanjut (TI-5A)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 2),
                Text('Pertemuan ke-8 • Senin, 26 Juli 2026', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          const Divider(height: 1),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: _students.length,
              itemBuilder: (context, index) {
                final student = _students[index];
                final currentStatus = _studentStatus[index] ?? 'Hadir';

                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: CustomCard(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            student,
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                          ),
                        ),
                        DropdownButton<String>(
                          value: currentStatus,
                          underline: const SizedBox(),
                          items: ['Hadir', 'Izin', 'Sakit', 'Alpa'].map((st) {
                            return DropdownMenuItem<String>(
                              value: st,
                              child: Text(st, style: const TextStyle(fontSize: 12)),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _studentStatus[index] = val;
                              });
                            }
                          },
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
              text: 'Simpan Presensi Pertemuan Ini',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Presensi mahasiswa berhasil disimpan.'), backgroundColor: AppColors.success),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

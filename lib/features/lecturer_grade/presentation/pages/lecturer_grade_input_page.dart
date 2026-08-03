import 'package:flutter/material.dart';
import 'package:simak_mobile/core/theme/app_colors.dart';
import 'package:simak_mobile/core/theme/app_spacing.dart';
import 'package:simak_mobile/shared/widgets/custom_app_bar.dart';
import 'package:simak_mobile/shared/widgets/custom_button.dart';
import 'package:simak_mobile/shared/widgets/custom_card.dart';

class LecturerGradeInputPage extends StatefulWidget {
  const LecturerGradeInputPage({super.key});

  @override
  State<LecturerGradeInputPage> createState() => _LecturerGradeInputPageState();
}

class _LecturerGradeInputPageState extends State<LecturerGradeInputPage> {
  final List<Map<String, dynamic>> _studentsGrade = [
    {
      'nim': '220512044',
      'nama': 'M. Ilham Nurdiansyah',
      'tugas': 90.0,
      'uts': 85.0,
      'uas': 88.0,
    },
    {
      'nim': '220512045',
      'nama': 'Anisa Rahmawati',
      'tugas': 88.0,
      'uts': 80.0,
      'uas': 85.0,
    },
    {
      'nim': '220512046',
      'nama': 'Budi Pratama',
      'tugas': 75.0,
      'uts': 70.0,
      'uas': 78.0,
    },
  ];

  String _calculateFinalGrade(double tugas, double uts, double uas) {
    final score = (tugas * 0.3) + (uts * 0.3) + (uas * 0.4);
    if (score >= 85) return 'A';
    if (score >= 75) return 'B';
    if (score >= 65) return 'C';
    if (score >= 50) return 'D';
    return 'E';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Input Nilai Mahasiswa'),
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
                Text('Bobot: Tugas 30% • UTS 30% • UAS 40%', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          const Divider(height: 1),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: _studentsGrade.length,
              itemBuilder: (context, index) {
                final item = _studentsGrade[index];
                final finalGrade = _calculateFinalGrade(item['tugas'], item['uts'], item['uas']);

                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: CustomCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${item['nim']}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                                Text('${item['nama']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withAlpha(25),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Nilai: $finalGrade',
                                style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Row(
                          children: [
                            _ScoreField(label: 'Tugas', score: item['tugas']),
                            const SizedBox(width: AppSpacing.sm),
                            _ScoreField(label: 'UTS', score: item['uts']),
                            const SizedBox(width: AppSpacing.sm),
                            _ScoreField(label: 'UAS', score: item['uas']),
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
              text: 'Simpan & Finalisasi Nilai',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Nilai mahasiswa berhasil dikunci & disimpan.'), backgroundColor: AppColors.success),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreField extends StatelessWidget {
  final String label;
  final double score;

  const _ScoreField({required this.label, required this.score});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
          const SizedBox(height: 2),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                score.toStringAsFixed(0),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

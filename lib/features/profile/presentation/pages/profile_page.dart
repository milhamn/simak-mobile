import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simak_mobile/core/theme/app_colors.dart';
import 'package:simak_mobile/core/theme/app_spacing.dart';
import 'package:simak_mobile/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:simak_mobile/features/authentication/presentation/bloc/auth_event.dart';
import 'package:simak_mobile/shared/widgets/custom_app_bar.dart';
import 'package:simak_mobile/shared/widgets/custom_button.dart';
import 'package:simak_mobile/shared/widgets/custom_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthBloc>().state.user;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Profil Pengguna'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.md),
            CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.primary.withAlpha(50),
              backgroundImage: user?.avatarUrl != null ? NetworkImage(user!.avatarUrl!) : null,
              child: user?.avatarUrl == null ? const Icon(Icons.person, size: 40, color: AppColors.primary) : null,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              user?.name ?? 'Pengguna SIMAK',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${user?.role.toUpperCase() ?? "MAHASISWA"} • ${user?.identifier ?? "-"}',
                  style: const TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 4),
                InkWell(
                  onTap: () {
                    final identifier = user?.identifier ?? "-";
                    if (identifier != "-") {
                      Clipboard.setData(ClipboardData(text: identifier));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('ID/NIM berhasil disalin ke clipboard')),
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(4),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(Icons.copy_rounded, size: 14, color: AppColors.primary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            CustomCard(
              child: Column(
                children: [
                  _ProfileTile(icon: Icons.email_outlined, label: 'Email', value: user?.email ?? '-'),
                  const Divider(),
                  _ProfileTile(icon: Icons.school_outlined, label: 'Program Studi', value: user?.programStudi ?? '-'),
                  const Divider(),
                  const _ProfileTile(icon: Icons.account_balance_outlined, label: 'Fakultas', value: 'Fakultas Ilmu Komputer'),
                  const Divider(),
                  const _ProfileTile(icon: Icons.verified_outlined, label: 'Status Akademik', value: 'Aktif Perkuliahan'),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            CustomCard(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.lock_outline_rounded, color: AppColors.primary),
                    title: const Text('Ubah Kata Sandi'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Fitur ubah kata sandi dapat dilakukan melalui portal web BAAK.')),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.fingerprint_rounded, color: AppColors.secondary),
                    title: const Text('Biometrik / Face ID Login'),
                    trailing: Switch(value: true, onChanged: (v) {}),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            CustomButton(
              text: 'Keluar Dari Akun',
              icon: Icons.logout_rounded,
              type: ButtonType.outline,
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutRequested());
                context.go('/portal');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ProfileTile({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: AppSpacing.md),
          Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

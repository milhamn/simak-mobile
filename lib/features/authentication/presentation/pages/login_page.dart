import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simak_mobile/core/theme/app_colors.dart';
import 'package:simak_mobile/core/theme/app_spacing.dart';
import 'package:simak_mobile/shared/widgets/custom_button.dart';
import 'package:simak_mobile/shared/widgets/custom_text_field.dart';
import 'package:simak_mobile/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:simak_mobile/features/authentication/presentation/bloc/auth_event.dart';
import 'package:simak_mobile/features/authentication/presentation/bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  final String role; // 'mahasiswa' or 'dosen'

  const LoginPage({super.key, required this.role});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.role == 'dosen') {
      _identifierController.text = '210512001';
      _passwordController.text = 'dosen123';
    } else {
      _identifierController.text = '220512044';
      _passwordController.text = 'mahasiswa123';
    }
  }

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginSubmitted() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            AuthLoginSubmitted(
              identifier: _identifierController.text.trim(),
              password: _passwordController.text.trim(),
              role: widget.role,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDosen = widget.role == 'dosen';

    return Scaffold(
      appBar: AppBar(
        title: Text(isDosen ? 'Login Dosen' : 'Login Mahasiswa'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            if (state.user?.role == 'dosen') {
              context.go('/lecturer-dashboard');
            } else {
              context.go('/student-dashboard');
            }
          } else if (state.status == AuthStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Gagal login. Periksa data Anda.'),
                backgroundColor: AppColors.danger,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state.status == AuthStatus.loading;

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      isDosen ? 'Masuk Portal Dosen' : 'Masuk Portal Mahasiswa',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      isDosen
                          ? 'Masukkan NIDN dan Kata Sandi dosen Anda.'
                          : 'Masukkan NIM dan Kata Sandi mahasiswa Anda.',
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    CustomTextField(
                      label: isDosen ? 'NIDN / NIK' : 'NIM (Nomor Induk Mahasiswa)',
                      hint: isDosen ? 'Contoh: 210512001' : 'Contoh: 220512044',
                      controller: _identifierController,
                      prefixIcon: Icons.badge_outlined,
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return isDosen ? 'NIDN wajib diisi' : 'NIM wajib diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    CustomTextField(
                      label: 'Kata Sandi',
                      hint: 'Masukkan kata sandi',
                      controller: _passwordController,
                      isPassword: true,
                      prefixIcon: Icons.lock_outline_rounded,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Kata sandi wajib diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Silakan hubungi BAAK / IT Center Universitas untuk reset kata sandi.'),
                            ),
                          );
                        },
                        child: const Text('Lupa Kata Sandi?'),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    CustomButton(
                      text: 'Masuk Sekarang',
                      onPressed: _onLoginSubmitted,
                      isLoading: isLoading,
                      icon: Icons.login_rounded,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

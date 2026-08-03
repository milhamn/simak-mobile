import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simak_mobile/core/theme/app_colors.dart';
import 'package:simak_mobile/core/theme/app_spacing.dart';
import 'package:simak_mobile/core/utils/formatters.dart';
import 'package:simak_mobile/features/billing/presentation/bloc/billing_bloc.dart';
import 'package:simak_mobile/features/billing/presentation/bloc/billing_event.dart';
import 'package:simak_mobile/features/billing/presentation/bloc/billing_state.dart';
import 'package:simak_mobile/shared/widgets/custom_app_bar.dart';
import 'package:simak_mobile/shared/widgets/custom_card.dart';
import 'package:simak_mobile/shared/widgets/error_state_widget.dart';
import 'package:simak_mobile/shared/widgets/shimmer_loading.dart';
import 'package:simak_mobile/shared/widgets/status_badge.dart';

class BillingPage extends StatefulWidget {
  const BillingPage({super.key});

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  @override
  void initState() {
    super.initState();
    context.read<BillingBloc>().add(BillingFetchRequested());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Tagihan & Pembayaran'),
      body: BlocBuilder<BillingBloc, BillingState>(
        builder: (context, state) {
          if (state.status == BillingStatus.loading) {
            return ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: 4,
              itemBuilder: (_, __) => const Padding(
                padding: EdgeInsets.only(bottom: AppSpacing.md),
                child: ShimmerLoading(width: double.infinity, height: 110),
              ),
            );
          } else if (state.status == BillingStatus.failure) {
            return ErrorStateWidget(
              message: state.errorMessage ?? 'Gagal memuat rincian tagihan.',
              onRetry: () => context.read<BillingBloc>().add(BillingFetchRequested()),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: state.billings.length,
            itemBuilder: (context, index) {
              final item = state.billings[index];
              final isLunas = item.status == 'Lunas';

              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: CustomCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.title,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                              ),
                            ),
                          ),
                          isLunas ? StatusBadge.success('Lunas') : StatusBadge.danger('Belum Lunas'),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        AppFormatters.currency(item.amount),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Jatuh Tempo: ${AppFormatters.date(item.dueDate)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                            ),
                          ),
                          Text(
                            'VA: ${item.virtualAccount}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
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

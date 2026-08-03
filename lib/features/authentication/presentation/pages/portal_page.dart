import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simak_mobile/core/theme/app_colors.dart';
import 'package:simak_mobile/core/theme/app_radius.dart';
import 'package:simak_mobile/core/theme/app_spacing.dart';
import 'package:simak_mobile/features/portal/domain/entities/portal_info_entity.dart';
import 'package:simak_mobile/features/portal/presentation/bloc/portal_bloc.dart';
import 'package:simak_mobile/features/portal/presentation/bloc/portal_event.dart';
import 'package:simak_mobile/features/portal/presentation/bloc/portal_state.dart';
import 'package:simak_mobile/shared/widgets/custom_card.dart';
import 'package:simak_mobile/shared/widgets/error_state_widget.dart';
import 'package:simak_mobile/shared/widgets/shimmer_loading.dart';
import 'package:simak_mobile/shared/widgets/status_badge.dart';

/// Halaman Portal Resmi Universitas Methodist Indonesia (methodist.id)
/// Menampilkan Slider Banner, Role Entrance SIMAK, Sambutan Rektor, Berita UMI (Max 2),
/// Fakultas & Prodi, Lembaga & Unit, E-Journal, Galeri Foto & Video, Lokasi Kampus, & Helpdesk.
/// Sepenuhnya Siap Menerima Response JSON dari Backend API.
class PortalPage extends StatefulWidget {
  const PortalPage({super.key});

  @override
  State<PortalPage> createState() => _PortalPageState();
}

class _PortalPageState extends State<PortalPage> {
  final PageController _bannerPageController = PageController();
  int _currentBannerPage = 0;

  @override
  void initState() {
    super.initState();
    context.read<PortalBloc>().add(PortalFetchRequested());
  }

  @override
  void dispose() {
    _bannerPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<PortalBloc, PortalState>(
          builder: (context, state) {
            if (state.status == PortalStatus.loading) {
              return Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  children: [
                    const ShimmerLoading(width: double.infinity, height: 60),
                    const SizedBox(height: AppSpacing.md),
                    const ShimmerLoading(width: double.infinity, height: 165),
                    const SizedBox(height: AppSpacing.md),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 4,
                        itemBuilder: (_, __) => const Padding(
                          padding: EdgeInsets.only(bottom: AppSpacing.sm),
                          child: ShimmerLoading(width: double.infinity, height: 90),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state.status == PortalStatus.failure) {
              return ErrorStateWidget(
                message: state.errorMessage ?? 'Gagal memuat portal UMI Medan.',
                onRetry: () => context.read<PortalBloc>().add(PortalFetchRequested()),
              );
            }

            final data = state.portalInfo;
            if (data == null) return const SizedBox();

            final displayNews = data.news.take(2).toList();

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── 1. Header Branding Official UMI Medan (methodist.id) ─────────
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(25),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.account_balance_rounded,
                          size: 30,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'UNIVERSITAS METHODIST',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.4,
                                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                StatusBadge.success('UMI Medan'),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Portal Resmi SIMAK & Akademik • methodist.id',
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ).animate().fadeIn(duration: 350.ms),
                  const SizedBox(height: AppSpacing.md),

                  // ── 2. Hero Carousel Slider UMI ──────────────────────────────────
                  SizedBox(
                    height: 165,
                    child: PageView.builder(
                      controller: _bannerPageController,
                      onPageChanged: (idx) {
                        setState(() => _currentBannerPage = idx);
                      },
                      itemCount: data.banners.length,
                      itemBuilder: (context, index) {
                        final banner = data.banners[index];
                        return _UmiBannerCard(banner: banner, data: data);
                      },
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Dot Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      data.banners.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: _currentBannerPage == index ? 20 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: _currentBannerPage == index
                              ? AppColors.primary
                              : (isDark ? Colors.white24 : Colors.black12),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // ── 3. Pintu Masuk SIMAK UMI (Mahasiswa & Dosen) ─────────────────
                  Text(
                    'Login SIMAK UMI Medan',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Akses sistem informasi akademik terpadu bagi Mahasiswa & Dosen UMI.',
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  Row(
                    children: [
                      Expanded(
                        child: _RoleCard(
                          title: 'Portal Mahasiswa',
                          subtitle: 'KRS, KHS, Presensi & Biaya',
                          icon: Icons.person_rounded,
                          color: AppColors.primary,
                          onTap: () => context.push('/login?role=mahasiswa'),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: _RoleCard(
                          title: 'Portal Dosen',
                          subtitle: 'Jadwal & Input Nilai',
                          icon: Icons.school_rounded,
                          color: AppColors.secondary,
                          onTap: () => context.push('/login?role=dosen'),
                        ),
                      ),
                    ],
                  ).animate().slideY(begin: 0.1, end: 0, delay: 150.ms),
                  const SizedBox(height: AppSpacing.lg),

                  // ── 4. Sambutan Rektor & Profil UMI Medan ────────────────────────
                  CustomCard(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundColor: AppColors.primary,
                              child: Icon(Icons.person_outline_rounded, color: Colors.white, size: 22),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kata Sambutan Rektor UMI',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                                    ),
                                  ),
                                  Text(
                                    data.rektorName,
                                    style: const TextStyle(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          '"${data.rektorSambutan}"',
                          style: TextStyle(
                            fontSize: 11,
                            fontStyle: FontStyle.italic,
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // ── 5. Berita & Pengumuman Resmi UMI (Max 2) ─────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Berita & Pengumuman UMI',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                        ),
                      ),
                      InkWell(
                        onTap: () => _showAllNewsModal(context, data.news),
                        borderRadius: AppRadius.radiusXs,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          child: Row(
                            children: [
                              Text(
                                'Lihat Semua',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              SizedBox(width: 2),
                              Icon(Icons.arrow_forward_ios_rounded, size: 10, color: AppColors.primary),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),

                  // Tampilkan Maksimal 2 Berita UMI
                  ...displayNews.map((news) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: CustomCard(
                        onTap: () => _showNewsDetailModal(context, news),
                        padding: const EdgeInsets.all(AppSpacing.sm + 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                StatusBadge.info(news.category),
                                Text(news.date, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              news.title,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              news.summary,
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: AppSpacing.md),

                  // ── 6. Daftar 5 Fakultas UMI Medan ───────────────────────────────
                  Text(
                    'Fakultas & Program Studi (methodist.id)',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),

                  ...data.faculties.map((fac) {
                    final iconData = _getFacultyIcon(fac.iconName);
                    final color = _getFacultyColor(fac.iconName);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                      child: CustomCard(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: color.withAlpha(25),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(iconData, color: color, size: 20),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    fac.name,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                                    ),
                                  ),
                                  Text(
                                    fac.prodi,
                                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: AppSpacing.lg),

                  // ── 7. Lembaga & Unit UMI ─────────────────────────────────────────
                  Text(
                    'Lembaga & Unit UMI Medan',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 1.8,
                    mainAxisSpacing: AppSpacing.xs,
                    crossAxisSpacing: AppSpacing.xs,
                    children: data.units.map((unit) {
                      return CustomCard(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.verified_user_rounded, color: AppColors.primary, size: 20),
                            const SizedBox(height: 4),
                            Text(
                              unit.name,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                              ),
                            ),
                            Text(
                              unit.desc,
                              style: const TextStyle(fontSize: 9, color: Colors.grey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // ── 8. E-Journal Resmi UMI (methodist.id) ───────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'E-Journal & Publikasi UMI',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                        ),
                      ),
                      StatusBadge.info('ejurnal.methodist.ac.id'),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  SizedBox(
                    height: 85,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.eJournals.length,
                      itemBuilder: (context, index) {
                        final j = data.eJournals[index];
                        return Container(
                          width: 170,
                          margin: const EdgeInsets.only(right: AppSpacing.xs),
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                            borderRadius: AppRadius.radiusMd,
                            border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.menu_book_rounded, size: 14, color: AppColors.primary),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      j.name,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                j.field,
                                style: const TextStyle(fontSize: 10, color: Colors.grey),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // ── 9. Galeri Foto & Video UMI Medan ──────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Galeri Foto & Video UMI',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                        ),
                      ),
                      const Text('methodist.id/gallery', style: TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.gallery.length,
                      itemBuilder: (context, index) {
                        final g = data.gallery[index];
                        return Container(
                          width: 160,
                          margin: const EdgeInsets.only(right: AppSpacing.xs),
                          padding: const EdgeInsets.all(AppSpacing.xs),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                            borderRadius: AppRadius.radiusMd,
                            border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 65,
                                decoration: BoxDecoration(
                                  borderRadius: AppRadius.radiusSm,
                                  color: AppColors.primary.withAlpha(30),
                                  image: DecorationImage(
                                    image: NetworkImage(g.imageUrl),
                                    fit: BoxFit.cover,
                                    onError: (_, __) {},
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    g.type == 'video' ? Icons.play_circle_fill_rounded : Icons.photo_library_rounded,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                g.title,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // ── 10. Kalender & Agenda Akademik ────────────────────────────────
                  Text(
                    'Kalender & Agenda Akademik UMI',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  CustomCard(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    child: Column(
                      children: data.agendas.map((event) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withAlpha(20),
                                  borderRadius: AppRadius.radiusSm,
                                ),
                                child: const Icon(Icons.event_rounded, color: AppColors.primary, size: 18),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      event.title,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                                      ),
                                    ),
                                    Text(
                                      event.date,
                                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              StatusBadge.warning(event.status),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // ── 11. Lokasi Kampus I & II UMI Medan ────────────────────────────
                  Text(
                    'Lokasi Kampus UMI Medan',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  ...data.campuses.map((c) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                      child: CustomCard(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withAlpha(25),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.location_on_rounded, color: AppColors.primary, size: 20),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        c.name,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                                        ),
                                      ),
                                      Text(
                                        c.phone,
                                        style: const TextStyle(fontSize: 10, color: AppColors.primary, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${c.address} • ${c.type}',
                                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: AppSpacing.lg),

                  // ── 12. Helpdesk & PMB Online UMI ─────────────────────────────────
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                      borderRadius: AppRadius.radiusLg,
                      border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.headset_mic_rounded, color: AppColors.primary, size: 30),
                        const SizedBox(height: 6),
                        Text(
                          'Pusat Informasi & PMB UMI Medan',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Portal Pendaftaran: pmb.methodist.ac.id | SIMAK: simak.methodist.ac.id',
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _ContactIconButton(
                              icon: Icons.phone_rounded,
                              label: 'Call Center',
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Menghubungi UMI Medan (061) 453-6789...')),
                                );
                              },
                            ),
                            _ContactIconButton(
                              icon: Icons.chat_rounded,
                              label: 'WhatsApp PMB',
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Membuka WhatsApp PMB UMI...')),
                                );
                              },
                            ),
                            _ContactIconButton(
                              icon: Icons.language_rounded,
                              label: 'methodist.id',
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Membuka Portal Resmi methodist.id')),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Footer Copyright
                  Center(
                    child: Column(
                      children: [
                        Text(
                          '© 2026 Universitas Methodist Indonesia (UMI Medan)',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'SIMAK UMI Mobile v1.0.0 • methodist.id',
                          style: TextStyle(
                            fontSize: 10,
                            color: isDark ? AppColors.textHintDark : AppColors.textHintLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showNewsDetailModal(BuildContext context, PortalNewsEntity news) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusLg),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatusBadge.info(news.category),
                  Text(news.date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                news.title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                news.content.isNotEmpty ? news.content : news.summary,
                style: const TextStyle(fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: AppSpacing.lg),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Tutup'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAllNewsModal(BuildContext context, List<PortalNewsEntity> allNews) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: AppRadius.radiusLg.topLeft),
      ),
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.85,
          maxChildSize: 0.95,
          minChildSize: 0.5,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(80),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Berita & Pengumuman UMI Medan (methodist.id)',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: allNews.length,
                      itemBuilder: (context, index) {
                        final news = allNews[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: CustomCard(
                            onTap: () => _showNewsDetailModal(context, news),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    StatusBadge.info(news.category),
                                    Text(news.date, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  news.title,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  news.summary,
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
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  IconData _getFacultyIcon(String name) {
    switch (name) {
      case 'computer': return Icons.computer_rounded;
      case 'payments': return Icons.payments_rounded;
      case 'medical': return Icons.medical_services_rounded;
      case 'grass': return Icons.grass_rounded;
      default: return Icons.translate_rounded;
    }
  }

  Color _getFacultyColor(String name) {
    switch (name) {
      case 'computer': return Colors.blue;
      case 'payments': return Colors.green;
      case 'medical': return Colors.red;
      case 'grass': return Colors.amber;
      default: return Colors.purple;
    }
  }
}

class _UmiBannerCard extends StatelessWidget {
  final BannerItemEntity banner;
  final PortalInfoEntity data;

  const _UmiBannerCard({required this.banner, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: AppSpacing.xs),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryDark, AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppRadius.radiusLg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: AppRadius.radiusXs,
                ),
                child: Text(
                  banner.tag,
                  style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const Icon(Icons.verified_rounded, color: Colors.amberAccent, size: 18),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                banner.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                banner.subtitle,
                style: const TextStyle(fontSize: 11, color: Colors.white70),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _MiniStat(value: data.totalMahasiswa, label: 'Mahasiswa'),
              Container(height: 14, width: 1, color: Colors.white24),
              _MiniStat(value: data.totalDosen, label: 'Dosen'),
              Container(height: 14, width: 1, color: Colors.white24),
              _MiniStat(value: data.totalFakultas, label: 'Fakultas'),
              Container(height: 14, width: 1, color: Colors.white24),
              _MiniStat(value: data.totalProdi, label: 'Prodi'),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String value;
  final String label;

  const _MiniStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
        Text(label, style: const TextStyle(fontSize: 9, color: Colors.white70)),
      ],
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.subtitle,
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
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          borderRadius: AppRadius.radiusMd,
          border: Border.all(
            color: color.withAlpha(100),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withAlpha(30),
                borderRadius: AppRadius.radiusSm,
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ContactIconButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.radiusSm,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 22),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}

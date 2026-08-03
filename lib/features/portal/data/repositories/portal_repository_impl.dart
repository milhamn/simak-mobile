import 'package:simak_mobile/core/env/env_config.dart';
import 'package:simak_mobile/core/network/api_result.dart';
import 'package:simak_mobile/core/network/dio_client.dart';
import 'package:simak_mobile/features/portal/domain/entities/portal_info_entity.dart';
import 'package:simak_mobile/features/portal/domain/repositories/portal_repository.dart';

class PortalRepositoryImpl implements PortalRepository {
  final DioClient dioClient;

  PortalRepositoryImpl(this.dioClient);

  static const PortalInfoEntity _basePortalInfo = PortalInfoEntity(
    totalMahasiswa: '12.500+',
    totalDosen: '450+',
    totalFakultas: '5',
    totalProdi: '14',
    rektorName: 'Drs. Humuntal Rumapea, M.Kom.',
    rektorSambutan:
        'Selamat datang di Universitas Methodist Indonesia (UMI Medan). UMI senantiasa bertekad menyelenggarakan pendidikan tinggi berkualitas prima berlandaskan kasih Kristus dan siap melahirkan lulusan unggul berdaya saing global.',
    visiMisiText:
        'Menjadi Universitas Unggul dalam Pengembangan IPTEKS Berlandaskan Kasih Kristus dan Berdaya Saing Global.',
    sejarahText:
        'Universitas Methodist Indonesia (UMI) didirikan oleh Gereja Methodist Indonesia (GMI) Wilayah 2. Memiliki dua lokasi kampus strategis di Medan (Kampus I Jl. Hang Tuah & Kampus II Jl. Pasar II Tanjung Sari Selayang).',
    banners: [
      BannerItemEntity(
        id: 'b1',
        tag: 'PMB UMI 2026',
        title: 'Penerimaan Mahasiswa Baru T.A. 2026/2027 Resmi Dibuka!',
        subtitle: 'Dapatkan potongan DPP hingga 50% & Beasiswa Methodist Unggul Medan.',
      ),
      BannerItemEntity(
        id: 'b2',
        tag: 'AKREDITASI INSTITUSI',
        title: 'Universitas Methodist Indonesia - Terakreditasi Unggul',
        subtitle: 'Membentuk Generasi Berkarakter, Cerdas, dan Berdaya Saing Global.',
      ),
      BannerItemEntity(
        id: 'b3',
        tag: 'KERJASAMA INTERNASIONAL',
        title: 'Program Exchange & Mikrotik Academy UMI Medan',
        subtitle: 'Sertifikasi Networking & Kerjasama Riset E-Journal Methoda/Methodika.',
      ),
    ],
    news: [
      PortalNewsEntity(
        id: 'n1',
        category: 'PMB UMI 2026',
        title: 'Pendaftaran Mahasiswa Baru UMI Medan T.A. 2026/2027 Gelombang I',
        date: '25 Juli 2026',
        summary: 'Pendaftaran online melalui pmb.methodist.ac.id terbuka untuk seluruh prodi D3, S1, S2, dan Profesi Dokter.',
        content: 'Universitas Methodist Indonesia (UMI) Medan membuka pendaftaran calon mahasiswa baru melalui pmb.methodist.ac.id.',
      ),
      PortalNewsEntity(
        id: 'n2',
        category: 'Pengumuman',
        title: 'Pengisian KRS Online Semester Ganjil 2026/2027 via SIMAK UMI Mobile',
        date: '22 Juli 2026',
        summary: 'Seluruh mahasiswa UMI Medan wajib mengisi KRS secara online mulai 1 Agustus 2026.',
        content: 'Pengisian Kartu Rencana Studi (KRS) diselenggarakan terpusat melalui aplikasi SIMAK UMI Mobile.',
      ),
      PortalNewsEntity(
        id: 'n3',
        category: 'E-Journal & Riset',
        title: 'Publikasi Jurnal Methoda & Methodika Volume 16 Tahun 2026',
        date: '18 Juli 2026',
        summary: 'LPPM UMI menerbitkan artikel ilmiah terbaru terindeks SINTA pada ejurnal.methodist.ac.id.',
        content: 'Lembaga Penelitian dan Pengabdian Masyarakat (LPPM) UMI mengundang para dosen dan peneliti untuk mengirimkan karya ilmiah.',
      ),
      PortalNewsEntity(
        id: 'n4',
        category: 'Prestasi UMI',
        title: 'Fakultas Ilmu Komputer & Kedokteran UMI Raih Penghargaan Ilmiah',
        date: '15 Juli 2026',
        summary: 'Selamat kepada mahasiswa & dosen FIK UMI atas pencapaian riset nasional.',
        content: 'Prestasi membanggakan diraih oleh sivitas akademika Universitas Methodist Indonesia pada ajang kompetisi ilmiah.',
      ),
    ],
    agendas: [
      AcademicAgendaEntity(id: 'a1', date: '01 - 12 Ags 2026', title: 'Pengisian & Verifikasi KRS Online SIMAK UMI', status: 'Mendatang'),
      AcademicAgendaEntity(id: 'a2', date: '18 Ags 2026', title: 'Kuliah Perdana Semester Ganjil T.A. 2026/2027', status: 'Penting'),
      AcademicAgendaEntity(id: 'a3', date: '05 - 12 Okt 2026', title: 'Ujian Tengah Semester (UTS) Ganjil', status: 'Jadwal'),
      AcademicAgendaEntity(id: 'a4', date: '15 Des 2026', title: 'Wisuda Sarjana & Magister UMI Periode II', status: 'Wisuda'),
    ],
    faculties: [
      FacultyEntity(name: 'Fakultas Ilmu Komputer (FIK)', prodi: 'S1 Teknik Informatika, S1 Sistem Informasi, S1 Pendidikan TI, D3 Manajemen Informatika, D3 Komputerisasi Akuntansi', iconName: 'computer'),
      FacultyEntity(name: 'Fakultas Ekonomi (FE)', prodi: 'S1 Manajemen, S1 Akuntansi, S2 Ilmu Manajemen', iconName: 'payments'),
      FacultyEntity(name: 'Fakultas Kedokteran (FK)', prodi: 'S1 Pendidikan Dokter, Profesi Dokter, S2 Ilmu Biomedik', iconName: 'medical'),
      FacultyEntity(name: 'Fakultas Sastra (FS)', prodi: 'S1 Sastra Inggris', iconName: 'translate'),
      FacultyEntity(name: 'Fakultas Pertanian (FP)', prodi: 'S1 Agribisnis, S1 Agroteknologi', iconName: 'grass'),
    ],
    facilities: [
      FacilityEntity(title: 'Perpustakaan & Repository', desc: 'repository.methodist.ac.id & E-Book', iconName: 'library'),
      FacilityEntity(title: 'Mikrotik Academy & Lab FIK', desc: 'Sertifikasi Networking & AI Lab', iconName: 'chip'),
      FacilityEntity(title: 'LPPM & Pusat Sistem Informasi', desc: 'Lembaga Penelitian & Jurnal SINTA', iconName: 'sports'),
      FacilityEntity(title: 'LPM & Penjaminan Mutu', desc: 'Standardisasi Mutu Pendidikan UMI', iconName: 'wifi'),
    ],
    eJournals: [
      EJournalEntity(name: 'Jurnal Methoda', field: 'Informatika & Komputer (SINTA)', url: 'https://ejurnal.methodist.ac.id/index.php/methoda'),
      EJournalEntity(name: 'Jurnal Methodika', field: 'Teknologi Informasi & Riset', url: 'https://ejurnal.methodist.ac.id/index.php/methodika'),
      EJournalEntity(name: 'Jurnal Methonomi', field: 'Ekonomi & Manajemen UMI', url: 'http://methonomi.net'),
      EJournalEntity(name: 'Jurnal MethodAgro', field: 'Pertanian & Agribisnis', url: 'https://ejurnal.methodist.ac.id/index.php/methodagro'),
      EJournalEntity(name: 'Jurnal MethoLangue', field: 'Sastra & Bahasa Inggris', url: 'https://ejurnal.methodist.ac.id/index.php/metholangue'),
      EJournalEntity(name: 'Jurnal Kedokteran (JKM)', field: 'Kedokteran & Biomedik', url: 'https://ejurnal.methodist.ac.id/index.php/jkm'),
      EJournalEntity(name: 'Jurnal Methabdi', field: 'Pengabdian Masyarakat LPPM', url: 'https://ejurnal.methodist.ac.id/index.php/methabdi'),
      EJournalEntity(name: 'Jurnal Methosika', field: 'Sistem Informasi & Rekayasa', url: 'http://methosika.net'),
    ],
    campuses: [
      CampusAddressEntity(
        name: 'Kampus I UMI Medan',
        address: 'Jl. Hang Tuah No. 8, Medan 20152, Sumatera Utara',
        phone: '(061) 4536789',
        type: 'Gedung Rektorat & FK',
      ),
      CampusAddressEntity(
        name: 'Kampus II UMI Medan',
        address: 'Jl. Pasar II Tanjung Sari, Medan Selayang 20132',
        phone: '(061) 8212175',
        type: 'Kampus Utama, Lab & Student Center',
      ),
    ],
    gallery: [
      GalleryItemEntity(
        id: 'g1',
        title: 'Wisuda Sarjana & Magister UMI Medan Periode 2026',
        type: 'photo',
        imageUrl: 'https://picsum.photos/400/250?random=1',
        date: '20 Juli 2026',
      ),
      GalleryItemEntity(
        id: 'g2',
        title: 'Kuliah Umum & MoU Kerjasama Internasional UMI',
        type: 'photo',
        imageUrl: 'https://picsum.photos/400/250?random=2',
        date: '15 Juli 2026',
      ),
      GalleryItemEntity(
        id: 'g3',
        title: 'Praktikum Laboratorium Kedokteran & FIK UMI',
        type: 'photo',
        imageUrl: 'https://picsum.photos/400/250?random=3',
        date: '10 Juli 2026',
      ),
      GalleryItemEntity(
        id: 'g4',
        title: 'Video Profil Universitas Methodist Indonesia',
        type: 'video',
        imageUrl: 'https://picsum.photos/400/250?random=4',
        date: '01 Juli 2026',
      ),
    ],
    units: [
      UmiUnitEntity(name: 'LPPM UMI', desc: 'Lembaga Penelitian & Pengabdian Masyarakat', iconName: 'science'),
      UmiUnitEntity(name: 'Pusat Sistem Informasi (PSI)', desc: 'Pengelola Infrastruktur IT & SIMAK UMI', iconName: 'laptop'),
      UmiUnitEntity(name: 'LPM Penjamin Mutu', desc: 'Lembaga Penjaminan Mutu Akademik Internal', iconName: 'verified'),
      UmiUnitEntity(name: 'Mikrotik Academy UMI', desc: 'Pusat Sertifikasi Jaringan Komputer Internasional', iconName: 'router'),
      UmiUnitEntity(name: 'Repository UMI', desc: 'repository.methodist.ac.id (Karya Ilmiah)', iconName: 'folder_zip'),
      UmiUnitEntity(name: 'Survey Kepuasan UMI', desc: 'Layanan Evaluasi Kepuasan Akademik & Mutu', iconName: 'poll'),
    ],
  );

  @override
  Future<ApiResult<PortalInfoEntity>> getPortalInfo() async {
    if (EnvConfig.useDummy) {
      await Future.delayed(const Duration(milliseconds: 300));
      return const ApiSuccess(_basePortalInfo);
    }

    try {
      final response = await dioClient.dio.get('/portal/news', queryParameters: {'page': 1, 'limit': 4});
      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data'] as Map<String, dynamic>;
        final items = data['items'] as List<dynamic>? ?? [];

        if (items.isNotEmpty) {
          final newsList = items.map((item) {
            final m = item as Map<String, dynamic>;
            return PortalNewsEntity(
              id: m['id']?.toString() ?? '',
              category: m['category']?.toString() ?? 'Berita UMI',
              title: m['title']?.toString() ?? '',
              date: m['published_at']?.toString() ?? 'Hari ini',
              summary: m['summary']?.toString() ?? '',
              content: m['content']?.toString() ?? '',
            );
          }).toList();

          return ApiSuccess(_basePortalInfo.copyWith(news: newsList));
        }
      }
      return const ApiSuccess(_basePortalInfo);
    } catch (_) {
      // Fallback graceful ke data portal jika offline atau backend belum load berita
      return const ApiSuccess(_basePortalInfo);
    }
  }
}

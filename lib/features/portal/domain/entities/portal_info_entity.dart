import 'package:equatable/equatable.dart';

class BannerItemEntity extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String tag;
  final String imageUrl;

  const BannerItemEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.tag,
    this.imageUrl = '',
  });

  factory BannerItemEntity.fromMap(Map<String, dynamic> map) {
    return BannerItemEntity(
      id: map['id']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      subtitle: map['subtitle']?.toString() ?? '',
      tag: map['tag']?.toString() ?? 'PMB UMI',
      imageUrl: map['image_url']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'tag': tag,
      'image_url': imageUrl,
    };
  }

  @override
  List<Object?> get props => [id, title, subtitle, tag, imageUrl];
}

class PortalNewsEntity extends Equatable {
  final String id;
  final String category;
  final String title;
  final String date;
  final String summary;
  final String content;
  final String linkUrl;

  const PortalNewsEntity({
    required this.id,
    required this.category,
    required this.title,
    required this.date,
    required this.summary,
    this.content = '',
    this.linkUrl = '',
  });

  factory PortalNewsEntity.fromMap(Map<String, dynamic> map) {
    return PortalNewsEntity(
      id: map['id']?.toString() ?? '',
      category: map['category']?.toString() ?? 'Berita',
      title: map['title']?.toString() ?? '',
      date: map['date']?.toString() ?? '',
      summary: map['summary']?.toString() ?? '',
      content: map['content']?.toString() ?? '',
      linkUrl: map['link_url']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'title': title,
      'date': date,
      'summary': summary,
      'content': content,
      'link_url': linkUrl,
    };
  }

  @override
  List<Object?> get props => [id, category, title, date, summary, content, linkUrl];
}

class AcademicAgendaEntity extends Equatable {
  final String id;
  final String date;
  final String title;
  final String status;

  const AcademicAgendaEntity({
    required this.id,
    required this.date,
    required this.title,
    required this.status,
  });

  factory AcademicAgendaEntity.fromMap(Map<String, dynamic> map) {
    return AcademicAgendaEntity(
      id: map['id']?.toString() ?? '',
      date: map['date']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      status: map['status']?.toString() ?? 'Agenda',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'title': title,
      'status': status,
    };
  }

  @override
  List<Object?> get props => [id, date, title, status];
}

class FacultyEntity extends Equatable {
  final String name;
  final String prodi;
  final String iconName;

  const FacultyEntity({
    required this.name,
    required this.prodi,
    required this.iconName,
  });

  factory FacultyEntity.fromMap(Map<String, dynamic> map) {
    return FacultyEntity(
      name: map['name']?.toString() ?? '',
      prodi: map['prodi']?.toString() ?? '',
      iconName: map['icon_name']?.toString() ?? 'computer',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'prodi': prodi,
      'icon_name': iconName,
    };
  }

  @override
  List<Object?> get props => [name, prodi, iconName];
}

class FacilityEntity extends Equatable {
  final String title;
  final String desc;
  final String iconName;

  const FacilityEntity({
    required this.title,
    required this.desc,
    required this.iconName,
  });

  factory FacilityEntity.fromMap(Map<String, dynamic> map) {
    return FacilityEntity(
      title: map['title']?.toString() ?? '',
      desc: map['desc']?.toString() ?? '',
      iconName: map['icon_name']?.toString() ?? 'wifi',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'desc': desc,
      'icon_name': iconName,
    };
  }

  @override
  List<Object?> get props => [title, desc, iconName];
}

class EJournalEntity extends Equatable {
  final String name;
  final String field;
  final String url;

  const EJournalEntity({
    required this.name,
    required this.field,
    required this.url,
  });

  factory EJournalEntity.fromMap(Map<String, dynamic> map) {
    return EJournalEntity(
      name: map['name']?.toString() ?? '',
      field: map['field']?.toString() ?? '',
      url: map['url']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'field': field,
      'url': url,
    };
  }

  @override
  List<Object?> get props => [name, field, url];
}

class CampusAddressEntity extends Equatable {
  final String name;
  final String address;
  final String phone;
  final String type;

  const CampusAddressEntity({
    required this.name,
    required this.address,
    required this.phone,
    required this.type,
  });

  factory CampusAddressEntity.fromMap(Map<String, dynamic> map) {
    return CampusAddressEntity(
      name: map['name']?.toString() ?? '',
      address: map['address']?.toString() ?? '',
      phone: map['phone']?.toString() ?? '',
      type: map['type']?.toString() ?? 'Kampus',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'phone': phone,
      'type': type,
    };
  }

  @override
  List<Object?> get props => [name, address, phone, type];
}

class GalleryItemEntity extends Equatable {
  final String id;
  final String title;
  final String type; // 'photo' atau 'video'
  final String imageUrl;
  final String date;

  const GalleryItemEntity({
    required this.id,
    required this.title,
    required this.type,
    required this.imageUrl,
    required this.date,
  });

  factory GalleryItemEntity.fromMap(Map<String, dynamic> map) {
    return GalleryItemEntity(
      id: map['id']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      type: map['type']?.toString() ?? 'photo',
      imageUrl: map['image_url']?.toString() ?? '',
      date: map['date']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'image_url': imageUrl,
      'date': date,
    };
  }

  @override
  List<Object?> get props => [id, title, type, imageUrl, date];
}

class UmiUnitEntity extends Equatable {
  final String name;
  final String desc;
  final String iconName;

  const UmiUnitEntity({
    required this.name,
    required this.desc,
    required this.iconName,
  });

  factory UmiUnitEntity.fromMap(Map<String, dynamic> map) {
    return UmiUnitEntity(
      name: map['name']?.toString() ?? '',
      desc: map['desc']?.toString() ?? '',
      iconName: map['icon_name']?.toString() ?? 'account_balance',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'desc': desc,
      'icon_name': iconName,
    };
  }

  @override
  List<Object?> get props => [name, desc, iconName];
}

class PortalInfoEntity extends Equatable {
  final List<BannerItemEntity> banners;
  final List<PortalNewsEntity> news;
  final List<AcademicAgendaEntity> agendas;
  final List<FacultyEntity> faculties;
  final List<FacilityEntity> facilities;
  final List<EJournalEntity> eJournals;
  final List<CampusAddressEntity> campuses;
  final List<GalleryItemEntity> gallery;
  final List<UmiUnitEntity> units;
  final String totalMahasiswa;
  final String totalDosen;
  final String totalFakultas;
  final String totalProdi;
  final String rektorName;
  final String rektorSambutan;
  final String visiMisiText;
  final String sejarahText;

  const PortalInfoEntity({
    required this.banners,
    required this.news,
    required this.agendas,
    required this.faculties,
    required this.facilities,
    required this.eJournals,
    required this.campuses,
    required this.gallery,
    required this.units,
    required this.totalMahasiswa,
    required this.totalDosen,
    required this.totalFakultas,
    required this.totalProdi,
    this.rektorName = 'Drs. Humuntal Rumapea, M.Kom.',
    this.rektorSambutan = 'Selamat datang di Universitas Methodist Indonesia. Kami berkomitmen menyelenggarakan pendidikan tinggi berkualitas tinggi berbasis kasih Kristus dan berorientasi teknologi global.',
    this.visiMisiText = 'Menjadi Universitas Unggul dalam Pengembangan IPTEKS Berlandaskan Kasih Kristus dan Berdaya Saing Global.',
    this.sejarahText = 'Universitas Methodist Indonesia (UMI) didirikan oleh Gereja Methodist Indonesia (GMI) Wilayah 2 sebagai perguruan tinggi terkemuka di Medan, Sumatera Utara.',
  });

  factory PortalInfoEntity.fromMap(Map<String, dynamic> map) {
    return PortalInfoEntity(
      totalMahasiswa: map['total_mahasiswa']?.toString() ?? '12.500+',
      totalDosen: map['total_dosen']?.toString() ?? '450+',
      totalFakultas: map['total_fakultas']?.toString() ?? '5',
      totalProdi: map['total_prodi']?.toString() ?? '14',
      rektorName: map['rektor_name']?.toString() ?? 'Drs. Humuntal Rumapea, M.Kom.',
      rektorSambutan: map['rektor_sambutan']?.toString() ?? 'Selamat datang di Universitas Methodist Indonesia.',
      visiMisiText: map['visi_misi']?.toString() ?? 'Menjadi Universitas Unggul Berlandaskan Kasih Kristus.',
      sejarahText: map['sejarah']?.toString() ?? 'Universitas Methodist Indonesia didirikan oleh Gereja Methodist Indonesia.',
      banners: (map['banners'] as List<dynamic>?)
              ?.map((e) => BannerItemEntity.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
      news: (map['news'] as List<dynamic>?)
              ?.map((e) => PortalNewsEntity.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
      agendas: (map['agendas'] as List<dynamic>?)
              ?.map((e) => AcademicAgendaEntity.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
      faculties: (map['faculties'] as List<dynamic>?)
              ?.map((e) => FacultyEntity.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
      facilities: (map['facilities'] as List<dynamic>?)
              ?.map((e) => FacilityEntity.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
      eJournals: (map['e_journals'] as List<dynamic>?)
              ?.map((e) => EJournalEntity.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
      campuses: (map['campuses'] as List<dynamic>?)
              ?.map((e) => CampusAddressEntity.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
      gallery: (map['gallery'] as List<dynamic>?)
              ?.map((e) => GalleryItemEntity.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
      units: (map['units'] as List<dynamic>?)
              ?.map((e) => UmiUnitEntity.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'total_mahasiswa': totalMahasiswa,
      'total_dosen': totalDosen,
      'total_fakultas': totalFakultas,
      'total_prodi': totalProdi,
      'rektor_name': rektorName,
      'rektor_sambutan': rektorSambutan,
      'visi_misi': visiMisiText,
      'sejarah': sejarahText,
      'banners': banners.map((e) => e.toMap()).toList(),
      'news': news.map((e) => e.toMap()).toList(),
      'agendas': agendas.map((e) => e.toMap()).toList(),
      'faculties': faculties.map((e) => e.toMap()).toList(),
      'facilities': facilities.map((e) => e.toMap()).toList(),
      'e_journals': eJournals.map((e) => e.toMap()).toList(),
      'campuses': campuses.map((e) => e.toMap()).toList(),
      'gallery': gallery.map((e) => e.toMap()).toList(),
      'units': units.map((e) => e.toMap()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        banners,
        news,
        agendas,
        faculties,
        facilities,
        eJournals,
        campuses,
        gallery,
        units,
        totalMahasiswa,
        totalDosen,
        totalFakultas,
        totalProdi,
        rektorName,
        rektorSambutan,
        visiMisiText,
        sejarahText,
      ];
}

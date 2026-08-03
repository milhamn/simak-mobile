import 'package:equatable/equatable.dart';

class AnnouncementEntity extends Equatable {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final String category; // 'Akademik', 'Keuangan', 'Umum'

  const AnnouncementEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.category,
  });

  @override
  List<Object?> get props => [id, title, content, date, category];
}

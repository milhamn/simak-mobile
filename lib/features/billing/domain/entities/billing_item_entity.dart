import 'package:equatable/equatable.dart';

class BillingItemEntity extends Equatable {
  final String id;
  final String title;
  final num amount;
  final DateTime dueDate;
  final String status; // 'Lunas' or 'Belum Lunas'
  final String virtualAccount;

  const BillingItemEntity({
    required this.id,
    required this.title,
    required this.amount,
    required this.dueDate,
    required this.status,
    required this.virtualAccount,
  });

  @override
  List<Object?> get props => [id, title, amount, dueDate, status, virtualAccount];
}

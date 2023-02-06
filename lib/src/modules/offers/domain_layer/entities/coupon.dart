import 'package:equatable/equatable.dart';

class Coupon extends Equatable {
  String text;
  int discount;
  DateTime date;
  Coupon({required this.text, required this.discount, required this.date});
  @override
  List<Object?> get props => [text, discount, date];
}

import 'package:equatable/equatable.dart';

class Coupon extends Equatable {
  String text;
  double discount;
  Coupon({required this.text, required this.discount});
  @override
  List<Object?> get props => [text, discount];
}

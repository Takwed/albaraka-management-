import 'package:equatable/equatable.dart';

class Product extends Equatable {
  String? image;
  final String name;
  final String describe;
  final int price;
   Product(
      { this.image,
      required this.name,
      required this.describe,
      required this.price});

  @override
  List<Object?> get props => [image, name, describe, price];
}

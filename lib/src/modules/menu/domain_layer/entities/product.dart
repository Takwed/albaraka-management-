import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String? image;
  final String name;
  final String describe;
  final int price;

  const Product(
      {required this.image,
      required this.name,
      required this.describe,
      required this.price});

  @override
  List<Object?> get props => [image, name, describe, price];
}

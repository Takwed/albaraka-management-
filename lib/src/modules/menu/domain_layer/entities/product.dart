import 'package:equatable/equatable.dart';

class Product extends Equatable {
  String? image;
  final String name;
  final String describe;
  final double oldPrice;
  final double newPrice;
   Product(
      { this.image,
      required this.name,
      required this.describe,
      required this.newPrice,
      required this.oldPrice});

  @override
  List<Object?> get props => [image, name, describe,newPrice, oldPrice];
}

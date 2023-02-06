import 'dart:io';

import 'package:equatable/equatable.dart';

class Product extends Equatable {
  String? image;
  final String name;
  String? imagePaths;
  final String describe;
  double oldPrice;
  final double points;
  double newPrice;
  String? offerState;
  String? offerDetails;
  int? quantity;
  Product(
      {this.image,
      required this.name,
      required this.imagePaths,
      required this.describe,
      required this.newPrice,
      required this.points,
      required this.oldPrice,
      this.offerState,
      this.offerDetails,
      this.quantity});

  @override
  List<Object?> get props =>
      [image, name, imagePaths, describe, newPrice, points, oldPrice];
}

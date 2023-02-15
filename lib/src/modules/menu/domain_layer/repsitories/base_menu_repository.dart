import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import '../../data_layer/models/product_model.dart';

abstract class BaseMenuRepository {
  Future<Either<Exception, File>?> addImagePicker(source, context);
  Future<Either<Exception, void>> addProduct({
    required String name,
    required String describe,
    required double oldPrice,
    required double newPrice,
    required double points,
    required int collectionIndex,
  });
  Future<Either<Exception, List<ProductModel>>> getKoshary();
  Future<Either<Exception, List<ProductModel>>> getMashweyat();
  Future<Either<Exception, List<ProductModel>>> getHalaweyat();
  Future<Either<Exception, void>> editProduct({
    required int id,
    required String name,
    required String describe,
    required int collectionIndex,
    required double oldPrice,
    required double points,
    required double newPrice,
    String? offerDetails,
    String? offerState,
    int? quantity,
  });
  Future<Either<Exception, bool>> deleteProducts(List<int> ids,int collectionIndex);
}

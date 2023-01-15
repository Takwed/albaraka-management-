import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import '../../data_layer/models/product_model.dart';

abstract class BaseMenuRepository {
  Future<Either<Exception, File>> addImagePicker(source,context);
  Future<Either<Exception, void>> addProductToJson({required String name,
    required String describe,
    required int price,});
  Future<Either<Exception,  List<ProductModel>>> getProducts();
  Future<Either<Exception,  bool>> deleteProducts(List<int> ids);

}
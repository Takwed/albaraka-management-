import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

import '../../data_layer/models/product_model.dart';

abstract class BaseMenuRepository {
  Future<Either<FirebaseAuthException, File>> addImagePicker(source,context);
  Future<Either<FirebaseAuthException, void>> addProductToJson({required String name,
    required String describe,
    required int price,});
  Future<Either<FirebaseAuthException,  List<ProductModel>>> getProducts();

}
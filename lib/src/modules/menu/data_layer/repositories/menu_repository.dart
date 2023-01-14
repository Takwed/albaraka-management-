import 'package:albaraka_management/src/modules/menu/data_layer/data_sources/menu_remote_data_source.dart';
import 'package:albaraka_management/src/modules/menu/domain_layer/repsitories/base_menu_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth_platform_interface/src/firebase_auth_exception.dart';
import 'dart:io';

import '../models/product_model.dart';

class MenuRepository extends BaseMenuRepository{
  final BaseMenuRemoteDataSource baseMenuRemoteDataSource;
  MenuRepository(this.baseMenuRemoteDataSource);

  @override
  Future<Either<FirebaseAuthException, File>> addImagePicker(source,context) async{
   return await baseMenuRemoteDataSource.addImagePicker(source,context);
  }
  @override
  Future<Either<FirebaseAuthException, void>> addProductToJson({
    required String name,
    required String describe,
    required int price,}) async{
    return await baseMenuRemoteDataSource.addProductToJson(name: name,describe: describe,price: price);
  }

  @override
  Future<Either<FirebaseAuthException,  List<ProductModel>>> getProducts()async {
    return await baseMenuRemoteDataSource.getProducts();
  }

}
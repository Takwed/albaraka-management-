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
  Future<Either<Exception, File>> addImagePicker(source,context) async{
   return await baseMenuRemoteDataSource.addImagePicker(source,context);
  }
  @override
  Future<Either<Exception, void>> addProduct({
    required String name,
    required String describe,
    required double oldPrice,
    required double newPrice,}) async{
    return await baseMenuRemoteDataSource.addProduct(name: name,describe: describe,oldPrice: oldPrice,newPrice: newPrice);
  }

  @override
  Future<Either<Exception,  List<ProductModel>>> getProducts()async {
    return await baseMenuRemoteDataSource.getProducts();
  }

  @override
  Future<Either<Exception, bool>> deleteProducts(List<int> ids) async{
    return await baseMenuRemoteDataSource.deleteProducts(ids);
  }

  @override
  Future<Either<Exception, void>> editProduct({required int id,
    required String name,
    required String describe,
    required double oldPrice,
    required double newPrice,}) async{
    return await baseMenuRemoteDataSource.editProduct(id: id,name: name,describe: describe,oldPrice: oldPrice,newPrice: newPrice);
  }

}
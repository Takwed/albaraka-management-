import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../models/product_model.dart';

abstract class BaseMenuRemoteDataSource {
  Future<Either<FirebaseAuthException, File>> addImagePicker(source,context);
  Future<Either<FirebaseAuthException, String>> uploadProductImage();
  Future<Either<FirebaseAuthException, void>> addProductToJson({required String name,
    required String describe,
    required int price,});
  Future<Either<FirebaseAuthException,  List<ProductModel>>> getProducts();


}
class MenuRemoteDataSource extends BaseMenuRemoteDataSource{
  File? imageFiled;
  String? uploadImage;
  @override
  Future<Either<FirebaseAuthException, File>> addImagePicker(source,context) async {
    try{
      final image = await ImagePicker().pickImage(source: source);
      if(image != null) {
        imageFiled = File(image.path);
      }
      return Right(imageFiled!);
    }on FirebaseAuthException catch(error) {
      print('Failed to pick image: $error');
      return Left(error);
    }
  }
  @override
  Future<Either<FirebaseAuthException, String>> uploadProductImage() async
  {
    try {
      Reference ref = firebase_storage.FirebaseStorage.instance.ref()
          .child('products/${Uri.file(imageFiled!.path).pathSegments.last}');
      await ref.putFile(imageFiled!);
      await ref.getDownloadURL().then((value) async {
        uploadImage = value;
         print(value);
      });
      return Right(uploadImage!);
    }on FirebaseAuthException catch(error) {
      print('Failed to pick image: $error');
      return Left(error);
    }
  }

  @override
  Future<Either<FirebaseAuthException, void>> addProductToJson({
    required String name,
    required String describe,
    required int price,})async {
   try{
     await uploadProductImage();
     ProductModel productModel = ProductModel(
       name: name,
       image: uploadImage!,
       describe: describe,
       price: price,
     );
     await FirebaseFirestore.instance
         .collection("products").doc().set(productModel.toJson()).then((value) {});
     return const Right('true');
   }on FirebaseAuthException catch(error) {
     return Left(error);
   }
  }

  @override
  Future<Either<FirebaseAuthException, List<ProductModel>>> getProducts() async{
    List<ProductModel> products = [];
    try {
     await FirebaseFirestore.instance
         .collection("products").get().then((value) {
       value.docs.forEach((element) {
         products.add(ProductModel.fromJson(element.data()));
       });
     });
     return Right(products);
   }on FirebaseAuthException catch(error) {
     return Left(error);
   }
  }
}
import 'dart:io';
import 'package:albaraka_management/src/modules/menu/data_layer/models/product_model.dart';
import 'package:albaraka_management/src/modules/menu/presentation_layer/screens/menu_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

abstract class BaseMenuRemoteDataSource {
  Future<Either<Exception, File>?> addImagePicker(source, context);
  Future<Either<Exception, String>> uploadProductImage(
    int collectionIndex,
  );
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
  Future<Either<Exception, bool>> deleteProducts(
      List<int> ids, int collectionIndex);
  Future<Either<Exception, void>> editProduct({
    required int id,
    required String name,
    required String describe,
    required double oldPrice,
    required double points,
    required double newPrice,
    required int collectionIndex,
  });
}

class MenuRemoteDataSource extends BaseMenuRemoteDataSource {
  File? imageFiled;
  String? uploadImage;
  String? imagePaths;
  @override
  Future<Either<Exception, File>?> addImagePicker(source, context) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return null;
      } else {
        imageFiled = File(image.path);
        return Right(imageFiled!);
      }
    } on Exception catch (error) {
      print('Failed to pick image: $error');
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> uploadProductImage(
      int collectionIndex) async {
    try {
      Reference ref;
      if (collectionIndex == 0) {
        ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('koshary/${Uri.file(imageFiled!.path).pathSegments.last}');
        await ref.putFile(imageFiled!);
        await ref.getDownloadURL().then((value) async {
          uploadImage = value;
          imagePaths = imageFiled!.path;
        });
      }
      else if (collectionIndex == 1) {
        ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('mashweyat/${Uri.file(imageFiled!.path).pathSegments.last}');
        await ref.putFile(imageFiled!);
        await ref.getDownloadURL().then((value) async {
          uploadImage = value;
          imagePaths = imageFiled!.path;
        });
      }
      else if (collectionIndex == 2) {
        ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('halaweyat/${Uri.file(imageFiled!.path).pathSegments.last}');
        await ref.putFile(imageFiled!);
        await ref.getDownloadURL().then((value) async {
          uploadImage = value;
          imagePaths = imageFiled!.path;
        });
      }
      return Right(uploadImage!);
    } on Exception catch (error) {
      print('Failed to pick image: $error');
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, void>> addProduct({
    required String name,
    required String describe,
    required double oldPrice,
    required double points,
    required int collectionIndex,
    required double newPrice,
  }) async {
    try {
      if (imageFiled != null) {
        await uploadProductImage(collectionIndex);
      } else {
        uploadImage = '';
        imagePaths = '';
      }
      ProductModel productModel = ProductModel(
        points: points,
        imagePaths:  imageFiled != null ? imagePaths : '',
        newPrice: newPrice,
        name: name,
        image: imageFiled != null ? uploadImage : '',
        describe: describe,
        oldPrice: oldPrice,
      );
      if (collectionIndex == 0) {
        await FirebaseFirestore.instance
            .collection("koshary")
            .doc()
            .set(productModel.toJson());
      } else if (collectionIndex == 1) {
        await FirebaseFirestore.instance
            .collection("mashweyat")
            .doc()
            .set(productModel.toJson());
      } else if (collectionIndex == 2) {
        await FirebaseFirestore.instance
            .collection("halaweyat")
            .doc()
            .set(productModel.toJson());
      }
      imageFiled = null;
      return const Right('true');
    } on Exception catch (error) {
      return Left(error);
    }
  }

  List<String> kosharyId = [];
  List<ProductModel> koshary = [];
  List<String> mashweyatId = [];
  List<ProductModel> mashweyat = [];
  List<String> halaweyatId = [];
  List<ProductModel> halaweyat = [];

  @override
  Future<Either<Exception, List<ProductModel>>> getKoshary() async {
    kosharyId = [];
    koshary = [];
    try {
      await FirebaseFirestore.instance
          .collection("koshary")
          .get()
          .then((value) {
        value.docs.forEach((element) {
          koshary.add(ProductModel.fromJson(element.data()));
          kosharyId.add(element.id);
        });
      });

      return Right(koshary);
    } on Exception catch (error) {
      return Left(error);
    }
  }

  Future<Either<Exception, List<ProductModel>>> getMashweyat() async {
    mashweyatId = [];
    mashweyat = [];
    try {
      await FirebaseFirestore.instance
          .collection("mashweyat")
          .get()
          .then((value) {
        value.docs.forEach((element) {
          mashweyat.add(ProductModel.fromJson(element.data()));
          mashweyatId.add(element.id);
        });
      });

      return Right(mashweyat);
    } on Exception catch (error) {
      return Left(error);
    }
  }

  Future<Either<Exception, List<ProductModel>>> getHalaweyat() async {
    halaweyatId = [];
    halaweyat = [];
    try {
      await FirebaseFirestore.instance
          .collection("halaweyat")
          .get()
          .then((value) {
        value.docs.forEach((element) {
          halaweyat.add(ProductModel.fromJson(element.data()));
          halaweyatId.add(element.id);
        });
      });

      return Right(halaweyat);
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, bool>> deleteProducts(
      List<int> ids, int collectionIndex) async {
    try {
      CollectionReference<Map<String, dynamic>> collection;
      if (collectionIndex == 0) {
        collection = FirebaseFirestore.instance.collection("koshary");
        ids.forEach((id) async{
          collection.doc(kosharyId[id]).delete();
          if(koshary[id].image != '') {
            await firebase_storage.FirebaseStorage.instance.ref()
                .child('koshary/${Uri
                .file(koshary[id].imagePaths!)
                .pathSegments
                .last}').delete();
          }
        });
      }
      else if (collectionIndex == 1) {
        collection = FirebaseFirestore.instance.collection("mashweyat");
        ids.forEach((id) async{
          collection.doc(mashweyatId[id]).delete();
          if(mashweyat[id].image != '') {
            await firebase_storage.FirebaseStorage.instance.ref()
                .child('mashweyat/${Uri
                .file(mashweyat[id].imagePaths!)
                .pathSegments
                .last}').delete();
          }});
      }
      else if (collectionIndex == 2) {
        collection = FirebaseFirestore.instance.collection("halaweyat");
        ids.forEach((id)async {
          collection.doc(halaweyatId[id]).delete();
          if(halaweyat[id].image != '') {
            await firebase_storage.FirebaseStorage.instance.ref()
                .child('halaweyat/${Uri
                .file(halaweyat[id].imagePaths!)
                .pathSegments
                .last}').delete();
          }});
      }
      return const Right(true);
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, void>> editProduct({
    required int id,
    required String name,
    required String describe,
    required int collectionIndex,
    required double oldPrice,
    required double points,
    required double newPrice,
  }) async {
    try {
      if (imageFiled != null) {
        await uploadProductImage(collectionIndex);
      }

      if (collectionIndex == 0) {
        ProductModel productUpdate = ProductModel(
          points: points,
          imagePaths:  imageFiled != null ? imagePaths : '',
          newPrice: newPrice,
          name: name,
          image: uploadImage ?? koshary[id].image,
          describe: describe,
          oldPrice: oldPrice,
        );
        if(koshary[id].image != '') {
          await firebase_storage.FirebaseStorage.instance.ref()
              .child('koshary/${Uri
              .file(koshary[id].imagePaths!)
              .pathSegments
              .last}').delete();
        }
        FirebaseFirestore.instance
            .collection("koshary")
            .doc(kosharyId[id])
            .update(productUpdate.toJson());
      }
      else if (collectionIndex == 1) {
        ProductModel productUpdate = ProductModel(
          newPrice: newPrice,
          points: points,
          name: name,
          image: uploadImage ?? mashweyat[id].image,
          describe: describe,
          oldPrice: oldPrice,
        );
        if(mashweyat[id].image != '') {
          await firebase_storage.FirebaseStorage.instance.ref()
              .child('mashweyat/${Uri
              .file(mashweyat[id].imagePaths!)
              .pathSegments
              .last}').delete();
        }
        FirebaseFirestore.instance
            .collection("mashweyat")
            .doc(mashweyatId[id])
            .update(productUpdate.toJson());
      }
      else if (collectionIndex == 2) {
        ProductModel productUpdate = ProductModel(
          newPrice: newPrice,
          points: points,
          name: name,
          image: uploadImage ?? halaweyat[id].image,
          describe: describe,
          oldPrice: oldPrice,
        );
        if(halaweyat[id].image != '') {
          await firebase_storage.FirebaseStorage.instance.ref()
              .child('halaweyat/${Uri
              .file(halaweyat[id].imagePaths!)
              .pathSegments
              .last}').delete();
        }
        FirebaseFirestore.instance
            .collection("halaweyat")
            .doc(halaweyatId[id])
            .update(productUpdate.toJson());
      }
      return Right(true);
    } on Exception catch (error) {
      return Left(error);
    }
  }
}

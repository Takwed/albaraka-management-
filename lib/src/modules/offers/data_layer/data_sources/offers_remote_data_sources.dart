import 'package:albaraka_management/src/modules/menu/data_layer/data_sources/menu_remote_data_source.dart';
import 'package:albaraka_management/src/modules/offers/data_layer/models/coupon_model.dart';
import 'package:albaraka_management/src/modules/offers/domain_layer/entities/coupon.dart';
import 'package:albaraka_management/src/modules/offers/domain_layer/entities/discount.dart';
import 'package:albaraka_management/src/modules/offers/domain_layer/entities/free_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../menu/data_layer/models/product_model.dart';
import '../../../menu/domain_layer/entities/product.dart';

abstract class BaseOffersRemoteDataSource {
  Future<Either<FirebaseException, dynamic>> addDiscount(
      {required int id,
      required Discount discount,
      required int collectionIndex});
  Future<Either<FirebaseException, dynamic>> addFreeProduct(
      {required FreeProduct freeProduct,
      required int id,
      required int collectionIndex});
  Future<Either<FirebaseException, dynamic>> removeOffer(
      {required int id,
      required ProductModel productModel,
      required int collectionIndex});
  Future<Either<FirebaseException, dynamic>> addCoupon(
      {required CouponModel couponModel});
  Future<Either<FirebaseException, dynamic>> removeCoupon({required String id});
  Future<Either<FirebaseException, List<Coupon>>> getCoupons();
  Future<Either<Exception, List<ProductModel>>> getKoshary();
  Future<Either<Exception, List<ProductModel>>> getMashweyat();
  Future<Either<Exception, List<ProductModel>>> getHalaweyat();
}

class OffersRemoteDataSource extends BaseOffersRemoteDataSource {
  @override
  Future<Either<FirebaseException, dynamic>> addDiscount(
      {required int id,
      required Discount discount,
      required int collectionIndex}) async {
    discount.productModel.offerState = ' خصم ${discount.discount}%';

    discount.productModel.newPrice =
        discount.productModel.oldPrice - (  discount.productModel.oldPrice  * (discount.discount / 100));
    discount.productModel.offerDetails = 'اشتري ${discount.productModel.name} و احصل على ${discount.discount} % خصم';
    try {
      _updateProduct(collectionIndex, discount.productModel, id);
   print ('discount from data source ' + discount.productModel.toString());
      return const Right(0);
    } on FirebaseException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<FirebaseException, dynamic>> removeOffer(
      {required int id,
      required ProductModel productModel,
      required int collectionIndex}) async {
    try {
      productModel.offerState = null;
      productModel.offerDetails = null ;
      productModel.newPrice = productModel.oldPrice;
      productModel.quantity = null;

      await _updateProduct(collectionIndex, productModel, id);
      return const Right(0);
    } on FirebaseException catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<FirebaseException, dynamic>> addCoupon(
      {required CouponModel couponModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection('coupons')
          .doc(couponModel.text)
          .set(couponModel.toJson());
      return const Right(true);
    } on FirebaseException catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<FirebaseException, dynamic>> removeCoupon(
      {required String id}) async {
    try {
      await FirebaseFirestore.instance.doc('coupons/$id').delete();
      return const Right(true);
    } on FirebaseException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<FirebaseException, List<Coupon>>> getCoupons() async {
    List<Coupon> coupons = [];
    try {
      await FirebaseFirestore.instance
          .collection('coupons')
          .get()
          .then((value) {
        for (var element in value.docs) {
          coupons.add(CouponModel.fromJson(element.data()));
        }
      });
      return Right(coupons);
    } on FirebaseException catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<FirebaseException, dynamic>> addFreeProduct (
      {required FreeProduct freeProduct,
      required int id,
      required int collectionIndex}) async {

    freeProduct.product.offerState = '${freeProduct.quantity} +هدية ';

    freeProduct.product.offerDetails = 'اشتري ${freeProduct.quantity} و احصل على ${freeProduct.offerDetails}';
    freeProduct.product.quantity = freeProduct.quantity;
    try {
      await _updateProduct(collectionIndex, freeProduct.product, id);

      return const Right(0);
    } on FirebaseException catch (e) {
      return Left(e);
    }
  }

  List<String> collectionNames = ["koshary", "mashweyat", "halaweyat"];
  List<String> kosharyId = [];
  List<ProductModel> koshary = [];
  List<String> mashweyatId = [];
  List<ProductModel> mashweyat = [];
  List<String> halaweyatId = [];
  List<ProductModel> halaweyat = [];

  @override
  Future<Either<Exception, List<ProductModel>>> getKoshary() async {
    return _getCollection(collectionIndex: 0);
  }

  Future<Either<Exception, List<ProductModel>>> getMashweyat() async {
    return _getCollection(collectionIndex: 1);
  }

  Future<Either<Exception, List<ProductModel>>> getHalaweyat() async {
    print ('getHalaweyat data source ');
    return _getCollection(collectionIndex: 2);
  }

  /// private methods
  Future<dynamic> _updateProduct(
      int collectionIndex, ProductModel productModel, int id) async {
    if (collectionIndex == 0) {
      await FirebaseFirestore.instance
          .collection("koshary")
          .doc(kosharyId[id])
          .set(productModel.toJson());
    } else if (collectionIndex == 1) {
      await FirebaseFirestore.instance
          .collection("mashweyat")
          .doc(mashweyatId[id])
          .set(productModel.toJson());
    } else if (collectionIndex == 2) {
      await FirebaseFirestore.instance
          .collection("halaweyat")
          .doc(halaweyatId[id])
          .set(productModel.toJson());
    }
  }

  Future<Either<Exception, List<ProductModel>>> _getCollection(
      {required int collectionIndex}) async {
    if (collectionIndex == 0) {
      kosharyId = [];
      koshary = [];
      try {
        await FirebaseFirestore.instance
            .collection("koshary")
            .get()
            .then((value) {
          value.docs.forEach((element) {
            ProductModel productModel = ProductModel.fromJson(element.data());

              koshary.add(productModel);
              kosharyId.add(element.id);

          });
        });

        return Right(koshary);
      } on Exception catch (error) {
        return Left(error);
      }
    } else if (collectionIndex == 1) {
      mashweyatId = [];
      mashweyat = [];
      try {
        await FirebaseFirestore.instance
            .collection("mashweyat")
            .get()
            .then((value) {
          value.docs.forEach((element) {
            ProductModel productModel = ProductModel.fromJson(element.data());

              mashweyat.add(productModel);
              mashweyatId.add(element.id);

          });
        });

        return Right(mashweyat);
      } on Exception catch (error) {
        return Left(error);
      }
    } else {
      halaweyatId = [];
      halaweyat = [];
      try {
        await FirebaseFirestore.instance
            .collection("halaweyat")
            .get()
            .then((value) {
          value.docs.forEach((element) {
            ProductModel productModel = ProductModel.fromJson(element.data());

              halaweyat.add(productModel);
              halaweyatId.add(element.id);

          });
        });

        return Right(halaweyat);
      } on Exception catch (error) {
        return Left(error);
      }
    }
  }
}

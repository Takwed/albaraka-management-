import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../menu/data_layer/models/product_model.dart';
import '../../data_layer/models/coupon_model.dart';
import '../entities/coupon.dart';
import '../entities/discount.dart';
import '../entities/free_product.dart';

abstract class BaseOffersRepository {
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
